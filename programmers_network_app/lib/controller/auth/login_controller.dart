import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:programmers_network_app/core/const/routesPage.dart';
import 'package:programmers_network_app/core/storage/token_storage.dart';
import 'package:programmers_network_app/data/services/auth/login_services.dart';
import 'package:programmers_network_app/view/widget/auth/snackBar_controller_widget.dart';

class LoginController extends GetxController {
  final LoginServices _loginServices = LoginServices();

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;
  bool obscurePassword = true;

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading = true;
      update();

      final result = await _loginServices.login(
        fcmToken: "dummy_fcm_token_raghad",
        email: email.text.trim(),
        password: password.text,
      );
      await TokenStorage.saveTokens(
        accessToken: result.data.accessToken,
        refreshToken: result.data.refreshToken,
      );
      Get.snackbar("Success", result.message);
      Get.offNamed(AppRoute.source);
    } on LoginException catch (e) {
      switch (e.statusCode) {
        case 401:
          showSnackbar(
            title: "Invalid Credentials",
            message: e.message,
            isError: true,
          );
          break;
        case 403:
          showSnackbar(
            title: "Account Not Verified",
            message: e.message,
            isError: true,
          );
          break;
        case 428:
          showSnackbar(
            title: "Validation Error",
            message: e.message,
            isError: true,
          );
          break;
        case 429:
          showSnackbar(
            title: "Too Many Requests",
            message: e.message,
            isWarning: true,
          );
          break;
        case 500:
          showSnackbar(
            title: "Server Error",
            message: e.message,
            isError: true,
          );
          break;
        default:
          showSnackbar(title: "Error", message: e.message, isError: true);
      }
    } finally {
      isLoading = false;
      update();
    }
  }

  void togglePasswordVisibility() {
    obscurePassword = !obscurePassword;
    update();
  }

  @override
  void onClose() {
    email.dispose();
    password.dispose();
    super.onClose();
  }
}
