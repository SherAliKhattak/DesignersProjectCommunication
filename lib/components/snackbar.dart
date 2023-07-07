import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackbar(
  
    {BuildContext? context ,String? content, Color? color}) {
  return ScaffoldMessenger.of(context!)
      .showSnackBar(SnackBar(content: Text(content!), backgroundColor: color,),);
}