import 'package:epics/controller/login_ctrl.dart';
import 'package:epics/controller/phoneauth_ctrl.dart';
import 'package:epics/view/utils/SizedConfig.dart';
import 'package:epics/view/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class GetNumber extends StatelessWidget {
  const GetNumber({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 0, left: 16),
      alignment: Alignment.centerLeft,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Phone Number',
            style: Theme.of(context).textTheme.bodyText1.copyWith(
                  color: Color.fromRGBO(55, 77, 76, 0.8),
                ),
          ),
          GetBuilder<PhoneAuthCtrl>(
              init: PhoneAuthCtrl(),
              builder: (controller) {
                return Container(
                  height: Get.height * 0.057,
                  margin: EdgeInsets.symmetric(
                      horizontal: SizeConfig.widthMultiplier * 0.5),
                  child: IntlPhoneField(
                    showDropdownIcon: false,
                    initialCountryCode: 'IN',
                    validator: (value) {
                      String patttern = r'(^(?:[+0]9)?[0-9]{10,12}$)';
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
                      hintText: 'Enter Number',
                      floatingLabelBehavior: FloatingLabelBehavior.never,
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
              }),
          GetX<PhoneAuthCtrl>(
              init: PhoneAuthCtrl(),
              builder: (controller) {
                return InputField(
                  isShortFiedl: true,
                  controller: controller.phonePasswordController,
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
        ],
      ),
    );
  }
}
