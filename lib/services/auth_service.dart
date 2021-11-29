import 'package:epics/controller/auth_ctrl.dart';
import 'package:epics/controller/login_ctrl.dart';
import 'package:epics/controller/phoneauth_ctrl.dart';
import 'package:epics/view/root_page.dart';
import 'package:epics/view/screens/getName/userName.dart';
import 'package:epics/view/screens/phoneAuth/phone_auth.dart';
import 'package:jwt_decode/jwt_decode.dart';
import 'package:epics/view/widgets/custom_toast.dart';
import 'package:get/get.dart';
import 'package:supabase/supabase.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  Future<bool> signUp(String email, String password, String name) async {
    Get.put(AuthController());
    return await Supabase.instance.client.auth
        .signUp(email, password)
        .then((value) {
      if (value.error == null) {
        // addUsertoTables(name, value.data.user.id);
        Get.find<AuthController>().saveUser(value.data.user.id);

        // UserInfoService().addUsertoTable(name, email, value.data.user.id);

        Get.offAll(() => RootPage());
        Get.reset();
        return false;
      } else {
        Get.snackbar('Error', value.error.message);
        return true;
      }
    });
  }

  void addUsertoTables({String phone, String id}) async {
    try {
      Supabase.instance.client
          .from('user_info')
          .insert({'user_id': id, 'phone': phone})
          .execute()
          .then((value) {
            if (value.error == null) {
              Get.to(() => GetUserName());
            } else {
              Get.offAll(() => Root());
            }
            print("VALUE: ${value.data}");
            print("ERROR: ${value.error.message}");
          });
    } catch (e) {
      print(e.toString());
    }
  }

  Future<bool> signIn(String email, String password) async {
    return await Supabase.instance.client.auth
        .signIn(email: email, password: password)
        .then((value) {
      if (value.error == null) {
        Get.put(AuthController());
        Get.find<AuthController>().saveUser(value.data.user.id);
        Get.offAll(RootPage());

        Get.reset();
        return false;
      } else {
        Get.snackbar('Error', value.error.message);
        return true;
      }
    });
  }

  Future<void> googleSignin() async {
    print("Sign in");
    AuthOptions options = AuthOptions(
        redirectTo:
            'https://knxacvdbymaylbikghui.supabase.co/auth/v1/callback');
    Supabase.instance.client.auth
        .signInWithProvider(Provider.google, options: options)
        .then((value) {
      if (value) {
        Future.delayed(Duration(seconds: 3), () {
          Get.offAll(() => RootPage());
          Get.reset();
        });
      }
    });
  }

  signInWithPhoneNumber({String phomeNumber, String password}) async {
    return await Supabase.instance.client.auth
        .signUpWithPhone(phomeNumber, password)
        .then((value) {
      if (value.error != null) {
        showMessage(title: 'Error', message: '${value.error.message}');
        return false;
      } else {
        return true;
      }
    });
  }

  signInWithPhone({String phoneNumber}) async {
    Get.put(PhoneAuthCtrl());
    await Supabase.instance.client.auth
        .signIn(phone: phoneNumber)
        .then((value) {
      if (value.error == null) {
        Get.find<PhoneAuthCtrl>().phoneNumber = phoneNumber;
        Get.to(() => PhoneAuth());
        Get.find<LoginCtrl>().loading.value = false;
        // Get.put(AuthController());
        // UserInfoService()
        //     .addUsertoTable(value.data.user.email, value.data.user.id);
        // Get.find<AuthController>().saveUser(value.data.user.id).then((value) {
        //   Get.offAll(() => Root());
        // });
      }
      if (value.error != null) {
        Get.find<LoginCtrl>().loading.value = false;
        print(value.error.message);
        showMessage(title: 'Error', message: '${value.error.message}');
      }
    });
  }

  signWithPhoneNumber({String phomeNumber, String password}) async {
    await Supabase.instance.client.auth
        .signUpWithPhone(phomeNumber, password)
        .then((value) {});
  }

  verifyCode({String phomeNumber, String otp}) async {
    await Supabase.instance.client.auth
        .verifyOTP(phomeNumber, otp)
        .then((value) {
      if (value.error == null) {
        Map<String, dynamic> payload = Jwt.parseJwt(value.data.accessToken);
        addUsertoTables(phone: payload["phone"], id: payload["sub"]);
        Get.find<AuthController>().saveUser(payload["sub"]);
      }
      if (value.error != null) {
        showMessage(title: 'Error', message: '${value.error.message}');
      }
    });
  }
}
