import 'package:epics/controller/add_post_Ctrl.dart';
import 'package:epics/view/utils/SizedConfig.dart';
import 'package:epics/view/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PrivacyWidget extends StatelessWidget {
  const PrivacyWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.heightMultiplier * 5,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text('Share with', style: Theme.of(context).textTheme.headline6),
          Container(
            child: GetX<AddPostCtrl>(
                init: AddPostCtrl(),
                builder: (controller) {
                  print(controller.seletedPrivacy);
                  return ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: controller.privacy.length,
                      physics: BouncingScrollPhysics(),
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            controller.seletedPrivacy.value = index;
                          },
                          child: Container(
                            margin: EdgeInsets.all(4.0),
                            width: controller.privacy[index].length *
                                Get.width *
                                0.035,
                            child: Center(
                                child: Text(
                              controller.privacy[index],
                              style: Theme.of(context)
                                  .textTheme
                                  .caption
                                  .copyWith(
                                      color: controller.seletedPrivacy.value ==
                                              index
                                          ? Colors.white
                                          : Colors.black),
                            )),
                            decoration: BoxDecoration(
                              color: controller.seletedPrivacy.value == index
                                  ? PINK_COLOR
                                  : Colors.grey[300],
                              borderRadius: BorderRadius.circular(4),
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
