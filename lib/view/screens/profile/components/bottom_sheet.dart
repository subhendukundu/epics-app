import 'package:epics/controller/auth_ctrl.dart';
import 'package:epics/main.dart';
import 'package:epics/view/root_page.dart';
import 'package:epics/view/screens/authpage/login.dart';
import 'package:epics/view/screens/editprofile/edit_profile.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class BottomModelSheet extends StatelessWidget {
  const BottomModelSheet({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ModalScrollController.of(context),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.all(12.0),
            height: Get.height * 0.008,
            width: Get.width * 0.1,
            decoration: BoxDecoration(
              color: Colors.grey[350],
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          Divider(
            color: Colors.grey[350],
            height: 2,
          ),
          ListTile(
            leading: Icon(Icons.person_outline),
            onTap: () {
              Get.back();
              Get.to(() => EditProfile());
            },
            title: Text('Edit Profile'),
          ),
          ListTile(
            leading: Icon(Icons.logout_outlined),
            onTap: () async {
              await Supabase.instance.client.auth.signOut();

              Get.find<AuthController>().deleteUser();
              Get.offAll(() => RootPage());
              Get.reset();
            },
            title: Text('Log out'),
          ),
        ],
      ),
    );
  }
}
