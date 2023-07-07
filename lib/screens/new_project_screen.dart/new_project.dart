import 'dart:developer';

import 'package:elabd_project/components/custom_text_field.dart';
import 'package:elabd_project/components/primary_button.dart';
import 'package:elabd_project/data/controllers/project_controller.dart';
import 'package:elabd_project/data/services/firebase_db.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NewProject extends StatefulWidget {
  const NewProject({super.key});

  @override
  State<NewProject> createState() => _NewProjectState();
}

class _NewProjectState extends State<NewProject> {
  @override
  void dispose() {
    ProjectController.i.projectTitle.clear();
    ProjectController.i.description.clear();
    ProjectController.i.status.clear();
    ProjectController.i.budget.clear();
    ProjectController.i.start.clear();
    ProjectController.i.end.clear();
        super.dispose();
  }
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('New Project'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: ListView(
            shrinkWrap: true,
            children: [
               CustomTextField(
                validation: (value){
                  if(value!.isEmpty)
                  {
                    return 'Enter the title for your project';
                  }
                  return null;
                },
                controller: ProjectController.i.projectTitle,
                borderRadius: 10,
                title: 'Project Title',
                hintText: 'Project Title',
                prefixIcon: const Icon(Icons.lightbulb_outline),
                sizedBox: true,
              ),
               CustomTextField(
                validation: (value){
                  if(value!.isEmpty)
                  {
                    return 'Please enter the description';
                  }
                  return null;
                },
                controller: ProjectController.i.description,
                borderRadius: 10,
                title: 'Project Description',
                hintText: '\nProject description',
                prefixIcon: const Icon(Icons.description),
                maxLines: 3,
                sizedBox: true,
                keyBoardType: TextInputType.multiline,
              ),
               CustomTextField(
                validation: (value) {
                  if(value!.isEmpty)
                  {
                    return 'Please enter your status';
                  }
                  return null;
                },
                controller: ProjectController.i.status,
                borderRadius: 10,
                title: 'Status',
                hintText: 'Status',
                prefixIcon: const Icon(Icons.pause_circle_outline),
                sizedBox: true,
              ),
               CustomTextField(
                validation: (value){
                  if(value!.isEmpty)
                  {
                    return 'Budget is Empty';
                  }
                  return null;
        
                },
                controller: ProjectController.i.budget,
                borderRadius: 10,
                title: 'Budget ',
                hintText: 'Budget',
                prefixIcon: const Icon(Icons.monetization_on),
                keyBoardType: TextInputType.number,
                sizedBox: true,
              ),
              CustomTextField(
                validation: (value) {
                  if(value!.isEmpty){
                    return 'Start Date is empty';
                  }
                 
                },
                controller: ProjectController.i.start,
                borderRadius: 10,
                title: 'Start Date',
                hintText: 'Start Date',
                prefixIcon: const Icon(Icons.date_range),
                keyBoardType: TextInputType.datetime,
                sizedBox: true,
                suffixIconData: IconButton(
                    onPressed: () {
                      ProjectController.i.selectDateAndTime(
                        context,
                        ProjectController.startDate,
                        ProjectController.i.formatStartDate,
                        ProjectController.i.start
                      );
                    },
                    icon: const Icon(Icons.add)),
              ),
               CustomTextField(
                validation: (value) {
                  if(value!.isEmpty)
                  {
                    return 'End Date is Empty';
                  }
                 
                  return null;
                },
                controller: ProjectController.i.end,
                borderRadius: 10,
                title: 'End Date',
                hintText: 'End Date',
                prefixIcon:const  Icon(Icons.date_range),
                keyBoardType: TextInputType.datetime,
                sizedBox: true,
                suffixIconData: IconButton(
                    onPressed: () async{
                     await ProjectController.i.selectDateAndTime(
                        context,
                        ProjectController.endDate,
                        ProjectController.i.formatDeparture,
                        ProjectController.i.end
                      );
                      log('${ProjectController.i.end.text} controller value',);
                    },
                    icon: const Icon(Icons.add)),
              ),
              SizedBox(
                height: Get.height * 0.03,
              ),
              PrimaryButon(
                title: 'Submit',
                onPressed: () async{
                 if(formKey.currentState!.validate())
                 {
                  FirebaseDB().AddProject();
                 }
                 log('message');
                },
                height: Get.height * 0.06,
              )
            ],
          ),
        ),
      ),
    );
  }
}
