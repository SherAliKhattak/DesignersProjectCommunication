// ignore_for_file: unnecessary_null_comparison

import 'package:elabd_project/components/primary_button.dart';
import 'package:elabd_project/components/snackbar.dart';
import 'package:elabd_project/data/controllers/registration_controller.dart';
import 'package:elabd_project/models/designers_model.dart';
import 'package:elabd_project/models/project_model.dart';
import 'package:elabd_project/screens/chat_screen/chat_screen.dart';
import 'package:elabd_project/utils/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProjectDetails extends StatelessWidget {
  final ProjectModel? pj;
  const ProjectDetails({super.key, this.pj});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Details'),
        centerTitle: true,
      ),
      body: Padding(
        padding:  EdgeInsets.all(paddingDefault(context)),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding:  EdgeInsets.all(paddingDefault(context)),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Project Title',
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Text(
                              '${pj!.title}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.w300),
                            ),
                          ],
                        ),
                        Text(
                          pj!.status!,
                          style: const TextStyle(
                              color: Colors.green, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    const Text(
                      'Description',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '${pj!.description}',
                      style: const TextStyle(fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    const Text(
                      'Budget',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '${pj!.budget} \$',
                      style: const TextStyle(fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    const Text(
                      'Start Date',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '${pj!.startDate}',
                      style: const TextStyle(fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    const Text(
                      'End Date',
                      style: TextStyle(fontWeight: FontWeight.w600),
                    ),
                    Text(
                      '${pj!.endDate}',
                      style: const TextStyle(fontWeight: FontWeight.w300),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        pj!.designersModel!.image! != null
                            ? CircleAvatar(
                                radius: 25,
                                backgroundImage:
                                    NetworkImage(pj!.designersModel!.image!),
                              )
                            : const FlutterLogo(),
                        SizedBox(
                          width: Get.width * 0.02,
                        ),
                        Text(
                          pj!.designersModel!.name!,
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Text(
                      '${pj!.designersModel!.bio}',
                      style: const TextStyle(fontWeight: FontWeight.w300),
                    ),
                    SizedBox(
                      height: Get.height * 0.02,
                    ),
                    Center(
                        child: PrimaryButon(
                      title:
                          'Contact ${pj!.designersModel!.name!.split(' ').first}',
                      onPressed: () {
                        if (pj!.designersModel!.uid! ==
                            FirebaseAuth.instance.currentUser!.uid) {
                          showSnackbar(
                              context: context,
                              content:
                                  'This project has been Created by you. You cannot chat with yourself',
                              color: Colors.black);
                        } else {
                          Get.to(() => ChatScreen(
                                currentDesigner: DesignersModel(
                                    uid: FirebaseAuth.instance.currentUser!.uid,
                                    name:
                                        RegistrationController.i.designer.name),
                                targetDesigner: DesignersModel(
                                    uid: pj!.designersModel!.uid,
                                    name: pj!.designersModel!.name),
                              ));
                        }
                      },
                    ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
