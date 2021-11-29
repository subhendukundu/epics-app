import 'package:epics/view/utils/SizedConfig.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String hint;
  final TextEditingController controller;
  final bool isPassField;
  final bool isShortFiedl;
  final int maxLength;
  final TextInputType keyboardInputType;
  final Function suffixIconPressed;
  final bool hidePassword, readOnly;

  const InputField(
      {this.hint,
      this.controller,
      this.isPassField,
      this.hidePassword,
      this.suffixIconPressed,
      this.maxLength,
      this.readOnly,
      this.keyboardInputType = TextInputType.text,
      this.isShortFiedl});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: isShortFiedl != null
          ? EdgeInsets.only()
          : EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 0.5),
      padding: EdgeInsets.symmetric(
          horizontal: isShortFiedl
              ? SizeConfig.widthMultiplier * 0
              : SizeConfig.widthMultiplier * 5),
      height: 50,
      decoration: BoxDecoration(
          border: isShortFiedl
              ? null
              : Border.all(
                  color: Theme.of(context).accentColor.withOpacity(0.5),
                  width: 1.0),
          // color: Theme.of(context).highlightColor.withOpacity(0.15),
          borderRadius: BorderRadius.circular(8.0)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextField(
            readOnly: readOnly != null ? readOnly : false,
            textAlignVertical: TextAlignVertical.center,
            maxLength: maxLength,
            keyboardType: keyboardInputType,
            cursorColor: Theme.of(context).accentColor,
            controller: controller,
            obscureText: hidePassword ? true : false,
            style: TextStyle(
                color: Theme.of(context).accentColor,
                fontWeight: FontWeight.w500,
                fontSize: 16.0),
            decoration: InputDecoration(
              border: InputBorder.none,
              suffixIcon: isPassField
                  ? IconButton(
                      onPressed: suffixIconPressed,
                      icon: Icon(
                        hidePassword ? Icons.visibility_off : Icons.visibility,
                        size: 18,
                        color: hidePassword ? Colors.grey : Color(0xFFD226AB),
                      ))
                  : SizedBox(),
              hintText: hint,
              hintStyle: TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.w500,
                  fontSize: 16.0),
            ),
          ),
        ],
      ),
    );
  }
}
