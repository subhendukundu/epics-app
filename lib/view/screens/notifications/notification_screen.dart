import 'package:epics/controller/notification_ctrl.dart';
import 'package:epics/view/utils/SizedConfig.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'components/notification_list.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // extendBodyBehindAppBar: true,
      backgroundColor: Theme.of(context).primaryColor,
      appBar: AppBar(
        title: Text('Notifications'),
        backgroundColor: Theme.of(context).primaryColor,
        elevation: 0,
      ),
      body: GetBuilder<NotificationsController>(
          init: NotificationsController(),
          builder: (controller) {
            return RefreshIndicator(
                onRefresh: () => controller.getData(),
                child: Column(
                  children: [
                    NotificationList(),
                  ],
                ));
          }),
      extendBody: true,
    );
  }
}
