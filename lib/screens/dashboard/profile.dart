import 'package:elabd_project/data/controllers/registration_controller.dart';
import 'package:elabd_project/data/services/auth_service.dart';
import 'package:elabd_project/utils/style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../components/images.dart';
import '../../utils/alert_dialog.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Designer Profile'),
        actions: [
          IconButton(
              onPressed: () {
                AuthService().signout();
              },
              icon: const Icon(Icons.logout_outlined))
        ],
      ),
      body: SafeArea(
        minimum: EdgeInsets.all(paddingExtraLarge(context)),
        child: SingleChildScrollView(
          child: GetBuilder<RegistrationController>(builder: (contr) {
            return Column(
              children: [
                CircleAvatar(
                  radius: 80,
                  backgroundImage:
                      RegistrationController.i.designer.image == null ? const AssetImage(Images.man): NetworkImage(RegistrationController.i.designer.image!) as ImageProvider,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: GestureDetector(
                        onTap: () {
                          contr.updateProfilePic(context);
                        },
                        child: const Icon(
                          Icons.camera_alt,
                          color: Colors.black,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Get.height * 0.05,
                ),
                UserInfoRow(
                  infotype: 'name',
                  value: '${RegistrationController.i.designer.name}',
                  controller: RegistrationController.i.username,
                ),
                const Divider(
                  height: 1,
                ),
                SizedBox(
                  height: Get.height * 0.05,
                ),
                UserInfoRow(
                  infotype: 'bio',
                  value: '${RegistrationController.i.designer.bio}',
                  controller: RegistrationController.i.bio,
                ),
                const Divider(
                  height: 1,
                ),
                SizedBox(
                  height: Get.height * 0.05,
                ),
                UserInfoRow(
                  infotype: 'experience',
                  value:
                      '${RegistrationController.i.designer.experience} years',
                  controller: RegistrationController.i.experience,
                ),
                const Divider(
                  height: 1,
                ),
                SizedBox(
                  height: Get.height * 0.05,
                ),
                
              ],
            );
          }),
        ),
      ),
    );
  }
}

class UserInfoRow extends StatelessWidget {
  final String? infotype;
  final String? value;
  final TextEditingController? controller;
  const UserInfoRow({
    Key? key,
    this.infotype,
    this.value,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Expanded(
          child: Padding(
        padding: const EdgeInsets.only(left: 16, bottom: 16, top: 16),
        child: Text(
          infotype!,
          style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
        ),
      )),
      Expanded(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 16, top: 16, right: 30),
          child: Text(
            value!,
            overflow: TextOverflow.clip,
          ),
        ),
      ),
      GestureDetector(
          onTap: (() {
            AlertDialogue.rename(context, infotype, value!, controller!);
          }),
          child: const Icon(Icons.edit))
    ]);
  }
}
