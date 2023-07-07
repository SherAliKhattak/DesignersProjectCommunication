// ignore_for_file: non_constant_identifier_names

import 'dart:developer';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elabd_project/components/snackbar.dart';
import 'package:elabd_project/data/controllers/registration_controller.dart';
import 'package:elabd_project/models/chat_contact.dart';
import 'package:elabd_project/models/designers_model.dart';
import 'package:elabd_project/models/project_model.dart';
import 'package:elabd_project/screens/dashboard/bottom_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../models/messages_model.dart';
import '../controllers/project_controller.dart';

class FirebaseDB {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  /// [function_for_sending_designer_info_to_firebase] ///

  Future sendUserDataToFirebase() async {
    if (RegistrationController.i.file != null) {
      await storeProfileImage("profilePic/${_firebaseAuth.currentUser!.uid}",
              RegistrationController.i.file!)
          .then((value) async{
        RegistrationController.i.designer.image = value;
      });
      await _firestore
          .collection('designers')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .set(DesignersModel(
                  name: RegistrationController.i.username.text,
                  email: RegistrationController.i.email.text,
                  bio: RegistrationController.i.bio.text,
                  experience: RegistrationController.i.experience.text,
                  createdAt: DateTime.now(),
                  image: RegistrationController.i.designer.image,
                  uid: FirebaseAuth.instance.currentUser!.uid)
              .toFirebase()).whenComplete(() =>  FirebaseDB().getCurrentUserFromFirebase());

      
    } else {
      showSnackbar(
          context: Get.context,
          content:
              'Please Enter the required fields and upload your profile pic',
          color: Colors.black);
    }
  }
  /// [function_for_getting_designers_from_firebase_and_displaying_them_in_a_list_view_builder]
  Stream<List<DesignersModel>> getDesigners() {
    return FirebaseFirestore.instance
        .collection('designers')
        .snapshots()
        .asyncMap((event) async {
      List<DesignersModel> designers = [];
      for (var i in event.docs) {
        var designer = DesignersModel.fromJson(i);
        designers.addIf(
            designer.uid != FirebaseAuth.instance.currentUser!.uid, designer);
        log(designers.toString());
      }
      return designers;
    });
  }
  /// [creating_project_and_storing_them_in_firebase] ///
  Future AddProject() async {
    _firestore
        .collection('projects')
        .doc()
        .set(ProjectModel(
                title: ProjectController.i.projectTitle.text,
                description: ProjectController.i.description.text,
                status: ProjectController.i.status.text,
                budget: ProjectController.i.budget.text,
                startDate: ProjectController.i.start.text,
                endDate: ProjectController.i.end.text,
                designersModel: DesignersModel(
                    uid: FirebaseAuth.instance.currentUser!.uid,
                    name: RegistrationController.i.designer.name,
                    image: RegistrationController.i.designer.image,
                    bio: RegistrationController.i.designer.bio,
                    email: RegistrationController.i.designer.email))
            .toFirebase())
        .then((value) => showSnackbar(
            context: Get.context,
            content: 'Project Added Successfully',
            color: Colors.green)).whenComplete(() => Get.off(()=>const ReturnNavigationBar()));
  }
  /// [function_for_displaying_projects_in_firebase] ///
  Stream<List<ProjectModel>> displayProjects() {
    return FirebaseFirestore.instance
        .collection('projects')
        .snapshots()
        .asyncMap((event) {
      List<ProjectModel> projects = [];
      for (var i in event.docs) {
        var project = ProjectModel.fromJson(i);
        projects.add(project);
        log(projects.toString());
      }
      return projects;
    });
  }
  /// [function_for_storing_profile_in_firebase_storage] ///
  Future<String> storeProfileImage(String ref, File file) async {
    UploadTask uploadTask = _storage.ref().child(ref).putFile(file);
    TaskSnapshot taskSnapshot = await uploadTask;
    String downloadUrl = await taskSnapshot.ref.getDownloadURL();
    return downloadUrl;
  }

  /// [function_for_getting_current_user_from_firebase] ///

  Future getCurrentUserFromFirebase() async {
    await FirebaseFirestore.instance
        .collection('designers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      RegistrationController.i.designer = DesignersModel.fromJson(value);
      log(RegistrationController.i.designer.toString());
    });
  }
  /// [function_for_updating_a_particular_field_in_firebase] ///
  Future updateUserData(String key, String value) {
    return FirebaseFirestore.instance
        .collection('designers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({key: value});
  }
  /// [function_for_getting_the_chatrooms_of_a_particular_designer_and_display_them_in_the_chat] ///
  Stream<List<ChatContact>> getAllChats()  {
   return FirebaseFirestore.instance
        .collection('designers')
        .doc(_firebaseAuth.currentUser!.uid)
        .collection('chats')
        .snapshots()
        .asyncMap((event) {
      List<ChatContact> chats = [];
      for (var i in event.docs) {
        ChatContact contact = ChatContact.fromJson(map: i);
        chats.add(contact);
      }
      return chats;
    });
  }
  // function for display the chats of 2 designers
  Stream<List<Messages>> getIndividualChats(String receiverUid) {
    return FirebaseFirestore.instance
        .collection('designers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chats')
        .doc(receiverUid)
        .collection('messages')
        .orderBy('date')
        .snapshots()
        .map((event) {
      List<Messages> messages = [];
      for (var document in event.docs) {
        messages.add(Messages.fromJson(document.data()));
      }
      return messages;
    });
  }
}
