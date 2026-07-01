import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:programmers_network_app/core/const/color_const.dart';
import 'package:programmers_network_app/core/const/routesPage.dart';
import 'package:programmers_network_app/view/widget/auth/button_customer.dart';
import 'package:programmers_network_app/view/widget/auth/register_steperr_widget.dart';
import 'package:programmers_network_app/view/widget/auth/verify_icon_widget.dart';
import 'package:programmers_network_app/view/widget/logo.dart';

class CompletePage extends StatefulWidget {
  const CompletePage({super.key});

  @override
  State<CompletePage> createState() => _CompletePageState();
}

class _CompletePageState extends State<CompletePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.colorBackGroung,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
          child: Column(
            children: [
              BuildLogo(),

              const SizedBox(height: 32),

              const RegisterStepper(currentStep: 2),

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
                child: Column(
                  children: [
                    VerifyHugeIconWidget(
                      icon: HugeIcons.strokeRoundedCheckmarkCircle02,
                      iconColor: ColorConst.colorButton,
                      backgroundColor: const Color(0xFFF3FCE5),
                      size: 90,
                      iconSize: 45,
                    ),

                    const SizedBox(height: 28),

                    const Text(
                      'Email verified!',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF111827),
                      ),
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      'Your account is now active.\nYou can start exploring Avelon.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 15,
                        height: 1.6,
                        color: Color(0xFF9CA3AF),
                      ),
                    ),

                    const SizedBox(height: 32),

                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(18),
                      decoration: BoxDecoration(
                        color: ColorConst.colorBackGroung,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          VerifyHugeIconWidget(
                            icon: HugeIcons.strokeRoundedParty,
                            iconColor: ColorConst.colorButton,
                            backgroundColor: const Color(0xFFF3FCE5),
                            size: 48,
                            iconSize: 24,
                          ),

                          const SizedBox(width: 14),

                          const Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Text(
                                      'Welcome to Avelon!',
                                      style: TextStyle(
                                        fontSize: 15,
                                        fontWeight: FontWeight.w700,
                                        color: Color(0xFF111827),
                                      ),
                                    ),

                                    SizedBox(width: 6),

                                    Icon(
                                      Icons.celebration,
                                      size: 20,
                                      color: Colors.orange,
                                    ),
                                  ],
                                ),

                                SizedBox(height: 6),

                                Text(
                                  'You are all set to explore , bulid , and connect\n with fellow developers.',
                                  style: TextStyle(
                                    fontSize: 13,
                                    color: Color(0xFF9CA3AF),
                                    height: 1.5,
                                  ),
                                ),
                                Text(
                                  "Let's build something amazing !",
                                  style: TextStyle(
                                    fontSize: 13,
                                    fontWeight: FontWeight.w700,
                                    color: Color(0xFF111827),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 36),

                    ButtonCustomer(
                      text: 'Continue to login',
                      onTap: () {
                        Get.offAllNamed(AppRoute.login);
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
