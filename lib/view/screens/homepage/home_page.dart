import 'package:epics/controller/post_cntrl.dart';
import 'package:epics/services/user_info.dart';
import 'package:epics/view/utils/SizedConfig.dart';
import 'package:epics/view/widgets/audioplay_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart' hide AnimatedScale;
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'component/post_tile.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
        title: Center(
          child: Image.asset(
            'assets/epics_logo.png',
            height: 80,
            width: 80,
          ),
        ),
      ),
      body: GetBuilder<PostController>(
          init: PostController(),
          builder: (controller) {
            return RefreshIndicator(
              onRefresh: () => controller.getData(),
              child: Column(
                children: [
                  PostList(),
                  SizedBox(
                    height: Get.height * 0.1,
                  )
                ],
              ),
            );
          }),
      extendBody: true,
      bottomNavigationBar:
          SizedBox(height: Get.height * 0.25, child: PlayAudioWidget()),
    );
  }
}
