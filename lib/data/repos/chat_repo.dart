import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:elabd_project/data/services/firebase_db.dart';
import 'package:elabd_project/models/designers_model.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:uuid/uuid.dart';
import '../../components/enums.dart';
import '../../components/snackbar.dart';
import '../../models/chat_contact.dart';
import '../../models/messages_model.dart';

var uuid = const Uuid();

class ChatRepo {
  final _firestore = FirebaseFirestore.instance;

  // function for sending message and saving in firebase
  void sendTextMessage(BuildContext context, String text, String receiverUserId,
      DesignersModel senderUser) async {
    try {
      log('message is sent');
      var timeSent = DateTime.now();
      DesignersModel receiverUserData;
      var userDataMap =
          await _firestore.collection('designers').doc(receiverUserId).get();
      receiverUserData = DesignersModel.fromJson(userDataMap.data());
      log(receiverUserData.name!);
      // In order to show the last message of a chat between 2 designers
      saveDatatoContactsSubcollection(
          senderUser, receiverUserData, text, timeSent, receiverUserId);
      // for saving message to messages sub collection
      saveMessagetoMessages(
          messageType: MessageEnum.text,
          messageId: uuid.v1(),
          receiverUserId: receiverUserId,
          receiverUserName: receiverUserData.name!,
          text: text,
          timeSent: timeSent,
          userName: senderUser.name!);
    } catch (e) {
      showSnackbar(
          context: Get.context, content: e.toString(), color: Colors.black);
      log(e.toString());
    }
  }

  //
  saveDatatoContactsSubcollection(
      DesignersModel senderUserData,
      DesignersModel receiverUserData,
      String text,
      DateTime timeSent,
      String receiverUserId) async {
    var receiverChatContact = ChatContact(
        name: senderUserData.name,
        profilePic: senderUserData.image,
        contactId: senderUserData.uid,
        timeSent: timeSent,
        lastMessage: text);

    await _firestore
        .collection('designers')
        .doc(receiverUserId)
        .collection('chats')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .set(receiverChatContact.toMap());

    var senderChatContact = ChatContact(
        name: receiverUserData.name,
        profilePic: receiverUserData.image,
        contactId: receiverUserData.uid,
        timeSent: timeSent,
        lastMessage: text);

    await _firestore
        .collection('designers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chats')
        .doc(receiverUserId)
        .set(senderChatContact.toMap());
  }

  // function for saving messages to messages collection
  saveMessagetoMessages(
      {required String receiverUserId,
      required String text,
      required DateTime timeSent,
      required String messageId,
      required String userName,
      required String receiverUserName,
      required MessageEnum messageType}) async {
    log('message saved');
    final message = Messages(
        senderId: FirebaseAuth.instance.currentUser!.uid,
        receiverId: receiverUserId,
        message: text,
        type: messageType,
        date: timeSent,
        messageId: messageId,
        isSeen: false);
    log('message is being saved');
    await _firestore
        .collection('designers')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('chats')
        .doc(receiverUserId)
        .collection('messages')
        .doc(messageId)
        .set(message.toJson());

    await _firestore
        .collection('designers')
        .doc(receiverUserId)
        .collection('chats')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection('messages')
        .doc(messageId)
        .set(message.toJson());
  }

  // function for sending video or image file to firebase.
  Future sendImageFile(
      {required BuildContext context,
      File? file,
      required String receiverUid,
      DesignersModel? sendUserData,
      MessageEnum? messageEnum}) async {
    try {
      var timeSent = DateTime.now();
      var messageId = uuid.v1();
      // first send the file to firebase Storage
      String imageUrl = await FirebaseDB().storeProfileImage(
          'chat/${messageEnum!.type}/${sendUserData!.uid}/$receiverUid/$messageId',
          file!);

      DesignersModel receiverUserData;
      var userDataMap = await FirebaseFirestore.instance
          .collection('designers')
          .doc(receiverUid)
          .get();
      receiverUserData = DesignersModel.fromJson(userDataMap.data());
      //
      String contactMessage;
      // function to show the type of message in chats sub collection
      switch (messageEnum) {
        case MessageEnum.image:
          contactMessage = '📸 photo';
          break;
        case MessageEnum.video:
          contactMessage = '🎥 video';
          break;
        default:
          contactMessage = 'GIF';
      }

      saveDatatoContactsSubcollection(sendUserData, receiverUserData,
          contactMessage, timeSent, receiverUid);
      // save the file message to messages sub collection to messages sub collection
      saveMessagetoMessages(
          receiverUserId: receiverUid,
          text: imageUrl,
          timeSent: timeSent,
          messageId: messageId,
          userName: sendUserData.name!,
          receiverUserName: receiverUserData.name!,
          messageType: messageEnum);
    } catch (e) {
      showSnackbar(
          context: context,
          content: 'error is here ${e.toString()}',
          color: Colors.black);
    }
  }
}
