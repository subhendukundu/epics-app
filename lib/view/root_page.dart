import 'package:epics/auth_state.dart';
import 'package:epics/controller/binding/auth_binding.dart';
import 'package:epics/controller/auth_ctrl.dart';
import 'package:epics/controller/followuser.dart';
import 'package:epics/controller/login_ctrl.dart';
import 'package:epics/controller/notification_ctrl.dart';
import 'package:epics/controller/otheruserinfo_ctrl.dart';
import 'package:epics/controller/post_cntrl.dart';
import 'package:epics/controller/user_info_Ctrl.dart';
import 'package:epics/view/provider/theme_provider.dart';
import 'package:epics/view/screens/customNavigation/custom_navigation.dart';
import 'package:epics/view/utils/SizedConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../splash_screen.dart';
import 'screens/phoneAuth/login_phone_password.dart';

class RootPage extends StatelessWidget {
  const RootPage({this.themeProvider});
  final ThemeProvider themeProvider;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    return LayoutBuilder(builder: (context, constraints) {
      return OrientationBuilder(builder: (context, orientation) {
        SizeConfig().init(constraints, orientation);
        SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
        ));
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.portraitUp,
        ]);
        return GetMaterialApp(
          debugShowCheckedModeBanner: false,
          // initialBinding: AuthBinding(),
          theme: themeProvider.themeData(),
          home: Root(),
        );
      });
    });
  }
}

class Root extends StatelessWidget {
  const Root({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetX<AuthController>(
      init: AuthController(),
      global: true,
      autoRemove: false,
      builder: (controller) {
        if (controller.userUid.value != '') {
          Get.put<AuthController>(AuthController(), permanent: true);
          Get.put(OtherUserInfoCtrl(), permanent: true);
          Get.put(PostController(), permanent: true);
          Get.put(UserInfoController());
          Get.put(OtherUserInfoCtrl());
          Get.put(NotificationsController());
          return BottomNavigation();
        } else {
          Get.put<AuthController>(AuthController(), permanent: true);

          Get.put(LoginCtrl());
          return LoginWithPhonePass();
        }
      },
    );
  }
}
