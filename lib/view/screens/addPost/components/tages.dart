import 'package:epics/controller/add_post_Ctrl.dart';
import 'package:epics/view/utils/SizedConfig.dart';
import 'package:epics/view/widgets/post_text_field.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddTags extends StatelessWidget {
  const AddTags({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.heightMultiplier * 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text('Tags', style: Theme.of(context).textTheme.headline6),
              RawMaterialButton(
                constraints:
                    const BoxConstraints(minWidth: 20.0, minHeight: 20.0),
                fillColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40)),
                child: Icon(Icons.add, color: Colors.white, size: 14),
                onPressed: () {
                  Get.dialog(
                    AlertDialog(
                      title: Text("Add a Tag"),
                      content: GetBuilder<AddPostCtrl>(
                          init: AddPostCtrl(),
                          builder: (controller) {
                            return PostTextField(
                              controller: controller.tagController,
                              hint: 'Add tag',
                            );
                          }),
                      actions: <Widget>[
                        TextButton(
                          child: Text(
                            "CLOSE",
                            style: TextStyle(color: Colors.black),
                          ),
                          onPressed: () {
                            Get.back();
                          },
                        ),
                        GetBuilder<AddPostCtrl>(
                            init: AddPostCtrl(),
                            builder: (controller) {
                              return TextButton(
                                child: Text(
                                  "ADD",
                                  style: TextStyle(color: Colors.black),
                                ),
                                onPressed: () {
                                  if (controller.tagController.text != '') {
                                    controller.updateList(
                                        controller.tagController.text);
                                    controller.tagController.text = '';
                                    Get.back();
                                  }
                                },
                              );
                            })
                      ],
                    ),
                    barrierDismissible: false,
                  );
                },
              ),
            ],
          ),
          Container(
            child: GetX<AddPostCtrl>(
                init: AddPostCtrl(),
                builder: (controller) {
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.tagList.length,
                      itemBuilder: (context, index) {
                        return Container(
                          width: controller.tagList[index].length * 12.0,
                          margin: EdgeInsets.all(4.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4.0),
                            color: Colors.grey[300],
                          ),
                          child: Center(
                            child: Text(
                              controller.tagList[index],
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(color: Colors.black),
                            ),
                          ),
                        );
                      });
                }),
            width: SizeConfig.widthMultiplier * 60,
          ),
        ],
      ),
    );
  }
}
