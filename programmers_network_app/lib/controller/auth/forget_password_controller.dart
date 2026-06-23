import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

import 'package:get/get_state_manager/src/simple/get_controllers.dart';

import 'package:programmers_network_app/core/const/routesPage.dart';
import 'package:programmers_network_app/core/helper/user_storage.dart';
import 'package:programmers_network_app/data/services/auth/forget_password_services.dart';
import 'package:programmers_network_app/view/widget/auth/snackBar_controller_widget.dart';

class ForgetPasswordController extends GetxController {
  final ForgetPasswordServices forgetPasswordService = ForgetPasswordServices();

  final TextEditingController emailController = TextEditingController();

  bool isLoading = false;
  Future<void> forgetPassword() async {
    if (emailController.text.trim().isEmpty) {
      showSnackbar(
        title: "Validation Error",
        message: "Please enter your email",
        isError: true,
      );
      return;
    }

    try {
      isLoading = true;

      final response = await forgetPasswordService.forget(
        email: emailController.text.trim(),
      );

      await UserStorage.saveEmail(emailController.text.trim());

      Get.snackbar("Success", response.message);

      Get.offNamed(AppRoute.login);
    } on ForgetException catch (e) {
      switch (e.statusCode) {
        case 403:
          showSnackbar(title: "Forbidden", message: e.message, isError: true);
          break;

        case 404:
          showSnackbar(
            title: "Email Not Found",
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

        case 0:
          showSnackbar(
            title: "Connection Error",
            message: "Please check your internet connection.",
            isError: true,
          );
          break;

        default:
          showSnackbar(title: "Error", message: e.message, isError: true);
      }
    } finally {
      isLoading = false;
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
