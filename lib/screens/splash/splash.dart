import 'dart:async';
// import 'package:all_document_reader/controllers/home_screen_controller.dart';
import 'package:elabd_project/components/snackbar.dart';
import 'package:elabd_project/data/services/firebase_db.dart';
import 'package:elabd_project/screens/dashboard/bottom_nav_bar.dart';
import 'package:elabd_project/screens/login/login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/images.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool visible = false;
  @override
  void initState() {
    Future.delayed(const Duration(microseconds: 100), () {
      setState(() {
        visible = !visible;
      });
    });

    Timer(const Duration(seconds: 6), () {
      FirebaseAuth.instance.authStateChanges().listen((User? user) {
        if (user == null) {
          showSnackbar(
              context: Get.context,
              content: 'User is currently Signed out',
              color: Colors.black);

          Get.offAll(() => const LoginScreen());
        } else {
          showSnackbar(
              context: Get.context,
              content: 'User is Signed in',
              color: Colors.green);
          FirebaseDB().getCurrentUserFromFirebase().then((value) {
            Get.offAll(() => const ReturnNavigationBar());
          });
        }
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColorDark,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: AnimatedOpacity(
              duration: const Duration(seconds: 4),
              opacity: visible ? 1.0 : 0.0,
              child: ClipRRect(
                  child: Image.asset(
                Images.logo,
                height: 200,
              )),
            ),
          ),
        ],
      ),
      bottomNavigationBar: AnimatedOpacity(
        duration: const Duration(seconds: 6),
        opacity: visible ? 1.0 : 0.0,
        child: Padding(
          padding: const EdgeInsets.only(bottom: 50),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'App',
                style: TextStyle(
                    fontSize: 25,
                    color: Theme.of(context).secondaryHeaderColor),
              ),
              Text('Name',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                      color: Theme.of(context).secondaryHeaderColor)),
            ],
          ),
        ),
      ),
    );
  }
}
