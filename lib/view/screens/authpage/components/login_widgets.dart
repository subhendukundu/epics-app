import 'package:epics/controller/login_ctrl.dart';
import 'package:epics/services/auth_service.dart';
import 'package:epics/view/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

import 'auth_btn.dart';
import 'singin_button.dart';

class LoginWigets extends StatelessWidget {
  const LoginWigets({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.20,
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
        GetBuilder<LoginCtrl>(
            init: LoginCtrl(),
            builder: (controller) {
              return InputField(
                controller: controller.emailController,
                hint: 'hey@gmail.com',
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
            'Password',
            style: Theme.of(context).textTheme.subtitle1,
          ),
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.01,
        ),
        GetX<LoginCtrl>(
            init: LoginCtrl(),
            builder: (controller) {
              return InputField(
                controller: controller.passwordController,
                hint: 'Enter your password',
                isPassField: true,
                keyboardInputType: TextInputType.text,
                hidePassword: controller.hidePassword.value,
                suffixIconPressed: () {
                  controller.hidePassword.value =
                      !controller.hidePassword.value;
                },
              );
            }),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SignInButton(
              icondata: FontAwesomeIcons.google,
              ontap: () {
                print("TApped");
                AuthService().googleSignin();
              },
            ),
            SignInButton(
              icondata: FontAwesomeIcons.spotify,
              ontap: () {},
            ),
          ],
        ),
        SizedBox(
          height: MediaQuery.of(context).size.height * 0.03,
        ),
        GetX<LoginCtrl>(
            init: LoginCtrl(),
            builder: (controller) {
              return GestureDetector(
                onTap: () => controller.loginFunction(),
                child: AuthButton(
                  isLoading: controller.loading.value,
                  label: 'Log in',
                  gradient: LinearGradient(
                    colors: [
                      Color(0xFFB817D9),
                      Color(0xFFD226AB),
                      // Color(0xFFC44BC1)
                    ],
                  ),
                ),
              );
            }),
      ],
    );
  }
}
