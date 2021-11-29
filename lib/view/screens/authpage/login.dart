import 'package:epics/view/provider/theme_provider.dart';
import 'package:epics/view/utils/SizedConfig.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';
import 'components/login_widgets.dart';
import 'register.dart';

class LoginPage extends StatelessWidget {
  LoginPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
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
                SizedBox(width: MediaQuery.of(context).size.width * 0.103),
                Text(
                  'Log in',
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
                  // physics: NeverScrollableScrollPhysics(),
                  child: LoginWigets(),
                ),
              ),
            ),
            Container(
              height: 40,
              width: double.infinity,
              child: Center(
                child: RichText(
                  text: TextSpan(
                    text: 'Dont have account? ',
                    style: Theme.of(context).textTheme.subtitle1,
                    children: <TextSpan>[
                      TextSpan(
                          text: 'SignUp',
                          recognizer: new TapGestureRecognizer()
                            ..onTap = () {
                              Get.to(() => SignUpPage());
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
