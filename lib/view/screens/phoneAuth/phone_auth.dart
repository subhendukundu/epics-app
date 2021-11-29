import 'dart:ui';

import 'package:epics/controller/phoneauth_ctrl.dart';
import 'package:epics/services/auth_service.dart';
import 'package:epics/view/utils/SizedConfig.dart';
import 'package:epics/view/utils/colors.dart';
import 'package:epics/view/widgets/custom_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:glassmorphism/glassmorphism.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import 'choose_passsword.dart';
import 'components/enter_otp.dart';
import 'components/get_number.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({Key key}) : super(key: key);

  @override
  _PhoneAuthState createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  bool numberEntered = true;

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
                  height: Get.height * 0.39,
                  width: Get.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24.0),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Center(
                        child: Image.asset(
                          'assets/epics_logo.png',
                          height: 80,
                          width: 80,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            // margin: EdgeInsets.only(top: 30.0, left: 16),
                            alignment: Alignment.centerLeft,
                            child: Text(
                              numberEntered
                                  ? 'OTP VERIFICATION'
                                  : 'Your Phone!',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5
                                  .copyWith(
                                    color: Color.fromRGBO(55, 77, 76, 1),
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: numberEntered ? 0 : Get.height * 0.02,
                      ),
                      numberEntered ? ENTEROTP() : GetNumber(),
                      numberEntered
                          ? SizedBox()
                          : Container(
                              margin: EdgeInsets.only(top: 12),
                              child: Text(
                                'A 6 digit OPT will be sent via SMS to verity your mobile number',
                                style: Theme.of(context)
                                    .textTheme
                                    .caption
                                    .copyWith(
                                      color: Color.fromRGBO(55, 77, 76, 0.8),
                                    ),
                              ),
                            ),
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
        child: GetBuilder<PhoneAuthCtrl>(
            init: PhoneAuthCtrl(),
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
                        'Continue',
                        style: Theme.of(context)
                            .textTheme
                            .bodyText1
                            .copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  onPressed: () {
                    AuthService()
                        .verifyCode(
                            phomeNumber: ctx.number.completeNumber,
                            otp: ctx.otp)
                        .then((val) {});
                  });
            }),
        height: 100,
      ),
    );
  }
}
