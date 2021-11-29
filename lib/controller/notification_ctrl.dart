import 'package:epics/controller/auth_ctrl.dart';
import 'package:epics/controller/user_info_Ctrl.dart';
import 'package:epics/model/models/notificaion_model.dart';
import 'package:epics/services/notification_service.dart';
import 'package:get/get.dart';

class NotificationsController extends GetxController {
  RxList<NotificationModel> notifications = <NotificationModel>[].obs;
  RxBool loading = true.obs;
  @override
  void onInit() {
    super.onInit();
    getData();
  }

  Future<void> getData() async {
    loading.value = true;
    String userUid = Get.find<AuthController>().userUid.value;
    notifications.value = [];
    NotificationService().getAllNotifications(userUid).then((value) {
      if (value.error == null) {
        value.data.forEach((e) {
          NotificationModel notificationModel = NotificationModel.fromMap(e);
          notifications.add(notificationModel);
        });
      } else {
        print(value.error.message);
      }
      loading.value = false;
    });
  }
}
