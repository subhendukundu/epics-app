import 'dart:io';
import 'package:epics/controller/add_post_Ctrl.dart';
import 'package:epics/controller/auth_ctrl.dart';
import 'package:epics/model/models/post_model.dart';
import 'package:epics/services/post_service.dart';
import 'package:epics/view/screens/addPost/pages/editpost/editing_photo.dart';
import 'package:epics/view/utils/SizedConfig.dart';
import 'package:epics/view/utils/colors.dart';
import 'package:epics/view/widgets/custom_toast.dart';
import 'package:epics/view/widgets/dpPreview.dart';
import 'package:epics/view/widgets/post_text_field.dart';
import 'package:epics/view/widgets/progress.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:get/get.dart';
import 'components/privacy_widget.dart';
import 'components/selectFriends.dart';
import 'components/tages.dart';
import 'pages/searchSong/searchSong.dart';

class SingleImageUpload extends StatefulWidget {
  @override
  _SingleImageUploadState createState() {
    return _SingleImageUploadState();
  }
}

class _SingleImageUploadState extends State<SingleImageUpload> {
  // ignore: deprecated_member_use

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: const Text('Add Post'),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            buildGridView(),
            Container(
              margin: EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Title',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  GetBuilder<AddPostCtrl>(
                      init: AddPostCtrl(),
                      builder: (controller) {
                        return PostTextField(
                          formKey: controller.titleKey,
                          controller: controller.titleController,
                          hint: 'Title',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Title is empty';
                            }
                            return null;
                          },
                        );
                      }),
                  SizedBox(height: SizeConfig.heightMultiplier * 2),
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  GetBuilder<AddPostCtrl>(
                      init: AddPostCtrl(),
                      builder: (controller) {
                        return PostTextField(
                          formKey: controller.descriptionKey,
                          controller: controller.descriptionController,
                          hint: 'Description',
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Description is empty';
                            }
                            return null;
                          },
                        );
                      }),
                  SizedBox(height: SizeConfig.heightMultiplier * 2),
                  AddTags(),
                  SizedBox(height: SizeConfig.heightMultiplier * 2),
                  PrivacyWidget(),
                  SizedBox(height: SizeConfig.heightMultiplier * 2),
                  SelectFriendsWidget(),
                  SizedBox(height: SizeConfig.heightMultiplier * 2),
                  Text(
                    'Add Song',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 12),
                    child: GetX<AddPostCtrl>(
                        init: AddPostCtrl(),
                        builder: (controller) {
                          if (controller.songPickedforPost.value) {
                            return Column(
                              children: [
                                ListTile(
                                  leading: Container(
                                    width: SizeConfig.widthMultiplier * 14,
                                    // margin: EdgeInsets.all(2.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      image: DecorationImage(
                                        image: NetworkImage(controller
                                            .playingTrack
                                            .album
                                            .images
                                            .first
                                            .url),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                  title: Text(controller.playingTrack.name),
                                  trailing: GestureDetector(
                                      onTap: () {
                                        controller.playingTrack = null;
                                        controller.songPickedforPost.value =
                                            false;
                                      },
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8),
                                        child: Icon(Icons.cancel),
                                      )),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                ListTile(
                                  onTap: () {
                                    Get.to(() => SearchSong()).then((value) {
                                      setState(() {});
                                    });
                                  },
                                  leading: Container(
                                    // margin: EdgeInsets.all(2.0),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.black.withOpacity(0.07),
                                    ),
                                    child: IconButton(
                                      icon: Icon(Icons.restart_alt),
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onPressed: () {},
                                    ),
                                  ),
                                  trailing: Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: Icon(Icons.arrow_forward_ios),
                                  ),
                                  title: Text('Change Song'),
                                ),
                              ],
                            );
                          } else {
                            return ListTile(
                              onTap: () {
                                Get.to(() => SearchSong());
                              },
                              leading: Container(
                                // margin: EdgeInsets.all(2.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8),
                                  color: Colors.black.withOpacity(0.07),
                                ),
                                child: IconButton(
                                  icon: Icon(Icons.add),
                                  splashColor: Colors.transparent,
                                  highlightColor: Colors.transparent,
                                  onPressed: () {},
                                ),
                              ),
                              trailing: Padding(
                                padding: const EdgeInsets.only(right: 8),
                                child: Icon(Icons.arrow_forward_ios),
                              ),
                              title: Text('Add a Song'),
                            );
                          }
                        }),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: GetX<AddPostCtrl>(
          init: AddPostCtrl(),
          builder: (controller) {
            return GestureDetector(
              onTap: () {
                if (controller.posting.value) {
                  showMessage(title: 'Please wait', message: 'Please wait');
                } else {
                  controller.posting.value = true;
                  if (controller.images.length > 1) {
                    if (controller.titleKey.currentState.validate() &&
                        controller.descriptionKey.currentState.validate()) {
                      if (controller.trckPickedForPost != null) {
                        print(controller.selectedFollowers.value);
                        controller.loading.value = true;
                        List<File> pickedImages = [];
                        for (int i = 0; i < controller.images.length - 1; i++) {
                          ImageUploadModel image = controller.images[i];
                          pickedImages.add(image.imageFile);
                        }
                        PostsModel postModel = PostsModel();
                        postModel.title = controller.titleController.text;
                        postModel.description =
                            controller.descriptionController.text;
                        // ignore: invalid_use_of_protected_member
                        postModel.tags = controller.tagList.value;
                        postModel.accessTo = controller.selectedFollowers.value;
                        postModel.songName = controller.trckPickedForPost.name;
                        postModel.songImage =
                            controller.trckPickedForPost.album.images[0].url;
                        postModel.songUrl =
                            controller.trckPickedForPost.previewUrl;
                        postModel.privacy =
                            controller.privacy[controller.seletedPrivacy.value];
                        postModel.userId =
                            Get.find<AuthController>().userUid.value;
                        postModel.blurHash = controller.blurHashList;
                        postModel.createdOn = DateTime.now();
                        postModel.updatedOn = DateTime.now();
                        print(postModel.toMap());

                        PostService().addPost(
                            postModel: postModel, imageList: pickedImages);
                      } else {
                        controller.posting.value = false;
                        Get.snackbar('Error', 'Pick Track To Post');
                      }
                    }
                  } else {
                    controller.posting.value = false;
                    Get.snackbar('Error', 'Pick Image To Post');
                  }
                }
              },
              child: Container(
                margin: EdgeInsets.all(12.0),
                height: 55.0,
                width: SizeConfig.widthMultiplier * 90,
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                      Color(0xFFB817D9),
                      Color(0xFFD226AB),
                    ]),
                    borderRadius: BorderRadius.circular(8.0)),
                child: Center(
                  child: controller.loading.value
                      ? circularProgress(Colors.white)
                      : Text('Post',
                          style: TextStyle(
                              color: Theme.of(context).highlightColor,
                              fontSize: 18,
                              fontWeight: FontWeight.w600)),
                ),
              ),
            );
          }),
    );
  }

  Widget buildGridView() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GetX<AddPostCtrl>(
          init: AddPostCtrl(),
          builder: (controller) {
            return GridView.count(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              crossAxisCount: 3,
              childAspectRatio: 1,
              children: List.generate(controller.images.length, (index) {
                if (controller.images[index] is ImageUploadModel) {
                  ImageUploadModel uploadModel =
                      controller.images[index] as ImageUploadModel;
                  return FocusedMenuHolder(
                    openWithTap: true,
                    child: Container(
                      margin: EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        color: Colors.black.withOpacity(0.07),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.file(
                          uploadModel.imageFile,
                          height: SizeConfig.heightMultiplier * 15,
                          width: SizeConfig.widthMultiplier * 30,
                          fit: BoxFit.contain,
                        ),
                      ),
                    ),
                    onPressed: () {},
                    menuItems: <FocusedMenuItem>[
                      // Add Each FocusedMenuItem  for Menu Options
                      FocusedMenuItem(
                        title: Text("Preview"),
                        trailingIcon: Icon(Icons.open_in_new),
                        onPressed: () => Get.to(() =>
                            FullImagePreview(imageFile: uploadModel.imageFile)),
                      ),

                      FocusedMenuItem(
                          title: Text("Edit"),
                          trailingIcon: Icon(Icons.edit),
                          onPressed: () {
                            Navigator.push(
                              context,
                              CupertinoPageRoute(
                                builder: (context) => EditPhotoScreen(
                                  arguments: [uploadModel.imageFile],
                                  index: index,
                                ),
                              ),
                            );
                          }),
                      FocusedMenuItem(
                          title: Text(
                            "Remove",
                            style: TextStyle(color: Colors.redAccent),
                          ),
                          trailingIcon: Icon(
                            Icons.delete,
                            color: Colors.redAccent,
                          ),
                          onPressed: () {
                            controller.images.removeAt(index);
                            controller.blurHashList.removeAt(index);
                          }),
                    ],
                  );
                } else {
                  return Container(
                    margin: EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.black.withOpacity(0.07),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.add),
                      splashColor: Colors.transparent,
                      highlightColor: Colors.transparent,
                      onPressed: () {
                        controller.onAddImageClick(index);
                      },
                    ),
                  );
                }
              }),
            );
          }),
    );
  }

  void _FullImagePreview(context, ImageUploadModel image) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.transparent,
        content: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Image.file(image.imageFile),
        ),
      ),
    );
  }
}
