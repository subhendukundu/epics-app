import 'package:epics/controller/user_info_Ctrl.dart';
import 'package:epics/view/utils/SizedConfig.dart';
import 'package:epics/view/utils/consts.dart';
import 'package:epics/view/widgets/dpPreview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:get/get.dart';

// ignore: must_be_immutable
class CommentBox extends StatelessWidget {
  Widget child;
  dynamic formKey;
  dynamic sendButtonMethod;
  dynamic commentController;
  String labelText;
  String errorText;
  Widget sendWidget;
  Color backgroundColor;
  Color textColor;
  bool withBorder;
  Widget header;
  FocusNode focusNode;
  bool autofocus;
  CommentBox(
      {this.child,
      this.header,
      this.autofocus,
      this.sendButtonMethod,
      this.formKey,
      this.commentController,
      this.sendWidget,
      this.labelText,
      this.focusNode,
      this.errorText,
      this.withBorder = true,
      this.backgroundColor,
      this.textColor});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(child: child),
        Divider(
          height: 1,
        ),
        header ?? SizedBox.shrink(),
        ListTile(
          tileColor: backgroundColor,
          leading: Container(
            height: 40.0,
            width: 40.0,
            decoration: new BoxDecoration(
                color: Colors.blue,
                borderRadius: new BorderRadius.all(Radius.circular(50))),
            child: GetX<UserInfoController>(
                init: UserInfoController(),
                builder: (controller) {
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(99),
                    child: Container(
                      width: SizeConfig.widthMultiplier * 7,
                      height: SizeConfig.heightMultiplier * 7,
                      child: controller.usetInfo.value.userAvatar != null
                          ? GestureDetector(
                              onTap: () => Get.to(
                                () => FullImagePreview(
                                    imageUrl: NETWORK_IMAGE_URL +
                                        '${controller.usetInfo.value.userAvatar}',
                                    blurHash:
                                        controller.usetInfo.value.blurHash),
                              ),
                              child: BlurHash(
                                image: NETWORK_IMAGE_URL +
                                    '${controller.usetInfo.value.userAvatar}',
                                hash: controller.usetInfo.value.blurHash,
                              ),
                            )
                          : Image.asset(
                              'assets/default.jpeg',
                              fit: BoxFit.fill,
                            ),
                    ),
                  );
                }),
          ),
          title: Form(
            key: formKey,
            child: TextFormField(
              maxLines: 4,
              minLines: 1,
              keyboardType: TextInputType.text,
              cursorColor: textColor,
              style: TextStyle(color: textColor),
              controller: commentController,
              decoration: InputDecoration.collapsed(
                hintText: 'Write a comment',
                hintStyle: TextStyle(color: Theme.of(context).accentColor),

                focusColor: textColor,
                fillColor: textColor,
                // labelStyle: TextStyle(color: textColor),
              ),
              validator: (value) => value.isEmpty ? errorText : null,
            ),
          ),
          trailing: GestureDetector(
            onTap: sendButtonMethod,
            child: sendWidget,
          ),
        ),
      ],
    );
  }
}
