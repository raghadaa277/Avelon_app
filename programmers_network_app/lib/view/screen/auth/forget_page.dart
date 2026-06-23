import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:programmers_network_app/controller/auth/forget_password_controller.dart';
import 'package:programmers_network_app/core/const/color_const.dart';
import 'package:programmers_network_app/core/const/routesPage.dart';
import 'package:programmers_network_app/view/widget/auth/button_customer.dart';
import 'package:programmers_network_app/view/widget/auth/text_field_customer.dart';
import 'package:programmers_network_app/view/widget/auth/verify_icon_widget.dart';
import 'package:programmers_network_app/view/widget/logo.dart';

class ForgetPasswordPage extends StatefulWidget {
  const ForgetPasswordPage({super.key});

  @override
  State<ForgetPasswordPage> createState() => _ForgetPasswordPageState();
}

class _ForgetPasswordPageState extends State<ForgetPasswordPage> {
  final ForgetPasswordController forgetPasswordController = Get.put(
    ForgetPasswordController(),
  );

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ForgetPasswordController>(
      builder: (forgetPasswordController) {
        return Scaffold(
          backgroundColor: ColorConst.colorBackGroung,
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                children: [
                  BuildLogo(),
                  const SizedBox(height: 32),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(28),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.05),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: Form(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 5,
                              ),
                              decoration: BoxDecoration(
                                color: ColorConst.colorBackGroung,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: ColorConst.colorButton.withValues(
                                    alpha: 0.15,
                                  ),
                                ),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  VerifyHugeIconWidget(
                                    icon: HugeIcons.strokeRoundedForgotPassword,
                                    size: 32,
                                    iconSize: 18,
                                    iconColor: ColorConst.colorButton,
                                    backgroundColor: const Color(0xFFF3FCE5),
                                  ),

                                  const SizedBox(width: 10),

                                  const Text(
                                    "SECURE RECOVERY",
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w700,
                                      letterSpacing: 1,
                                      color: ColorConst.colorButton,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 20),

                          const Center(
                            child: Text(
                              'Reset Password',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF111827),
                              ),
                            ),
                          ),

                          const Center(
                            child: Text(
                              "Enter your email address and we'll send you a secure link to reset your password.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF9CA3AF),
                              ),
                            ),
                          ),

                          const SizedBox(height: 30),

                          TextFieldCustomer(
                            controller:
                                forgetPasswordController.emailController,
                            label: 'Email address',
                            hintText: "Enter your email address",
                            icon: HugeIcons.strokeRoundedMail01,
                          ),

                          const SizedBox(height: 20),

                          forgetPasswordController.isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: ColorConst.colorButton,
                                  ),
                                )
                              : ButtonCustomer(
                                  onTap:
                                      forgetPasswordController.forgetPassword,
                                  text: 'Send Reset Link',
                                ),

                          const SizedBox(height: 20),

                          Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  "Remember your password ? ",
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF9CA3AF),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.offAllNamed(AppRoute.login);
                                  },
                                  child: const Text(
                                    "Back to Log in",
                                    style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w700,
                                      color: ColorConst.colorButton,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
