// ignore_for_file: unrelated_type_equality_checks

import 'dart:developer';
import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:elabd_project/components/enums.dart';
import 'package:elabd_project/components/video_player_widget.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../models/messages_model.dart';
import 'image_viewr.dart';

class MessageType extends StatelessWidget {
  final Messages? message;
  final MessageEnum? type;
  const MessageType({super.key, this.message, this.type});

  @override
  Widget build(BuildContext context) {
    if (type == MessageEnum.image) {
      log('this is executed');
      return GestureDetector(
        // for displaying images this widget is used if message type is image
        onTap: () => Get.to(() => ImageViewer(imageUrl: message!.message!)),
        child: Stack(
          children: [
            CachedNetworkImage(
              imageUrl: message!.message!,
              width: Get.width * 0.5,
              fit: BoxFit.fill,
              key: UniqueKey(),
            ),
          ],
        ),
      );
    } else if (message!.type == MessageEnum.text) {
      return Text(
        message!.message!,
        style:  TextStyle(color: message!.isSentByme! == true? Colors.white : Colors.black),
        
      );
    
    }
      else if (message!.type == MessageEnum.video) {
      log('i am over here');
      return VideoPlayerWidget(
        videoUrl: message!.message!,
      );
    }
      else {
              return const SizedBox();

      }

  }
}
