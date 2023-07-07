import 'package:elabd_project/components/primary_button.dart';
import 'package:elabd_project/data/controllers/registration_controller.dart';
import 'package:flutter/material.dart';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';


class AlertDialogue {
  static Future<dynamic> rename(BuildContext context, String? infotype,
      String value, TextEditingController controller) {
    return Get.dialog(Container(
      margin: const EdgeInsets.all(1),
      child: AlertDialog(
        contentPadding: const EdgeInsets.all(10.0),
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
        backgroundColor: Theme.of(context).cardColor,
        title: Padding(
          padding: const EdgeInsets.only(
            right: 50.0,
          ),
          child: Text(
            infotype!,
          
          ),
        ),
        titleTextStyle: TextStyle(
          fontFamily: 'Roboto',
          fontSize: 20.0,
          color: Theme.of(context).primaryColorDark,
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: controller,
              minLines: 1,
              maxLines: 1,
              decoration: InputDecoration(
                  isCollapsed: true,
                  // Added this
                  contentPadding: const EdgeInsets.all(8),
                  isDense: true,
                  border: const OutlineInputBorder(),
                  //  <- you can it to 0.0 for no space

                  enabledBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey)),
                  focusedBorder: const UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.blueAccent)),
                  suffix: const IconButton(
                    onPressed: null,
                    icon: Icon(
                      FontAwesomeIcons.circleXmark,
                      size: 15.0,
                    ),
                  ),
                  suffixIconConstraints:
                      const BoxConstraints(maxWidth: 32, maxHeight: 32),
                  hintStyle: TextStyle(color: Theme.of(context).hintColor),
                  hintText: value),
            ),
          ],
        ),
        buttonPadding: const EdgeInsets.only(right: 50.0, bottom: 100.0),
        actions: [
          SizedBox(
              height: 40, //height of button
              width: 100,
              child: PrimaryButon(title: 'Cancel',onPressed: (){},)),
          GetBuilder<RegistrationController>(builder: (authController) {
            return SizedBox(
                width: 100.0,
                height: 40.0,
                child: PrimaryButon(title: 'Update', onPressed: () {
                  RegistrationController.i.updateUserInfo(infotype, controller.text);
                },));
          })
        ],
      ),
    ));
  }
}
