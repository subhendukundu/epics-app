import 'package:epics/services/auth_service.dart';
import 'package:epics/view/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/phone_number.dart';

class LoginCtrl extends GetxController {
  RxBool loading = false.obs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  PhoneNumber number;
  String otp;
  RxBool hidePassword = true.obs;

  loginFunction() {
    if (loading.value) {
      showMessage(title: 'Please Wait', message: 'Please wait');
    } else {
      if (emailController.text == '' || passwordController.text == '') {
        showMessage(title: 'Error', message: 'Invalid input');
      } else {
        loading.value = true;
        AuthService()
            .signIn(emailController.text, passwordController.text)
            .then((value) {
          if (value) {
            loading.value = false;
          }
        });
      }
    }
  }
}
