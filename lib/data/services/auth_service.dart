import 'dart:developer';

import 'package:elabd_project/components/snackbar.dart';
import 'package:elabd_project/data/controllers/registration_controller.dart';
import 'package:elabd_project/data/services/firebase_db.dart';
import 'package:elabd_project/models/designers_model.dart';
import 'package:elabd_project/screens/dashboard/bottom_nav_bar.dart';
import 'package:elabd_project/screens/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // function for signing up the user

  Future signUp(String email, String password) async {
    try {
      RegistrationController.i.loading(true);
      await _auth
          .createUserWithEmailAndPassword(email: email, password: password)
          .then((value) async {
        await FirebaseDB()
            .sendUserDataToFirebase()
            .whenComplete(() => FirebaseDB().getCurrentUserFromFirebase())
            .whenComplete(() => Get.offAll(() => const ReturnNavigationBar()))
            .then((value) => showSnackbar(
                content: 'Registration Successful', color: Colors.green))
            .then((value) async {});

        RegistrationController.i.loading(false);
      });

      log('Sign up successful');
    } on FirebaseAuthException catch (e) {
      showSnackbar(content: e.code, color: Colors.black, context: Get.context);
      RegistrationController.i.loading(false);
    } catch (e) {
      return e.toString();
    }
  }

  // function for logging in the user
  login(String email, String password, BuildContext context) async {
    try {
      RegistrationController.i.loading(true);
      await _auth
          .signInWithEmailAndPassword(email: email, password: password)
          .then((value) =>
              Get.to(() => const ReturnNavigationBar())!.then((value) {
                FirebaseDB().getCurrentUserFromFirebase();
              }));
      log('message');
      RegistrationController.i.loading(false);
    } on FirebaseAuthException catch (e) {
      log(e.toString());
      showSnackbar(
          color: Colors.black, content: e.toString(), context: context);
      RegistrationController.i.loading(false);
    } catch (e) {
      showSnackbar(
          color: Colors.black, content: e.toString(), context: context);
    }
  }

  // function for signing out the user

  signout() async {
    RegistrationController.i.loading(true);
    await _auth
        .signOut()
        .then((value) => Get.off(() => const LoginScreen()))
        .then((value) => RegistrationController.i.loading(false))
        .then((value) {});
    RegistrationController.i.designer = DesignersModel();
  }
}
