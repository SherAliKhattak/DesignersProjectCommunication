import 'package:elabd_project/components/primary_button.dart';
import 'package:elabd_project/components/snackbar.dart';
import 'package:elabd_project/data/controllers/registration_controller.dart';
import 'package:elabd_project/data/services/auth_service.dart';
import 'package:elabd_project/screens/login/login.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/custom_text_field.dart';
import '../../components/images.dart';

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  Widget build(BuildContext context) {
    var controller = Get.put(RegistrationController());
    final formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign Up'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: GetBuilder<RegistrationController>(
          builder: (reg) {
            return reg.isLoading == true
                ? const Center(child: CircularProgressIndicator())
                : Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: SingleChildScrollView(
                      child: Form(
                        key: formKey,
                        child: Column(
                          children: [
                            InkWell(
                              onTap: () {
                                reg.pickImage(context: context, type: FileType.image);
                              },
                              child: reg.file == null
                                  ? const CircleAvatar(
                                      radius: 70,
                                      backgroundImage: AssetImage(Images.man),
                                      child: Icon(
                                        Icons.camera_alt,
                                        size: 30,
                                        color: Colors.white,
                                      ),
                                    )
                                  : CircleAvatar(
                                      radius: 70,
                                      backgroundImage: FileImage(reg.file!),
                                    ),
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            CustomTextField(
                              borderRadius: 10,
                              title: 'Username',
                              prefixIcon: const Icon(Icons.person),
                              hintText: 'Username',
                              controller: RegistrationController.i.username,
                              validation: (p0) {
                                if (p0!.isEmpty) {
                                  return 'Please enter your username';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            CustomTextField(
                              borderRadius: 10,
                              title: 'Email',
                              prefixIcon: const Icon(Icons.email),
                              hintText: 'Email',
                              controller: RegistrationController.i.email,
                              validation: (p0) {
                                if (p0!.isEmpty) {
                                  return 'Please enter your email';
                                } else if (!p0.isEmail) {
                                  return 'Please Enter a valid Email';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            CustomTextField(
                              borderRadius: 10,
                              title: 'Bio',
                              prefixIcon: const Icon(Icons.description_rounded),
                              hintText: 'Enter your bio',
                              keyBoardType: TextInputType.multiline,
                              maxLines: 3,
                              controller: RegistrationController.i.bio,
                              validation: (value) {
                                if (value!.isEmpty) {
                                 return 'Please Enter your bio';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            CustomTextField(
                              borderRadius: 10,
                              title: 'Experience ',
                              prefixIcon: const Icon(Icons.work),
                              hintText: 'Experience as a designer in years',
                              controller: RegistrationController.i.experience,
                              keyBoardType: TextInputType.number,
                              validation: (p0) {
                                if (p0!.isEmpty) {
                                  return 'Enter your Experience';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            CustomTextField(
                              borderRadius: 10,
                              title: 'Password',
                              prefixIcon: const Icon(Icons.lock),
                              hintText: 'Password',
                              suffixIconData: const Icon(Icons.visibility),
                              controller: RegistrationController.i.password,
                              keyBoardType: TextInputType.visiblePassword,
                              validation: (p0) {
                                if (p0!.isEmpty) {
                                  return 'Please enter your password';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: Get.height * 0.02,
                            ),
                            CustomTextField(
                              borderRadius: 10,
                              title: 'Confirm Password',
                              prefixIcon: const Icon(Icons.lock),
                              suffixIconData: const Icon(Icons.visibility),
                              hintText: 'Confirm Password',
                              controller: RegistrationController.i.confirmPass,
                              validation: (p0) {
                                if (RegistrationController.i.password.text !=
                                    RegistrationController.i.confirmPass.text) {
                                  return 'Passwords do not match';
                                } else if (p0!.isEmpty) {
                                  return 'Please Confirm your password';
                                }
                                return null;
                              },
                            ),
                            SizedBox(
                              height: Get.height * 0.01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'Already Have an Account?',
                                  style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.w500),
                                ),
                                TextButton(
                                    onPressed: () {
                                      Get.to(() => const LoginScreen());
                                    },
                                    child: const Text('Sign in'))
                              ],
                            ),
                            PrimaryButon(
                              title: 'Sign Up',
                              width: Get.width,
                              onPressed: () {
                                if (formKey.currentState!.validate() && controller.file !=null) {
                                  AuthService().signUp(
                                      RegistrationController.i.email.text,
                                      RegistrationController.i.password.text).then((value) {
                                      });
                                }
                                if(controller.file == null)
                                {
                                  showSnackbar(context: context,content: 'Upload your image', color: Colors.black);
                                }
                              },
                              height: Get.height * 0.061,
                            )
                          ],
                        ),
                      ),
                    ),
                  );
          }),
    );
  }
}
