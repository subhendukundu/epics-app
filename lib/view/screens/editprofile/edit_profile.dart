import 'package:epics/controller/edit_profile_ctrl.dart';
import 'package:epics/controller/user_info_Ctrl.dart';
import 'package:epics/services/user_info.dart';
import 'package:epics/view/utils/SizedConfig.dart';
import 'package:epics/view/utils/colors.dart';
import 'package:epics/view/utils/consts.dart';
import 'package:epics/view/widgets/dpPreview.dart';
import 'package:epics/view/widgets/post_text_field.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart' hide AnimatedScale;
import 'package:get/get.dart';

class EditProfile extends StatelessWidget {
  const EditProfile({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Profile'),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        actions: [
          GetBuilder<EditProfileCtrl>(
              init: EditProfileCtrl(),
              builder: (controller) {
                return IconButton(
                  padding: EdgeInsets.only(top: 6),
                  onPressed: () {
                    if (controller.nameController.text != '') {
                      if (controller.imagePicked.value) {
                        UserInfoService().uploadImage(
                            controller.pickedProfile,
                            controller.nameController.text,
                            controller.bioController.text);
                        Get.back();
                      } else {
                        UserInfoService().updateNameBio(
                            controller.nameController.text,
                            controller.bioController.text);
                        Get.back();
                      }
                    } else {
                      Get.snackbar('Error', 'Enter Your Name');
                    }
                  },
                  icon: Icon(
                    Icons.check,
                    color: PINK_COLOR,
                  ),
                );
              })
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            GetX<EditProfileCtrl>(
                init: EditProfileCtrl(),
                builder: (controller) {
                  return GestureDetector(
                    onTap: () {
                      controller.pickProfilePicture().then((value) {
                        controller.imagePicked.value = true;
                      });
                    },
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Get.find<UserInfoController>()
                                  .usetInfo
                                  .value
                                  .userAvatar !=
                              null
                          ? Container(
                              width: SizeConfig.widthMultiplier * 20,
                              height: SizeConfig.heightMultiplier * 10,
                              child: GestureDetector(
                                onTap: () => Get.to(
                                  () => FullImagePreview(
                                      imageUrl: NETWORK_IMAGE_URL +
                                          '${Get.find<UserInfoController>().usetInfo.value.userAvatar}',
                                      blurHash: Get.find<UserInfoController>()
                                          .usetInfo
                                          .value
                                          .blurHash),
                                ),
                                child: BlurHash(
                                  image: NETWORK_IMAGE_URL +
                                      '${Get.find<UserInfoController>().usetInfo.value.userAvatar}',
                                  hash: Get.find<UserInfoController>()
                                      .usetInfo
                                      .value
                                      .blurHash,
                                ),
                              ),
                            )
                          : controller.imagePicked.value
                              ? Image.file(
                                  controller.pickedProfile,
                                  fit: BoxFit.fill,
                                  width: SizeConfig.widthMultiplier * 20,
                                  height: SizeConfig.heightMultiplier * 10,
                                )
                              : Image.asset('assets/default.jpeg',
                                  width: SizeConfig.widthMultiplier * 20,
                                  height: SizeConfig.heightMultiplier * 10,
                                  fit: BoxFit.fill),
                    ),
                  );
                }),
            SizedBox(
              height: 10,
            ),
            GetBuilder<EditProfileCtrl>(
                init: EditProfileCtrl(),
                builder: (controller) {
                  return GestureDetector(
                    onTap: () {
                      controller.pickProfilePicture().then((value) {
                        controller.imagePicked.value = true;
                      });
                    },
                    child: Text(
                      'Change Profile Photo',
                      style: TextStyle(
                        color: PINK_COLOR,
                        fontSize: SizeConfig.textMultiplier * 2.5,
                      ),
                    ),
                  );
                }),
            SizedBox(height: 30),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Name',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(color: Colors.grey[500]),
                ),
                GetBuilder<EditProfileCtrl>(
                    init: EditProfileCtrl(),
                    builder: (controller) {
                      controller.nameController.text =
                          Get.find<UserInfoController>()
                              .usetInfo
                              .value
                              .userName;
                      return PostTextField(
                        controller: controller.nameController,
                      );
                    }),
                SizedBox(height: 20),
                Text(
                  'Bio',
                  style: Theme.of(context)
                      .textTheme
                      .subtitle1
                      .copyWith(color: Colors.grey[500]),
                ),
                GetBuilder<EditProfileCtrl>(
                    init: EditProfileCtrl(),
                    builder: (controller) {
                      controller.bioController.text =
                          Get.find<UserInfoController>().usetInfo.value.bio;
                      return PostTextField(
                        controller: controller.bioController,
                      );
                    }),
              ],
            )
          ],
        ),
      ),
    );
  }
}
