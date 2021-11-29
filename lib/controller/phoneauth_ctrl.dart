import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/phone_number.dart';

class PhoneAuthCtrl extends GetxController {
  PhoneNumber number;
  String phoneNumber;
  String otp;
  RxBool hidePassword = true.obs;

  final TextEditingController phonePasswordController = TextEditingController();
}
