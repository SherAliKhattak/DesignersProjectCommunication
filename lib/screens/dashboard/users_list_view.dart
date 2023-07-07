import 'package:elabd_project/data/controllers/registration_controller.dart';
import 'package:elabd_project/models/chat_contact.dart';
import 'package:elabd_project/models/designers_model.dart';
import 'package:elabd_project/utils/chat_screen_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../chat_screen/chat_screen.dart';

class UsersListview extends StatelessWidget {
 
  final ChatContact chat;

  const UsersListview({
    Key? key, required this.chat,
    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:  BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20)
      ),
      height: 100,
      margin: const EdgeInsets.all(5),
      child: GestureDetector(
        onTap: () async {
          Get.to(() =>  ChatScreen(
                currentDesigner: DesignersModel(
                  uid: FirebaseAuth.instance.currentUser!.uid,
                  name: RegistrationController.i.designer.name,
                ),
                targetDesigner: DesignersModel(
                  uid: chat.contactId,
                  name: chat.name
                ),
              ));
        },
        child: ListTile(
          contentPadding: const EdgeInsets.only(left: 20, top: 10),
          shape:
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
          leading: CircleAvatar(
            radius: 20,
            backgroundImage: chat.profilePic != null? NetworkImage(chat.profilePic!) : null 
          ),
          title:  Text(
            chat.name!
            
          ),
          subtitle:chat.lastMessage!=null ? Text(chat.lastMessage!) : const SizedBox(),
          trailing: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Column(
              children:  [
                Expanded(
                    child: Text(
                  ChatScreenUtils.formatTime(chat.timeSent.toString()),
                  ),
                )
                // const Expanded(
                //     child: Icon(
                //   Icons.done_all,
                //   color: Colors.green,
                // )),
              ],
            ),
          ),
        ),
      ),
    );
  }
}