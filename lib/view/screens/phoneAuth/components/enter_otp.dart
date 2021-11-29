import 'package:epics/controller/phoneauth_ctrl.dart';
import 'package:epics/services/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class ENTEROTP extends StatelessWidget {
  const ENTEROTP({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          alignment: Alignment.centerLeft,
          margin: EdgeInsets.symmetric(vertical: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Enter the OTP you received to',
                style: Theme.of(context).textTheme.caption.copyWith(
                      color: Color.fromRGBO(55, 77, 76, 0.8),
                    ),
              ),
              SizedBox(height: 5),
              GetBuilder<PhoneAuthCtrl>(
                  init: PhoneAuthCtrl(),
                  builder: (controller) {
                    return Text(controller.phoneNumber,
                        style: Theme.of(context).textTheme.caption.copyWith(
                              fontWeight: FontWeight.bold,
                              color: Color.fromRGBO(55, 77, 76, 0.8),
                            ));
                  }),
            ],
          ),
        ),
        GetBuilder<PhoneAuthCtrl>(
            init: PhoneAuthCtrl(),
            builder: (controller) {
              return Container(
                child: PinCodeTextField(
                  backgroundColor: Colors.white,
                  onCompleted: (value) {
                    print(value);
                    controller.otp = value;
                    AuthService().verifyCode(
                      phomeNumber: controller.phoneNumber,
                      otp: controller.otp,
                    );
                  },
                  keyboardType: TextInputType.number,
                  enableActiveFill: true,
                  textStyle: TextStyle(color: Colors.black),
                  pinTheme: PinTheme(
                    borderRadius: BorderRadius.circular(8),
                    selectedColor: Colors.grey[700],
                    borderWidth: 0,
                    inactiveFillColor: Color.fromRGBO(188, 203, 207, 0.4),
                    selectedFillColor: Colors.white,
                    shape: PinCodeFieldShape.box,
                    fieldHeight: 60,
                    fieldWidth: 40,
                    activeColor: Colors.white,
                    inactiveColor: Colors.grey[800],
                    activeFillColor: Color.fromRGBO(188, 203, 207, 0.2),
                  ),
                  animationType: AnimationType.fade,
                  appContext: context,
                  onChanged: (value) {},
                  length: 6,
                ),
              );
            }),
        // Container(
        //   margin: EdgeInsets.only(top: 20),
        //   child: Text(
        //     'RESENT',
        //     style: TextStyle(
        //         color: Color.fromRGBO(55, 77, 76, 0.8),
        //         fontWeight: FontWeight.bold),
        //   ),
        // ),
      ],
    );
  }
}
