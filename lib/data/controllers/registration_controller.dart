import 'dart:developer';
import 'dart:io';
import 'package:elabd_project/data/services/firebase_db.dart';
import 'package:elabd_project/models/designers_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../components/snackbar.dart';

class RegistrationController extends GetxController implements GetxService {
  File? file;
    // text Editing Controllers for creating a new user
  
  late TextEditingController username;
  late TextEditingController email;
  late TextEditingController bio;
  late TextEditingController description;
  late TextEditingController experience;
  late TextEditingController password;
  late TextEditingController confirmPass;
  bool isLoading = false;
  bool isSignedIn = false;
  DesignersModel designer = DesignersModel();

  @override
  void onInit() {
    username = TextEditingController();
    email = TextEditingController();
    bio = TextEditingController();
    description = TextEditingController();
    experience = TextEditingController();
    password = TextEditingController();
    confirmPass = TextEditingController();

    super.onInit();
  }

  @override
  void onClose() {
    username.dispose();
    email.dispose();
    bio.dispose();
    description.dispose();
    experience.dispose();
    password.dispose();
    confirmPass.dispose();

    super.onClose();
  }

  loading(bool loading) {
    isLoading = loading;
    update();
  }

 // file picker
  Future<File?> pickImage(
    {
    FileType? type = FileType.image,
    BuildContext? context,}
  ) async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: type!);
      if (result != null) {
        file = File(result.files.first.path!);
      }
    } catch (e) {
      showSnackbar(content: e.toString(), color: Colors.red, context: context);
      log(e.toString());
    }
    update();
    return file;
  }
  // function for updating profile info
  updateUserInfo(String infoType, String value) async {
    await FirebaseDB().updateUserData(infoType, value);
    await FirebaseDB()
        .getCurrentUserFromFirebase();
    update();
    Get.back();
  }
  // function for updating profile pic
  updateProfilePic(BuildContext context) async {
    file = await pickImage(context: context, type: FileType.image);
    if (file != null) {
      loading(true);
      String result = await FirebaseDB().storeProfileImage(
          "profilePic/${FirebaseAuth.instance.currentUser!.uid}", file!);
      await FirebaseDB().updateUserData('image', result);
      await FirebaseDB()
          .getCurrentUserFromFirebase();
      loading(false);
    } else {}
    update();
  }

  static RegistrationController get i => Get.put(RegistrationController());
}
