import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/instance_manager.dart';
import 'package:get/state_manager.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:programmers_network_app/controller/auth/resend_verify_token_controller.dart';
import 'package:programmers_network_app/core/const/color_const.dart';
import 'package:programmers_network_app/view/widget/auth/card_verify_widget.dart';
import 'package:programmers_network_app/view/widget/auth/button_customer.dart';
import 'package:programmers_network_app/view/widget/auth/register_steperr_widget.dart';
import 'package:programmers_network_app/view/widget/auth/verify_icon_widget.dart';
import 'package:programmers_network_app/view/widget/logo.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({super.key});
  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  final ResendVerifyTokenController resendToken = Get.put(
    ResendVerifyTokenController(),
  );
  late final String email;

  @override
  void initState() {
    super.initState();

    email = Get.arguments ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ResendVerifyTokenController>(
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

                  Center(child: const RegisterStepper(currentStep: 1)),

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
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: VerifyHugeIconWidget(
                              icon: HugeIcons.strokeRoundedTelegram,
                              iconColor: ColorConst.colorButton,
                              backgroundColor: const Color(0xFFF3FCE5),
                              size: 80,
                              iconSize: 40,
                            ),
                          ),
                          Center(
                            child: Text(
                              'Verify your email',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF111827),
                              ),
                            ),
                          ),
                          Center(
                            child: Text(
                              'We have sent a verification link to ',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF9CA3AF),
                              ),
                            ),
                          ),
                          SizedBox(height: 15),
                          Center(
                            child: Text(
                              email,
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w700,
                                color: Color(0xFF111827),
                              ),
                            ),
                          ),
                          SizedBox(height: 8),
                          CardVerifyWidget(),
                          SizedBox(height: 20),
                          controller.isVerifying
                              ? const Center(
                                  child: CircularProgressIndicator(
                                    color: ColorConst.colorButton,
                                  ),
                                )
                              : ButtonCustomer(
                                  text: 'I have verifed my email',
                                  // onTap: () => controller.resendToken(email),
                                ),
                          const SizedBox(height: 30),

                          const Center(
                            child: Text(
                              "Didn't receive the email?",
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF9CA3AF),
                              ),
                            ),
                          ),

                          const SizedBox(height: 12),

                          Center(
                            child: GestureDetector(
                              onTap: controller.isLoading
                                  ? null
                                  : () => controller.resendToken(email),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  controller.isLoading
                                      ? const SizedBox(
                                          width: 18,
                                          height: 18,
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                            color: ColorConst.colorButton,
                                          ),
                                        )
                                      : HugeIcon(
                                          icon: HugeIcons.strokeRoundedRefresh,
                                          color: ColorConst.colorButton,
                                          size: 18,
                                        ),

                                  const SizedBox(width: 8),

                                  Text(
                                    controller.isLoading
                                        ? "Sending..."
                                        : "Resend Token",
                                    style: const TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w700,
                                      color: ColorConst.colorButton,
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
