import 'package:flutter/material.dart';

class PostTextField extends StatelessWidget {
  const PostTextField(
      {this.controller, this.hint, Key key, this.validator, this.formKey})
      : super(key: key);

  final TextEditingController controller;
  final String hint;
  final Function validator;
  final Key formKey;
  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: TextFormField(
        cursorColor: Theme.of(context).accentColor,
        controller: controller,
        textCapitalization: TextCapitalization.sentences,
        validator: validator,
        style: TextStyle(
            color: Theme.of(context).accentColor,
            fontWeight: FontWeight.w500,
            fontSize: 16.0),
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: TextStyle(
              color: Colors.grey, fontWeight: FontWeight.w500, fontSize: 16.0),
        ),
      ),
    );
  }
}
