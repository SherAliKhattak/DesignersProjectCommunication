import 'package:elabd_project/screens/splash/splash.dart';
import 'package:elabd_project/utils/init.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
);
Stripe.publishableKey = 'pk_test_51N33KYEja5zZT8RBPo6Ni2423KlXrU1IgXqTbMbA2cXAsSlZNslhyk4lsxCkFY8Ut7POW3NkYIk5NItTqi7tWnSb00jr4mhOyU';



  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return  GetMaterialApp(
      debugShowCheckedModeBanner: false,
      initialBinding: AppBindings(),
      home: const SplashScreen(),
      theme:  FlexThemeData.light(
      fontFamily: GoogleFonts.aBeeZee().fontFamily,
  scheme: FlexScheme.damask,
  surfaceMode: FlexSurfaceMode.highScaffoldLowSurface,
  blendLevel: 20,
  appBarOpacity: 0.95,
  subThemesData: const FlexSubThemesData(
    blendOnLevel: 20,
    blendOnColors: false,
  ),
  visualDensity: FlexColorScheme.comfortablePlatformDensity,
  // To use the playground font, add GoogleFonts package and uncomment
  // fontFamily: GoogleFonts.notoSans().fontFamily,
),
    );
  }
}