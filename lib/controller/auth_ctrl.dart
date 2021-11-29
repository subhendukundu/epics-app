import 'package:get/get.dart';
import 'package:hive/hive.dart';

class AuthController extends GetxController {
  RxString userUid = ''.obs;

  @override
  void onInit() {
    super.onInit();
    getUser();
  }

  Future<void> getUser() async {
    final settings = await Hive.openBox('settings');
    userUid.value = settings.get('userUid') ?? '';
  }

  Future<void> saveUser(String uid) async {
    final settings = await Hive.openBox('settings');
    userUid.value = uid;
    settings.put('userUid', uid);
  }

  Future<void> deleteUser() async {
    final settings = await Hive.openBox('settings');
    userUid.value = '';
    settings.delete('userUid');
  }
}
