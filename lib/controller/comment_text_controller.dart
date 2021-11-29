import 'package:flutter/material.dart';
import 'package:get/state_manager.dart';

class CommentCtrl extends GetxController {
  RxBool autofocus = true.obs;
  var focusNode = FocusNode();

  RxBool get autofocused {
    return autofocus;
  }

  changeTextFieldFocus() {
    print(autofocus.obs.value);
    autofocus.obs.value.isTrue
        ? autofocus.value = false
        : autofocus.value = true;
    update();
  }
}
