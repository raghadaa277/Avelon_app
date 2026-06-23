import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:programmers_network_app/controller/auth/login_controller.dart';
import 'package:programmers_network_app/core/const/color_const.dart';
import 'package:programmers_network_app/core/const/routesPage.dart';
import 'package:programmers_network_app/view/widget/auth/button_customer.dart';
import 'package:programmers_network_app/view/widget/auth/text_field_customer.dart';

import 'package:programmers_network_app/view/widget/logo.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final LoginController controller = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<LoginController>(
      builder: (controller) {
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
                      key: controller.formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Center(
                            child: Text(
                              "Welcome To Avelon",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF111827),
                              ),
                            ),
                          ),

                          const SizedBox(height: 6),

                          const Center(
                            child: Text(
                              "Sign in to continue to Avelon.",
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF9CA3AF),
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          TextFieldCustomer(
                            label: "Email Address",
                            controller: controller.email,
                            icon: HugeIcons.strokeRoundedMail01,
                          ),

                          const SizedBox(height: 14),

                          TextFieldCustomer(
                            label: "Password",
                            controller: controller.password,
                            icon: HugeIcons.strokeRoundedLockPassword,
                            obscureText: controller.obscurePassword,
                            onSuffixTap: () {
                              controller.obscurePassword =
                                  !controller.obscurePassword;
                              controller.update();
                            },
                          ),

                          const SizedBox(height: 4),

                          Align(
                            alignment: Alignment.centerRight,
                            child: TextButton(
                              onPressed: () {
                                Get.offAllNamed(AppRoute.resetpassword);
                              },
                              child: const Text(
                                'Forgot password?',
                                style: TextStyle(
                                  color: ColorConst.colorButton,
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ),

                          const SizedBox(height: 8),

                          controller.isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: ColorConst.colorButton,
                                  ),
                                )
                              : ButtonCustomer(
                                  onTap: controller.login,
                                  text: 'Sign in',
                                ),

                          const SizedBox(height: 20),

                          Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  "Don't have an account?  ",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF9CA3AF),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.offAllNamed(AppRoute.register);
                                  },
                                  child: const Text(
                                    "Create account",
                                    style: TextStyle(
                                      fontSize: 14,
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

                  const SizedBox(height: 28),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
