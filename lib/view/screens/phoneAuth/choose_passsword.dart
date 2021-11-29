import 'dart:ui';

import 'package:epics/controller/phoneauth_ctrl.dart';
import 'package:epics/controller/register_ctrl.dart';
import 'package:epics/services/auth_service.dart';
import 'package:epics/view/utils/SizedConfig.dart';
import 'package:epics/view/utils/colors.dart';
import 'package:epics/view/widgets/custom_toast.dart';
import 'package:epics/view/widgets/input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../root_page.dart';

class ChoosePassword extends StatelessWidget {
  const ChoosePassword({Key key, this.number}) : super(key: key);
  final String number;
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
                  height: Get.height * 0.48,
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
                          'Choose Password',
                          style: Theme.of(context).textTheme.headline5.copyWith(
                                color: Color.fromRGBO(55, 77, 76, 1),
                                fontWeight: FontWeight.bold,
                              ),
                        ),
                      ),
                      SizedBox(height: 20),
                      InputField(
                        isShortFiedl: true,
                        readOnly: true,
                        hint: number,
                        isPassField: false,
                        hidePassword: false,
                      ),

                      SizedBox(height: 20),
                      GetX<RegisterationCtrl>(
                          init: RegisterationCtrl(),
                          builder: (controller) {
                            return InputField(
                              isShortFiedl: true,
                              readOnly: false,
                              controller: controller.passwordController,
                              hint: 'Choose Password',
                              isPassField: true,
                              keyboardInputType: TextInputType.text,
                              hidePassword: controller.hidePassword.value,
                              suffixIconPressed: () {
                                controller.hidePassword.value =
                                    !controller.hidePassword.value;
                              },
                            );
                          }),
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
        child: GetBuilder<RegisterationCtrl>(
            init: RegisterationCtrl(),
            builder: (ctx) {
              return CupertinoButton(
                  child: Container(
                    decoration: BoxDecoration(
                        gradient: LinearGradient(colors: primaryGradient),
                        borderRadius: BorderRadius.circular(99)),
                    height: Get.height * 0.07,
                    width: Get.width * 0.3,
                    child: Center(
                      child: Text(
                        'Log in',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  onPressed: () {
                    if (ctx.passwordController.text != '') {
                      AuthService().signWithPhoneNumber(
                          phomeNumber: number,
                          password: ctx.passwordController.text);
                      // Get.to(() => Root());
                    } else {
                      showMessage(title: 'Error', message: 'Enter Password');
                    }
                  });
            }),
        height: 100,
      ),
    );
  }
}
