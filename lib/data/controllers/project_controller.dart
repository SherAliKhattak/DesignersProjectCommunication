// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class ProjectController extends GetxController implements GetxService {

  // text editing controllers for creating project
  late TextEditingController projectTitle;
  late TextEditingController description;
  late TextEditingController status;
  late TextEditingController budget;
  late TextEditingController start;
  late TextEditingController end;

  static DateTime? startDate = DateTime.now();
  RxString? formatStartDate = DateFormat.yMMMd().format(startDate!).obs;
  static DateTime? endDate = DateTime.now();
  RxString? formatDeparture = DateFormat.yMMMd().format(endDate!).obs;

  // Time picker variables

  Future<void> selectDateAndTime(
    BuildContext context,
    DateTime? date,
    RxString? formattedDate,
    TextEditingController? startorEnd
  ) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        confirmText: 'Ok',
        initialDate: date!,
        firstDate: DateTime(2015),
        lastDate: DateTime(2050));
    if (pickedDate != null && pickedDate != date) {
      date = pickedDate;
      formattedDate!.value = DateFormat.yMMMd().format(date);
      startorEnd!.text = formattedDate.value;
      update();
    }
  }

  @override
  void onInit() {
    
    projectTitle = TextEditingController();
    description = TextEditingController();
    status = TextEditingController();
    budget = TextEditingController();
    start = TextEditingController();
    end = TextEditingController();

    super.onInit();
  }

  static ProjectController get i => Get.put(ProjectController());
}
