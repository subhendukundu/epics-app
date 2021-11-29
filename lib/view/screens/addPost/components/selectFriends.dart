import 'package:epics/controller/add_post_Ctrl.dart';
import 'package:epics/services/userinfo_service.dart';
import 'package:epics/view/screens/addPost/pages/selectFriennd/select_friends.dart';
import 'package:epics/view/utils/SizedConfig.dart';
import 'package:epics/view/utils/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:postgrest/postgrest.dart';

class SelectFriendsWidget extends StatefulWidget {
  const SelectFriendsWidget({Key key}) : super(key: key);

  @override
  _SelectFriendsWidgetState createState() => _SelectFriendsWidgetState();
}

class _SelectFriendsWidgetState extends State<SelectFriendsWidget> {
  @override
  bool _value = false;

  Widget build(BuildContext context) {
    return GetX<AddPostCtrl>(
        init: AddPostCtrl(),
        builder: (controller) {
          return controller.seletedPrivacy.value == 1
              ? FutureBuilder(
                  future: UserInfoService().getUserFollowers(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(
                          // value: 1,
                          strokeWidth: 2,
                        ),
                      );
                    }
                    if (_value) {
                      snapshot.data.data.forEach((e) {
                        controller.selectedFollowers.add(e["user_from"]);
                      });
                      print(controller.selectedFollowers);
                    } else {
                      controller.selectedFollowers = <String>[].obs;
                    }

                    return Column(
                      children: [
                        if (controller.seletedPrivacy.value == 1)
                          Container(
                            height: SizeConfig.heightMultiplier * 15,
                            child: ListView(
                              physics: BouncingScrollPhysics(),
                              shrinkWrap: true,
                              children: [
                                ListTile(
                                  onTap: () {
                                    setState(() {
                                      _value = !_value;
                                    });
                                  },
                                  leading: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.black.withOpacity(0.07),
                                    ),
                                    child: IconButton(
                                      icon: Icon(Icons.people),
                                      splashColor: Colors.transparent,
                                      highlightColor: Colors.transparent,
                                      onPressed: () {},
                                    ),
                                  ),
                                  title: Text('Share with all friends'),
                                  trailing: Checkbox(
                                    checkColor: Colors.white,
                                    fillColor: _value
                                        ? MaterialStateProperty.all(PINK_COLOR)
                                        : MaterialStateProperty.all(
                                            Colors.grey),
                                    value: _value,
                                    shape: CircleBorder(),
                                    onChanged: (bool value) {
                                      setState(() {
                                        _value = value;
                                      });
                                    },
                                  ),
                                ),
                                ListTile(
                                    onTap: () => Get.to(() => SelectFriends(),
                                        transition: Transition.downToUp),
                                    leading: Container(
                                      // margin: EdgeInsets.all(2.0),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(8),
                                        color: Colors.black.withOpacity(0.07),
                                      ),
                                      child: IconButton(
                                        icon: Icon(Icons.people_alt_outlined),
                                        splashColor: Colors.transparent,
                                        highlightColor: Colors.transparent,
                                        onPressed: () {},
                                      ),
                                    ),
                                    title: Text('Select friends to share with'),
                                    trailing: Padding(
                                      padding: const EdgeInsets.only(right: 8),
                                      child: Icon(Icons.arrow_forward_ios),
                                    )),
                              ],
                            ),
                          )
                      ],
                    );
                  })
              : SizedBox();
        });
  }
}
