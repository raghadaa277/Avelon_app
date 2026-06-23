import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:programmers_network_app/core/const/color_const.dart';
import 'package:programmers_network_app/data/services/auth/resend_verify_token_services.dart';

class ResendVerifyTokenController extends GetxController {
  final ResendVerifyTokenServices resendVerifyTokenServices =
      ResendVerifyTokenServices();

  final TextEditingController emailController = TextEditingController();

  bool isLoading = false;
  bool isVerifying = false;
  String? errorMessage;

  Future<void> resendToken(String email) async {
    try {
      isLoading = true;
      errorMessage = null;
      update();

      final result = await resendVerifyTokenServices.resendToken(email: email);

      if (result.success) {
        Get.snackbar(
          'Success',
          result.message,
          backgroundColor: ColorConst.colorApp,
          colorText: Colors.white,
          snackPosition: SnackPosition.TOP,
        );
      }
    } catch (e) {
      errorMessage = e.toString().replaceFirst('Exception: ', '');

      Get.snackbar(
        'Error',
        errorMessage!,
        backgroundColor: Colors.red[200],
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
      );
    } finally {
      isLoading = false;
      update();
    }
  }

  @override
  void onClose() {
    emailController.dispose();
    super.onClose();
  }
}
