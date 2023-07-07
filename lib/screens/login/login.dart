import 'package:elabd_project/components/custom_text_field.dart';
import 'package:elabd_project/data/controllers/registration_controller.dart';
import 'package:elabd_project/data/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../components/images.dart';
import '../../components/primary_button.dart';
import '../sign_up/sign_up.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
    final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    Get.put(RegistrationController());
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Login Screen'),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: GetBuilder<RegistrationController>(
        builder: (login) {
          return  login.isLoading == false ? Padding(
            padding: const EdgeInsets.all(20.0),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Image.asset(
                    Images.logo,
                    height: 200,
                    width: 200,
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                   CustomTextField(
                    validation: (value){
                      if(!value!.isEmail)
                      {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                    controller: email,
                    borderRadius: 10,
                    title: 'Email',
                    prefixIcon: const Icon(Icons.email),
                    hintText: 'Email',
                  ),
                  SizedBox(
                    height: Get.height * 0.02,
                  ),
                   CustomTextField(
                    validation: (p0) {
                      if(p0!.isEmpty)
                      {
                        return 'Please enter a valid password';
                      }
                      return null;
                    },
                    controller: password,
                    borderRadius: 10,
                    title: 'Password',
                    prefixIcon: const Icon(Icons.lock),
                    suffixIconData: const Icon(Icons.visibility),
                    hintText: 'Password',
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Don’t have an account?',
                        style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
                      ),
                      TextButton(
                          onPressed: () {
                            Get.to(() => const Signup());
                          },
                          child: const Text('Sign up')),
                    ],
                  ),
                  PrimaryButon(
                    title: 'Login',
                    width: Get.width,
                    onPressed: (){
                      if(_formKey.currentState!.validate())
                      {
                        AuthService().login(email.text, password.text, context);
                      }
                    },
                    height: Get.height * 0.061,
                  )
                ],
              ),
            ),
          ) : const Center(child: CircularProgressIndicator(),);
        }
      ),
    );
  }
}
