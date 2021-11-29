import 'package:epics/services/userinfo_service.dart';
import 'package:epics/view/screens/authpage/login.dart';
import 'package:epics/view/screens/customNavigation/custom_navigation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:epics/controller/binding/auth_binding.dart';
import 'package:epics/controller/auth_ctrl.dart';
import 'package:epics/controller/followuser.dart';
import 'package:epics/controller/notification_ctrl.dart';
import 'package:epics/controller/otheruserinfo_ctrl.dart';
import 'package:epics/controller/post_cntrl.dart';
import 'package:epics/controller/user_info_Ctrl.dart';

import 'view/screens/phoneAuth/login_phone_password.dart';
import 'view/screens/phoneAuth/phone_auth.dart';

class AuthState<T extends StatefulWidget> extends SupabaseAuthState<T> {
  @override
  void onUnauthenticated() {
    if (mounted) {
      Get.put(AuthController());

      Get.offAll(() => LoginWithPhonePass());
    }
  }

  @override
  void onAuthenticated(Session session) {
    if (mounted) {
      print("USER ID: ${session.user.id}");

      // if (session.user.appMetadata['provider'] == 'google') {
      //   UserInfoService()
      //       .addUsertoTable('', session.user.email, session.user.id);
      // }
      Get.put(AuthController());
      // Get.find<AuthController>().saveUser(session.user.id);
      Get.find<AuthController>().userUid.value = session.user.id;

      print('AUTTHENTICATED');
      Get.put(PostController());
      Get.put(UserInfoController());
      Get.put(OtherUserInfoCtrl());
      Get.put(NotificationsController());
      Future.delayed(Duration(seconds: 3), () {
        Get.offAll(() => BottomNavigation());
      });
    }
  }

  @override
  void onPasswordRecovery(Session session) {}

  @override
  void onErrorAuthenticating(String message) {
    print('Error authenticating $message');
  }
}

class AuthRequiredState<T extends StatefulWidget>
    extends SupabaseAuthRequiredState<T> {
  @override
  void onUnauthenticated() {
    /// Users will be sent back to the LoginPage if they sign out.
    Get.put(AuthController());

    Get.offAll(() => LoginPage());
  }
}
