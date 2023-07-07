// ignore_for_file: prefer_adjacent_string_concatenation

import 'dart:convert';
import 'dart:developer';

import 'package:elabd_project/components/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

Map<String, dynamic>? paymentIntentData;

// function to make payment
Future<void> makePayment() async {
  try {
    paymentIntentData = await createPaymentIntent('20', 'USD');
    await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
            setupIntentClientSecret:
                'sk_test_51N33KYEja5zZT8RBA3CVHClE47htXkyb5Tuzf7ObJNYJ5YOCEQ3TJVVxSPiYv0ajFvhs9ppmtEvejl9oGulF4NV400ingInQju',
            paymentIntentClientSecret: paymentIntentData!['client_secret'],
            merchantDisplayName: 'Sher Ali Khattak',
            style: ThemeMode.dark));
    displayPaymentSheet();
  } catch (e) {
    log(e.toString());
  }
}
// function to display payment sheet
displayPaymentSheet() async {
  try {
    await Stripe.instance.presentPaymentSheet();
    paymentIntentData = null;

    showSnackbar(
        context: Get.context,
        content: 'Paid Successfully',
        color: Colors.black);
  } on StripeException catch (e) {
    showSnackbar(
        context: Get.context, content: e.toString(), color: Colors.black);
  }
}

// function to get data from Stripe API

createPaymentIntent(String amount, String currency) async {
  try {
    Map<String, dynamic> body = {
      'amount': calculateAmount(amount),
      'currency': currency,
      'payment_method_types[]': 'card',
    };
    log(body.toString());
    var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: body,
        headers: {
          'Authorization': 'Bearer ' +
              'sk_test_51N33KYEja5zZT8RBA3CVHClE47htXkyb5Tuzf7ObJNYJ5YOCEQ3TJVVxSPiYv0ajFvhs9ppmtEvejl9oGulF4NV400ingInQju',
          'Content-Type': 'application/x-www-form-urlencoded'
        });
    log('Create Intent reponse ===> ${response.body.toString()}');
    return jsonDecode(response.body);
  } catch (err) {
    log(err.toString());
  }
}

calculateAmount(String amount) {
  final price = int.parse(amount) * 100;
  return price.toString();
}
