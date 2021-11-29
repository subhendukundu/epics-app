import 'package:epics/controller/register_ctrl.dart';
import 'package:epics/view/utils/SizedConfig.dart';
import 'package:epics/view/widgets/input_field.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'components/auth_btn.dart';
import 'components/singin_button.dart';

class SignUpPage extends StatelessWidget {
  SignUpPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.all(SizeConfig.heightMultiplier * 2),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height * 0.05),
            Row(
              children: [
                // InkWell(
                //     onTap: () async {
                //       await themeProvider.toggleThemeData();
                //     },
                //     child: Text('Tap')),
                Container(
                  width: MediaQuery.of(context).size.width * 0.1,
                  height: MediaQuery.of(context).size.width * 0.1,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: Theme.of(context).accentColor)),
                  child: Padding(
                    padding: const EdgeInsets.only(left: 6.0),
                    child: GestureDetector(
                      onTap: () {
                        Get.back();
                      },
                      child: Icon(
                        Icons.arrow_back_ios,
                        color: Theme.of(context).accentColor,
                        size: 17,
                      ),
                    ),
                  ),
                ),
                SizedBox(width: MediaQuery.of(context).size.width * 0.03),
                Text(
                  'Sign up',
                  style: Theme.of(context).textTheme.headline1.copyWith(
                        fontSize: SizeConfig.textMultiplier * 5,
                      ),
                ),
              ],
            ),
            Expanded(
              child: NotificationListener<OverscrollIndicatorNotification>(
                onNotification: (overscroll) {
                  overscroll.disallowGlow();
                  return null;
                },
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.10,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 6,
                        ),
                        child: Text(
                          'Email',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      GetBuilder<RegisterationCtrl>(
                          init: RegisterationCtrl(),
                          builder: (controller) {
                            return InputField(
                              controller: controller.emailController,
                              hint: 'tim@gmail.com',
                              keyboardInputType: TextInputType.emailAddress,
                              isPassField: false,
                              hidePassword: false,
                            );
                          }),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 6,
                        ),
                        child: Text(
                          'Name',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),

                      GetBuilder<RegisterationCtrl>(
                          init: RegisterationCtrl(),
                          builder: (controller) {
                            return InputField(
                              controller: controller.nameController,
                              keyboardInputType: TextInputType.name,
                              hint: 'Enter your name',
                              isPassField: false,
                              hidePassword: false,
                            );
                          }),

                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.02,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 6,
                        ),
                        child: Text(
                          'Password',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.01,
                      ),
                      GetX<RegisterationCtrl>(
                          init: RegisterationCtrl(),
                          builder: (controller) {
                            return InputField(
                              controller: controller.passwordController,
                              hint: 'Pick a strong password',
                              isPassField: true,
                              keyboardInputType: TextInputType.text,
                              hidePassword: controller.hidePassword.value,
                              suffixIconPressed: () {
                                controller.hidePassword.value =
                                    !controller.hidePassword.value;
                              },
                            );
                          }),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 16),
                        child: Text(
                          'Sign up with on of the following options',
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SignInButton(
                            icondata: FontAwesomeIcons.google,
                            ontap: () {},
                          ),
                          SignInButton(
                            icondata: FontAwesomeIcons.spotify,
                            ontap: () {},
                          ),
                        ],
                      ),
                      // SizedBox(
                      //   height: MediaQuery.of(context).size.height * 0.03,
                      // ),
                      GetX<RegisterationCtrl>(
                          init: RegisterationCtrl(),
                          builder: (controller) {
                            return GestureDetector(
                              onTap: () => controller.registerationFunction(),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: MediaQuery.of(context).size.height *
                                        0.03),
                                child: AuthButton(
                                  isLoading: controller.loading.value,
                                  label: 'Sign up',
                                  gradient: LinearGradient(
                                    colors: [
                                      Color(0xFFB817D9),
                                      Color(0xFFD226AB),
                                      // Color(0xFFC44BC1)
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ),
            ),
            Container(
              height: 40,
              width: double.infinity,
              child: Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Already have an account? ',
                    style: Theme.of(context).textTheme.subtitle1,
                    children: <TextSpan>[
                      TextSpan(
                          text: 'Login',
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () {
                              Get.back();
                            },
                          style: Theme.of(context).textTheme.subtitle1.copyWith(
                                fontWeight: FontWeight.bold,
                                color: Color(0xFFB817D9),
                              )),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
