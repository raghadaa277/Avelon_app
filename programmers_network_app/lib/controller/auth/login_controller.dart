import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:programmers_network_app/controller/auth/resend_verify_token_controller.dart';
import 'package:programmers_network_app/core/const/color_const.dart';

import 'package:programmers_network_app/core/const/routesPage.dart';
import 'package:programmers_network_app/core/helper/device_helper.dart';
import 'package:programmers_network_app/core/storage/token_storage.dart';
import 'package:programmers_network_app/data/services/auth/login_services.dart';
import 'package:programmers_network_app/view/widget/auth/snackBar_controller_widget.dart';

class LoginController extends GetxController {
  final LoginServices _loginServices = LoginServices();

  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final ResendVerifyTokenController _resendVerifyTokenController =
      ResendVerifyTokenController();

  void showEmailNotVerifiedDialog() {
    Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.mark_email_unread_outlined,
                size: 60,
                color: ColorConst.colorApp,
              ),

              const SizedBox(height: 15),

              const Text(
                "Email is not Verified",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              const Text(
                "Your account is not verified yet.\nPlease check your email or\n resend the verification link.",
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14),
              ),

              const SizedBox(height: 20),

              Row(
                children: [
                  Expanded(
                    child: TextButton(
                      onPressed: () => Get.back(),
                      child: Text(
                        "Cancel",
                        style: TextStyle(color: Colors.red[200]),
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Expanded(
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorConst.colorButton,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () async {
                        Get.back();

                        await _resendVerifyTokenController.resendToken(
                          email.text.trim(),
                        );
                      },
                      child: const Text(
                        "Resend",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
      barrierDismissible: false,
    );
  }

  bool isLoading = false;
  bool obscurePassword = true;

  Future<void> login() async {
    if (!formKey.currentState!.validate()) return;

    try {
      isLoading = true;
      update();

      final deviceData = await DeviceHelper.getDeviceData();

      final result = await _loginServices.login(
        fcmToken: "du14454641",
        email: email.text.trim(),
        password: password.text,
      );

      await TokenStorage.saveTokens(
        accessToken: result.data.accessToken,
        refreshToken: result.data.refreshToken,
      );
      await TokenStorage.saveDeviceId(deviceData["device_id"]!);
      Get.snackbar("Success", result.message);

      final onboardingDone = await TokenStorage.isOnboardingDone();
      final completion = result.data.profileCompletion;
      final completionValue = int.tryParse(completion.replaceAll('%', '')) ?? 0;

      if (onboardingDone || completionValue > 0) {
        await TokenStorage.setOnboardingDone();
        Get.offAllNamed(AppRoute.homePage);
      } else {
        Get.offNamed(AppRoute.source, arguments: result.data.profileCompletion);
      }

      // await TokenStorage.saveTokens(
      //   accessToken: result.data.accessToken,
      //   refreshToken: result.data.refreshToken,
      // );
      // await TokenStorage.saveDeviceId(deviceData["device_id"]!);
      // Get.snackbar("Success", result.message);

      // if (result.data.user.onboardingCompletedAt != null) {
      //   await TokenStorage.setOnboardingDone();
      //   Get.offAllNamed(AppRoute.homePage);
      // } else {
      //   Get.offNamed(AppRoute.source, arguments: result.data.profileCompletion);
      // }
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
          showEmailNotVerifiedDialog();
          // showSnackbar(
          //   title: "Account Not Verified",
          //   message: e.message,
          //   isError: true,
          // );
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
