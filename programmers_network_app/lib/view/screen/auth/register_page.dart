import 'package:flutter/material.dart' hide TextField;
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:programmers_network_app/controller/auth/register_controller.dart';
import 'package:programmers_network_app/core/const/color_const.dart';
import 'package:programmers_network_app/core/const/routesPage.dart';
import 'package:programmers_network_app/view/widget/auth/button_customer.dart';
import 'package:programmers_network_app/view/widget/auth/password_card_widget.dart';
import 'package:programmers_network_app/view/widget/auth/text_field_customer.dart';
import 'package:programmers_network_app/view/widget/auth/register_steperr_widget.dart';
import 'package:programmers_network_app/view/widget/logo.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final RegisterController controller = Get.put(RegisterController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<RegisterController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: ColorConst.colorBackGroung,
          body: SafeArea(
            child: SingleChildScrollView(
              // padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: Column(
                children: [
                  BuildLogo(),

                  const SizedBox(height: 32),

                  Center(child: const RegisterStepper(currentStep: 0)),

                  const SizedBox(height: 28),

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
                          Center(
                            child: const Text(
                              "Create your Avelon ID",
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF111827),
                              ),
                            ),
                          ),

                          const SizedBox(height: 6),

                          Center(
                            child: const Text(
                              "Join the next generation of developers.",
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF9CA3AF),
                              ),
                            ),
                          ),

                          const SizedBox(height: 24),

                          TextFieldCustomer(
                            label: "Full Name",
                            hintText: 'Enter your full name',
                            controller: controller.fullName,
                            icon: HugeIcons.strokeRoundedUser,
                          ),

                          const SizedBox(height: 14),

                          TextFieldCustomer(
                            label: "Email Address",
                            hintText: 'Enter your Email',
                            controller: controller.email,
                            icon: HugeIcons.strokeRoundedMail01,
                          ),

                          const SizedBox(height: 14),

                          TextFieldCustomer(
                            label: "Password",
                            hintText: 'Enter your password',
                            controller: controller.password,
                            icon: HugeIcons.strokeRoundedLockPassword,
                            obscureText: controller.obscurePassword,
                            onSuffixTap: () {
                              controller.obscurePassword =
                                  !controller.obscurePassword;
                              controller.update();
                            },
                            onChanged: controller.onPasswordChanged,
                          ),

                          const SizedBox(height: 14),

                          TextFieldCustomer(
                            label: "Confirm Password",
                            hintText: 'Re-enter your password',
                            controller: controller.passwordConfirmation,
                            icon: HugeIcons.strokeRoundedLockPassword,
                            obscureText: controller.obscureConfirmPassword,
                            onSuffixTap: () {
                              controller.obscureConfirmPassword =
                                  !controller.obscureConfirmPassword;
                              controller.update();
                            },
                          ),
                          const SizedBox(height: 16),

                          PasswordStrengthCard(
                            hasMinLength: controller.hasMinLength,
                            hasUpperAndLower: controller.hasUpperAndLower,
                            hasNumber: controller.hasNumber,
                            hasSpecialChar: controller.hasSpecialChar,
                          ),

                          const SizedBox(height: 24),

                          controller.isLoading
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: ColorConst.colorButton,
                                  ),
                                )
                              : ButtonCustomer(
                                  text: 'Create account',
                                  onTap: controller.register,
                                ),

                          const SizedBox(height: 20),

                          Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Text(
                                  "Already have an account?  ",
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Color(0xFF9CA3AF),
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Get.offAllNamed(AppRoute.login);
                                  },
                                  child: const Text(
                                    "Log in",
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

                  _buildSecurityNote(),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildSecurityNote() {
    return Card(
      margin: EdgeInsets.only(left: 50, right: 50),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 46,
              height: 46,
              decoration: BoxDecoration(
                color: ColorConst.colorButton.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Icon(
                  Icons.security_rounded,
                  color: ColorConst.colorButton,
                  size: 22,
                ),
              ),
            ),

            const SizedBox(width: 14),

            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Your data is safe with Avelon",
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF111827),
                    ),
                  ),
                  SizedBox(height: 3),
                  Text(
                    "We use industry-standard encryption\n to protect your information.",
                    style: TextStyle(
                      fontSize: 12,
                      color: Color(0xFF9CA3AF),
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
