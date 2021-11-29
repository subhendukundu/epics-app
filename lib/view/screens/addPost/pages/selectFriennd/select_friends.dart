import 'package:epics/controller/add_post_Ctrl.dart';
import 'package:epics/model/models/userinfo.dart';
import 'package:epics/services/userinfo_service.dart';
import 'package:epics/view/utils/SizedConfig.dart';
import 'package:epics/view/utils/colors.dart';
import 'package:epics/view/utils/consts.dart';
import 'package:epics/view/widgets/dpPreview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:get/get.dart';

class SelectFriends extends StatefulWidget {
  const SelectFriends({Key key}) : super(key: key);

  @override
  static TextEditingController searchController = TextEditingController();
  //  List<UserInfoModel> allUsers = <UserInfoModel>[];

  @override
  _SelectFriendsState createState() => _SelectFriendsState();
}

class _SelectFriendsState extends State<SelectFriends> {
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: const Text('Select Friends'),
      ),
      body: FutureBuilder(
          future: UserInfoService().getUserFollowersData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  // value: 1,
                  strokeWidth: 2,
                ),
              );
            }
            List<UserInfoModel> followedUserList = [];
            snapshot.data.data.forEach((e) {
              followedUserList.add(UserInfoModel.fromMap(e["user_from"]));
            });
            Get.find<AddPostCtrl>().searchList.value = followedUserList;

            return GetX<AddPostCtrl>(
                init: AddPostCtrl(),
                builder: (controller) {
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 16.0),
                        child: PhysicalModel(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(6),
                          elevation: 1,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                horizontal: 8, vertical: 4),
                            child: TextField(
                              controller: SelectFriends.searchController,
                              textAlignVertical: TextAlignVertical.center,
                              decoration: InputDecoration(
                                  hintText: 'Search',
                                  border: InputBorder.none,
                                  prefixIcon: Icon(Icons.search)),
                              onChanged: (value) {
                                controller.searchList.value =
                                    followedUserList.where((note) {
                                  var noteTile = note.userName.toUpperCase();

                                  return noteTile.contains(SelectFriends
                                      .searchController.text
                                      .toUpperCase());
                                }).toList();
                              },
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        child: Container(
                          child: GridView.builder(
                              shrinkWrap: true,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 2.8, crossAxisCount: 2),
                              itemCount: controller.searchList.value.length,
                              itemBuilder: (context, index) {
                                return GetX<AddPostCtrl>(
                                    init: AddPostCtrl(),
                                    builder: (controller) {
                                      return InkWell(
                                        onTap: () {
                                          if (controller.selectedFollowers
                                              .contains(controller
                                                  .searchList[index].userId)) {
                                            controller.selectedFollowers.remove(
                                                controller
                                                    .searchList[index].userId);
                                          } else {
                                            controller.selectedFollowers.add(
                                                controller
                                                    .searchList[index].userId);
                                          }
                                        },
                                        child: Card(
                                          elevation: 3,
                                          margin: EdgeInsets.all(4.0),
                                          shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8.0)),
                                          child: Container(
                                            margin: EdgeInsets.all(8.0),
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4.0)),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                controller.searchList[index]
                                                            .userAvatar !=
                                                        null
                                                    ? GestureDetector(
                                                        onTap: () => Get.to(() =>
                                                            FullImagePreview(
                                                                imageUrl:
                                                                    NETWORK_IMAGE_URL +
                                                                        '${controller.searchList[index].userAvatar}',
                                                                blurHash: controller
                                                                    .searchList[
                                                                        index]
                                                                    .blurHash)),
                                                        child: Container(
                                                          // margin: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                                                          width: SizeConfig
                                                                  .heightMultiplier *
                                                              6,
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        6),
                                                            child: BlurHash(
                                                              image: NETWORK_IMAGE_URL +
                                                                  '${controller.searchList[index].userAvatar}',
                                                              hash: controller
                                                                  .searchList[
                                                                      index]
                                                                  .blurHash,
                                                            ),
                                                          ),
                                                        ))
                                                    : Image.asset(
                                                        'assets/default.jpeg'),
                                                SizedBox(
                                                  width: SizeConfig
                                                          .heightMultiplier *
                                                      8,
                                                  child: Text(
                                                    controller.searchList[index]
                                                        .userName,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: TextStyle(
                                                        fontWeight:
                                                            FontWeight.w600),
                                                  ),
                                                ),
                                                Checkbox(
                                                  checkColor: Colors.white,
                                                  fillColor: controller
                                                          .selectedFollowers
                                                          .contains(controller
                                                              .searchList[index]
                                                              .userId)
                                                      ? MaterialStateProperty
                                                          .all(PINK_COLOR)
                                                      : MaterialStateProperty
                                                          .all(Colors.grey),
                                                  value: controller
                                                      .selectedFollowers
                                                      .contains(controller
                                                          .searchList[index]
                                                          .userId),
                                                  shape: CircleBorder(),
                                                  onChanged: (bool value) {
                                                    if (controller
                                                        .selectedFollowers
                                                        .contains(controller
                                                            .searchList[index]
                                                            .userId)) {
                                                      controller
                                                          .selectedFollowers
                                                          .remove(controller
                                                              .searchList[index]
                                                              .userId);
                                                    } else {
                                                      controller
                                                          .selectedFollowers
                                                          .add(controller
                                                              .searchList[index]
                                                              .userId);
                                                    }
                                                  },
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      );
                                    });
                              }),
                        ),
                      )
                    ],
                  );
                });
          }),
    );
  }
}
