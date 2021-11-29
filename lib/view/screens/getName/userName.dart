import 'dart:ui';

import 'package:epics/controller/login_ctrl.dart';
import 'package:epics/controller/register_ctrl.dart';
import 'package:epics/services/auth_service.dart';
import 'package:epics/services/user_info.dart';
import 'package:epics/view/root_page.dart';
import 'package:epics/view/screens/customNavigation/custom_navigation.dart';
import 'package:epics/view/screens/phoneAuth/phone_auth.dart';
import 'package:epics/view/utils/SizedConfig.dart';
import 'package:epics/view/utils/colors.dart';
import 'package:epics/view/widgets/custom_toast.dart';
import 'package:epics/view/widgets/input_field.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class GetUserName extends StatefulWidget {
  const GetUserName({Key key}) : super(key: key);

  @override
  _GetUserNameState createState() => _GetUserNameState();
}

class _GetUserNameState extends State<GetUserName> {
  @override
  void initState() {
    super.initState();
    // Future.delayed(Duration(seconds: 0), () {
    //   _buildBottomModelforName(context);
    // });
  }

  @override
  void dispose() {
    super.dispose();
  }

  GlobalKey<NavigatorState> _yourKey = GlobalKey<NavigatorState>();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => showDialog(
        context: context,
        builder: (context) => AlertDialog(
          contentPadding: EdgeInsets.all(10.0),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(12.0))),
          title: Text('Enter Your Name'),
          actions: <Widget>[
            TextButton(
                child: Text(
                  'Ok',
                  style: TextStyle(color: PINK_COLOR),
                ),
                onPressed: () => Navigator.of(context).pop(false)),
          ],
        ),
      ),
      child: Scaffold(
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
                            'Enter Your Name',
                            style:
                                Theme.of(context).textTheme.headline5.copyWith(
                                      color: Color.fromRGBO(55, 77, 76, 1),
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ),
                        SizedBox(height: 20),
                        GetBuilder<RegisterationCtrl>(
                            init: RegisterationCtrl(),
                            builder: (controller) {
                              return InputField(
                                isShortFiedl: true,
                                controller: controller.nameController,
                                hint: 'Enter Name',
                                keyboardInputType: TextInputType.text,
                                isPassField: false,
                                hidePassword: false,
                              );
                            }),
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
                          'Continue',
                          style: Theme.of(context)
                              .textTheme
                              .bodyText1
                              .copyWith(color: Colors.white),
                        ),
                      ),
                    ),
                    onPressed: () async {
                      if (ctx.nameController.text != '') {
                        bool userExits = await UserInfoService()
                            .checkIfUserNameExits(
                                ctx.nameController.text.toLowerCase());
                        if (userExits) {
                          UserInfoService()
                              .updateNameBio(ctx.nameController.text, '');
                          Get.offAll(() => Root());
                        } else {
                          print(userExits);
                          userExits = null;

                          showMessage(
                              title: 'Error',
                              message: 'Username already exists');
                        }
                      } else {
                        print('error');
                        showMessage(title: 'Error', message: 'Invalid input');
                      }
                    });
              }),
          height: 100,
        ),
      ),
    );
  }

  _buildBottomModelforName(BuildContext context) {
    return showModalBottomSheet(
      isDismissible: false,
      backgroundColor: Colors.transparent,
      context: context,
      builder: (context) => SingleChildScrollView(
        controller: ModalScrollController.of(context),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(16),
              topRight: Radius.circular(16),
            ),
          ),
          child: Padding(
            padding: EdgeInsets.only(
                top: 40, bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Add Name',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: SizeConfig.textMultiplier * 2),
                      ),
                      SizedBox(
                        height: SizeConfig.heightMultiplier * 2,
                      ),
                      GetBuilder<RegisterationCtrl>(
                          init: RegisterationCtrl(),
                          builder: (gtxcontroller) {
                            return Container(
                              color: Colors.white,
                              child: Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: TextFormField(
                                  controller: gtxcontroller.nameController,
                                  // initialValue: 'asd',
                                  textCapitalization:
                                      TextCapitalization.sentences,
                                  cursorColor: Colors.black,
                                  style: TextStyle(color: Colors.black),
                                  maxLength: 50,
                                  decoration: InputDecoration.collapsed(
                                    hintStyle: TextStyle(color: Colors.black),
                                    hintText: 'Add Name',
                                  ),
                                  autofocus: false,
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: GetBuilder<RegisterationCtrl>(
                      init: RegisterationCtrl(),
                      builder: (gtxcontroller) {
                        return RawMaterialButton(
                          onPressed: () {
                            if (gtxcontroller.nameController.text != '') {
                              UserInfoService().updateNameBio(
                                  gtxcontroller.nameController.text, '');
                              Get.back();
                              Get.back();
                            } else {
                              print('error');
                              showMessage(
                                  title: 'Error', message: 'Invalid input');
                            }
                          },
                          fillColor: PINK_COLOR,
                          child: Container(
                            decoration: BoxDecoration(
                                gradient:
                                    LinearGradient(colors: primaryGradient)),
                            height: SizeConfig.heightMultiplier * 7,
                            width: MediaQuery.of(context).size.width * 1,
                            child: Center(
                              child: Text(
                                'Save',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          ),
                        );
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
