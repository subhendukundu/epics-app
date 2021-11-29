import 'dart:ui';

import 'package:epics/controller/login_ctrl.dart';
import 'package:epics/controller/register_ctrl.dart';
import 'package:epics/services/auth_service.dart';
import 'package:epics/view/screens/phoneAuth/phone_auth.dart';
import 'package:epics/view/utils/SizedConfig.dart';
import 'package:epics/view/utils/colors.dart';
import 'package:epics/view/widgets/custom_toast.dart';
import 'package:epics/view/widgets/input_field.dart';
import 'package:epics/view/widgets/progress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class LoginWithPhonePass extends StatefulWidget {
  const LoginWithPhonePass({Key key}) : super(key: key);

  @override
  _LoginWithPhonePassState createState() => _LoginWithPhonePassState();
}

class _LoginWithPhonePassState extends State<LoginWithPhonePass> {
  @override
  void initState() {
    super.initState();
    Get.put(LoginCtrl());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
                  Color.fromRGBO(188, 203, 207, 1),
                  Color.fromRGBO(226, 234, 236, 1),
                  Colors.white,
                  Color.fromRGBO(55, 77, 76, 0.6),
                  Colors.white,
                ],
              ),
            ),
            width: Get.width,
            height: Get.height,
          ),
          BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 40.0,
              sigmaY: 40.0,
            ),
            child: Container(
              child: Center(
                child: Container(
                  padding: EdgeInsets.all(24),
                  height: Get.height * 0.35,
                  width: Get.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  child: Column(
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/epics_logo.png',
                          height: 80,
                          width: 80,
                        ),
                      ),

                      Container(
                        margin: EdgeInsets.only(top: 30.0, left: 16),
                        alignment: Alignment.centerLeft,
                        child: Text(
                          'Login',
                          style: Theme.of(context).textTheme.headline5.copyWith(
                                color: Color.fromRGBO(55, 77, 76, 1),
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      SizedBox(height: 20),
                      GetBuilder<LoginCtrl>(
                          init: LoginCtrl(),
                          builder: (controller) {
                            return Container(
                              height: Get.height * 0.04,
                              margin: EdgeInsets.symmetric(
                                  horizontal: SizeConfig.widthMultiplier * 0.5),
                              child: IntlPhoneField(
                                showDropdownIcon: false,
                                initialCountryCode: 'IN',
                                validator: (value) {
                                  String patttern =
                                      r'(^(?:[+0]9)?[0-9]{10,12}$)';
                                  RegExp regExp = new RegExp(patttern);
                                  if (value.length == 0) {
                                    return 'Please enter mobile number';
                                  } else if (!regExp.hasMatch(value)) {
                                    return 'Please enter valid mobile number';
                                  }
                                  return null;
                                },
                                style: TextStyle(fontSize: 16.0),
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.only(bottom: 0.8),
                                  hintText: 'Enter Your Number',
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  hintStyle: TextStyle(
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16.0),
                                ),
                                onChanged: (phone) {
                                  controller.number = phone;
                                },
                              ),
                            );
                            // return InputField(
                            //   isShortFiedl: true,
                            //   controller: controller.emailController,
                            //   hint: 'Enter Phone Number',
                            //   keyboardInputType: TextInputType.emailAddress,
                            //   isPassField: false,
                            //   hidePassword: false,
                            // );
                          }),
                      // SizedBox(height: 20),
                      // GetX<LoginCtrl>(
                      //     init: LoginCtrl(),
                      //     builder: (controller) {
                      //       return InputField(
                      //         isShortFiedl: true,
                      //         controller: controller.passwordController,
                      //         hint: 'Enter Your Password',
                      //         isPassField: true,
                      //         keyboardInputType: TextInputType.text,
                      //         hidePassword: controller.hidePassword.value,
                      //         suffixIconPressed: () {
                      //           controller.hidePassword.value =
                      //               !controller.hidePassword.value;
                      //         },
                      //       );
                      //     }),
                      // Container(
                      //   margin: EdgeInsets.only(top: 24),
                      //   height: 40,
                      //   width: double.infinity,
                      //   child: Center(
                      //     child: RichText(
                      //       text: TextSpan(
                      //         text: 'Dont have account? ',
                      //         style: Theme.of(context)
                      //             .textTheme
                      //             .button
                      //             .copyWith(fontWeight: FontWeight.normal),
                      //         children: <TextSpan>[
                      //           TextSpan(
                      //             text: 'SignUp',
                      //             recognizer: new TapGestureRecognizer()
                      //               ..onTap = () {
                      //                 Get.to(() => PhoneAuth());
                      //               },
                      //             style: Theme.of(context)
                      //                 .textTheme
                      //                 .button
                      //                 .copyWith(
                      //                   fontWeight: FontWeight.bold,
                      //                   color: Color.fromRGBO(55, 77, 76, 1),
                      //                 ),
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        alignment: Alignment.topCenter,
        color: Colors.transparent,
        child: GetX<LoginCtrl>(
            init: LoginCtrl(),
            builder: (ctx) {
              return CupertinoButton(
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: primaryGradient),
                        borderRadius: BorderRadius.circular(99)),
                    height: Get.height * 0.07,
                    width: Get.width * 0.3,
                    child: Center(
                      child: ctx.loading.value
                          ? CircularProgressIndicator(
                              strokeWidth: 2.0,
                              valueColor: AlwaysStoppedAnimation(Colors.white),
                            )
                          : Text(
                              'Log in',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1
                                  .copyWith(color: Colors.white),
                            ),
                    ),
                  ),
                  onPressed: () {
                    if (ctx.number != null) if (ctx.number.number != '') {
                      ctx.loading.value = true;
                      AuthService().signInWithPhone(
                          phoneNumber: ctx.number.completeNumber);
                    } else {
                      showMessage(title: 'Error', message: 'Invalid input');
                    }
                    else {
                      showMessage(title: 'Error', message: 'Invalid input');
                    }
                  });
            }),
        height: 100,
      ),
    );
  }
}
