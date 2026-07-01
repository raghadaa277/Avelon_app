import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:programmers_network_app/data/services/auth/register_services.dart';
import 'package:programmers_network_app/view/screen/auth/verify_page.dart';

class RegisterController extends GetxController {
  final RegisterServices registerServices = RegisterServices();

  final TextEditingController fullName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController passwordConfirmation = TextEditingController();
  bool obscureConfirmPassword = true;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  bool isLoading = false;
  bool obscurePassword = true;

  bool hasMinLength = false;
  bool hasUpperAndLower = false;
  bool hasNumber = false;
  bool hasSpecialChar = false;

  void onPasswordChanged(String value) {
    hasMinLength = value.length >= 8;
    hasUpperAndLower =
        value.contains(RegExp(r'[A-Z]')) && value.contains(RegExp(r'[a-z]'));
    hasNumber = value.contains(RegExp(r'[0-9]'));
    hasSpecialChar = value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'));
    update();
  }

  Future<void> register() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading = true;
      update();

      final result = await registerServices.register(
        fullName: fullName.text.trim(),
        email: email.text.trim(),
        password: password.text,
        passwordConfirmation: passwordConfirmation.text,
      );

      Get.snackbar("Success", result.message);

      Get.to(() => const VerifyPage(), arguments: result.data.email);
    } catch (e) {
      Get.snackbar("Error", e.toString().replaceFirst("Exception: ", ""));
    } finally {
      isLoading = false;
      update();
    }
  }

  @override
  void onClose() {
    fullName.dispose();
    email.dispose();
    password.dispose();
    passwordConfirmation.dispose();
    super.onClose();
  }
}
