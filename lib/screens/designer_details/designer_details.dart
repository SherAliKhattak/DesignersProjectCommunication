import 'package:elabd_project/components/primary_button.dart';
import 'package:elabd_project/models/designers_model.dart';
import 'package:elabd_project/screens/chat_screen/chat_screen.dart';
import 'package:elabd_project/utils/style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/images.dart';
import '../../data/controllers/registration_controller.dart';

// screen for displaying Designer details
class DesignerDetails extends StatelessWidget {
  final DesignersModel designer;
  const DesignerDetails({super.key, required this.designer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Designer Details'), centerTitle: true),
      body: Padding(
        padding: EdgeInsets.all(paddingExtraLarge(context)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            designer.image != null
                ? ImageContainer(
                    img: NetworkImage(designer.image!),
                  )
                : const ImageContainer(
                    img: AssetImage(Images.man),
                  ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            const Text(
              'Designer Name',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            Text(
              designer.name!,
              style: const TextStyle(fontSize: 14),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            const Text(
              'Bio',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            Text(
              designer.name!,
              style: const TextStyle(fontSize: 14),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            const Text(
              'Experience',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            Text(
              '${designer.experience!} years',
              style: const TextStyle(fontSize: 14),
            ),
            SizedBox(
              height: Get.height * 0.02,
            ),
            const Text(
              'Email',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
            ),
            Text(
              designer.email!,
              style: const TextStyle(fontSize: 14),
            ),
            SizedBox(
              height: Get.height * 0.04,
            ),
            Center(
              child: PrimaryButon(
                title: 'Chat with ${designer.name}',
                onPressed: () {
                  Get.to(() => ChatScreen(
                        currentDesigner: DesignersModel(
                            uid: FirebaseAuth.instance.currentUser!.uid,
                            name: RegistrationController.i.designer.name),
                        targetDesigner: DesignersModel(
                            uid: designer.uid, name: designer.name),
                      ));
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}

class ImageContainer extends StatelessWidget {
  final ImageProvider? img;
  const ImageContainer({
    super.key,
    this.img,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: Get.height * 0.4,
      width: Get.width,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          image: DecorationImage(image: img!)),
    );
  }
}
