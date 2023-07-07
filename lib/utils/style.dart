// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';

// font size
double fontSizeSmall(BuildContext context) => getPixels(context, 10.0);
double fontSizeNormal(BuildContext context) => getPixels(context, 14.0);
double fontSizeMedium(BuildContext context) => getPixels(context, 17.0);
double fontSizeLarge(BuildContext context) => getPixels(context, 22.0);
double fontSizeExtraLarge(BuildContext context) => getPixels(context, 27.0);

// padding
double paddingExtraSmall(BuildContext context) => getPixels(context, 5.0);
double paddingSmall(BuildContext context) => getPixels(context, 10.0);
double paddingDefault(BuildContext context) => getPixels(context, 15.0);
double paddingLarge(BuildContext context) => getPixels(context, 20.0);
double paddingExtraLarge(BuildContext context) => getPixels(context, 25.0);

// font weight
const FontWeight fontWeightNormal = FontWeight.w500;
const FontWeight fontWeightSemiBold = FontWeight.w600;
const FontWeight fontWeightBold = FontWeight.w700;

// radius
const double radius = 8.0;

// get pixels with media query
double getPixels(BuildContext context, double pixels) =>
    MediaQuery.of(context).size.width * (pixels / 1145);
