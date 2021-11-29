import 'package:epics/services/auth_service.dart';
import 'package:epics/view/widgets/custom_toast.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RegisterationCtrl extends GetxController {
  RxBool loading = false.obs;
  RxBool hidePassword = true.obs;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final nameKey = GlobalKey<FormState>();
  final emailKey = GlobalKey<FormState>();
  final passwordkey = GlobalKey<FormState>();

  registerationFunction() {
    if (loading.value) {
      showMessage(title: 'Please Wait', message: 'Please Wait');
    } else {
      if (emailController.text == '' ||
          nameController.text == '' ||
          passwordController.text == '') {
        showMessage(title: 'Error', message: 'Invalid Input');
      } else {
        loading.value = true;
        AuthService()
            .signUp(emailController.text, passwordController.text,
                nameController.text)
            .then((value) {
          if (value) {
            loading.value = false;
          }
        });
      }
    }
  }
}
