
import 'package:elabd_project/data/controllers/project_controller.dart';
import 'package:elabd_project/data/controllers/registration_controller.dart';
import 'package:get/get.dart';

class AppBindings implements Bindings {
  @override
  void dependencies() {
    Get.put<RegistrationController>(RegistrationController());
    Get.put<ProjectController>(ProjectController());
  }
}
