import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomTextField extends StatelessWidget {
  final bool? sizedBox;
  final String? title;
  final double? width;
  final dynamic onChanged;
  final String? hintText;
  final String? Function(String?)? validation;
  final Widget? prefixIcon;
  final dynamic maxLines;
  final dynamic minLines;
  final String? initialValue;
  final dynamic keyBoardType;
  final dynamic controller;
  final double borderRadius;
  final bool check;
  final bool readOnly;
  final EdgeInsetsGeometry? padding;
  final dynamic fromSignuporSignIn;
  final VoidCallback? function;
  final Widget? suffixIconData;
  final EdgeInsetsGeometry? margin;
  const CustomTextField(
      {Key? key,
      this.function,
      this.suffixIconData,
      this.fromSignuporSignIn,
      this.check = false,
      this.readOnly = false,
      required this.borderRadius,
      this.controller,
      this.keyBoardType,
      this.hintText,
      this.prefixIcon,
      this.initialValue,
      this.onChanged,
      this.maxLines,
      this.minLines,
      this.validation,
      this.padding,
      this.margin,
      this.width, this.title, this.sizedBox})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        title != null ? Text('$title') : const SizedBox(),
        SizedBox(height: Get.height*0.01,),
        Container(
          width: width,
          margin: margin,
          child: TextFormField(
            validator: validation,
            onChanged: onChanged,
            controller: controller,
            readOnly: readOnly,
            maxLines: maxLines ?? 1,
            
            keyboardType: keyBoardType ?? TextInputType.text,
            obscureText: check,
            decoration: InputDecoration(
              enabledBorder:
                  outlineInputBorder(Theme.of(context).hintColor, borderRadius),
              focusedBorder: outlineInputBorder(Colors.red,borderRadius),
              errorBorder: outlineInputBorder(Colors.red, borderRadius),
              focusedErrorBorder: outlineInputBorder(Colors.grey, borderRadius),
              fillColor: Colors.white,
              filled: true,
              suffixIcon: suffixIconData,
              contentPadding: padding,
              prefixIcon: prefixIcon,
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w300),
            ),
          ),
        ),
       sizedBox == true ? SizedBox(height: Get.height*0.01,) : const SizedBox(),
      ],
    );
  }
}

OutlineInputBorder outlineInputBorder(Color color, double radius) =>
    OutlineInputBorder(
      borderSide: BorderSide(color: color, width: 1.0),
      borderRadius: BorderRadius.circular(radius),
    );
