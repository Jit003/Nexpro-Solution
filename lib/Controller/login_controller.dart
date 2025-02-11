import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:nexpro_solution/Screens/Home%20Screen/home_screen.dart';
import '../Api Services/api_helper.dart';

class AuthController extends GetxController {
  static AuthController get to => Get.find();

  var isLoading = false.obs;
  var email = ''.obs;
  var password = ''.obs;
  var loginResponse = {}.obs;
  var isLoggedIn = false.obs;


  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }

  /// Check if the user is already logged in
  Future<void> checkLoginStatus() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    isLoggedIn.value = prefs.getBool('isLoggedIn') ?? false;

    if (isLoggedIn.value) {
      Get.offAll(() => LeadsScreen());
    }
  }

  /// Perform Login
  Future<void> login() async {
    if (email.value.isEmpty || password.value.isEmpty) {
      Get.snackbar('Error', 'Email and Password cannot be empty');
      return;
    }
    isLoading.value = true;
    var response = await ApiHelper.adminLogin(email.value, password.value);

    if (response != null && !response.containsKey('error')) {
      loginResponse.value = response;

      // Save login status
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setBool('isLoggedIn', true);

      Get.snackbar('Success', 'Login Successful');
      isLoggedIn.value = true;
      Get.offAll(() => LeadsScreen());
    } else {
      Get.snackbar('Error', response?['error'] ?? 'Login failed');
    }

    isLoading.value = false;
  }

}
