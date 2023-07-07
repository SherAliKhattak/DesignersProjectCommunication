// ignore_for_file: use_build_context_synchronously

import 'dart:developer';
import 'dart:io';

import 'package:elabd_project/components/custom_text_field.dart';
import 'package:elabd_project/components/snackbar.dart';
import 'package:elabd_project/data/controllers/registration_controller.dart';
import 'package:elabd_project/models/designers_model.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:grouped_list/grouped_list.dart';
import 'package:intl/intl.dart';

import '../../components/enums.dart';
import '../../components/message_type.dart';
import '../../data/repos/chat_repo.dart';
import '../../data/repos/payment_repo.dart';
import '../../data/services/firebase_db.dart';
import '../../models/messages_model.dart';
import '../../utils/chat_screen_utils.dart';
import '../../utils/file_extensions.dart';

class ChatScreen extends StatefulWidget {
  final DesignersModel? currentDesigner;
  final DesignersModel? targetDesigner;
  const ChatScreen({super.key, this.currentDesigner, this.targetDesigner});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  TextEditingController controller = TextEditingController();

  // send message on button Click

  sendMessage() async {
    if (controller.text.isNotEmpty) {
      ChatRepo().sendTextMessage(context, controller.text,
          widget.targetDesigner!.uid!, widget.currentDesigner!);
      log('pressed');
    }
    controller.clear();
    log('message sent');
  }

  // send File message
  sendFileMessage(
    File? file,
    MessageEnum messageEnum,
  ) {
    try {
      ChatRepo().sendImageFile(
          context: context,
          receiverUid: widget.targetDesigner!.uid!,
          file: file,
          messageEnum: messageEnum,
          sendUserData: widget.currentDesigner);
    } catch (e) {
      showSnackbar(
          context: Get.context!, content: e.toString(), color: Colors.black);
    }
  }

  // for selecting required file
  selectFile() async {
    File? file = await RegistrationController.i
        .pickImage(context: context, type: FileType.any);
    log(file!.path);
    if (FileUtils.isrequiredImageExtension(file)) {
      sendFileMessage(file, MessageEnum.image);
    } else if (FileUtils.isrequiredVideoExtension(file)) {
      sendFileMessage(file, MessageEnum.video);
    } else {
      showSnackbar(
          context: context,
          content: 'This file is not allowed to send',
          color: Colors.black);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(widget.targetDesigner!.name!),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            StreamBuilder<List<Messages>>(
                stream: FirebaseDB()
                    .getIndividualChats(widget.targetDesigner!.uid!),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: GroupedListView<Messages, DateTime>(
                        shrinkWrap: true,
                        groupBy: (messages) => DateTime(
                          messages.date!.year,
                          messages.date!.month,
                          messages.date!.day,
                        ),
                        groupHeaderBuilder: (element) => SizedBox(
                          height: 40,
                          child: Center(
                              child: Text(
                            ChatScreenUtils.formatTime(
                              element.date.toString(),
                            ),
                            style: const TextStyle(color: Colors.grey),
                          )),
                        ),
                        groupSeparatorBuilder: (groupByValue) =>
                            const Divider(),
                        itemBuilder: (context, Messages message) => Column(
                          crossAxisAlignment: 
                              ChatScreenUtils().isSentbyme(message)
                                  ? CrossAxisAlignment.end
                                  : CrossAxisAlignment.start,
                          children: [
                            Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius:
                                      ChatScreenUtils().borderSide(message)),
                              color: ChatScreenUtils().isSentbyme(message)
                                  ? Theme.of(context).primaryColor
                                  : Theme.of(context).secondaryHeaderColor,
                              elevation: 2,
                              child: Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: MessageType(
                                    message: message,
                                    type: message.type,
                                  )),
                            ),
                            Align(
                              alignment: ChatScreenUtils().isSentbyme(message)
                                  ? Alignment.centerRight
                                  : Alignment.centerLeft,
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: Text(
                                  DateFormat('hh:mm a').format(message.date!),
                                  style: const TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                ),
                              ),
                            ),
                          ],
                        ),
                        order: GroupedListOrder.ASC,
                        elements: snapshot.data!,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      controller: controller,
                      borderRadius: 10,
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.02,
                  ),
                  GestureDetector(
                      onTap: () => selectFile(),
                      child: const Icon(
                        FontAwesomeIcons.paperclip,
                      )),
                  SizedBox(
                    width: Get.width * 0.02,
                  ),
                  InkWell(
                    onTap: () => sendMessage(),
                    child: const CircleAvatar(
                      radius: 25,
                      child: Center(
                        child: Icon(
                          FontAwesomeIcons.paperPlane,
                          size: 18,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: Get.width * 0.01,
                  ),
                  InkWell(
                    onTap: () => makePayment(),
                    child: const CircleAvatar(
                      radius: 25,
                      child: Center(
                        child: Icon(
                          FontAwesomeIcons.paypal,
                          size: 18,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
