import 'package:get/get.dart';
import '../auth_ctrl.dart';

class AuthBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuthController());
  }
}
