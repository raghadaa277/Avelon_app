import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:programmers_network_app/core/const/color_const.dart';

class RegisterStepper extends StatelessWidget {
  final int currentStep;

  const RegisterStepper({super.key, required this.currentStep});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _StepItem(
          icon: HugeIcons.strokeRoundedUserCircle,
          title: "Account",
          isActive: currentStep >= 0,
        ),

        _StepLine(isActive: currentStep >= 1),

        _StepItem(
          icon: HugeIcons.strokeRoundedMail01,
          title: "Verify",
          isActive: currentStep >= 1,
        ),

        _StepLine(isActive: currentStep >= 2),

        _StepItem(
          icon: HugeIcons.strokeRoundedTick02,
          title: "Complete",
          isActive: currentStep >= 2,
        ),
      ],
    );
  }
}

class _StepLine extends StatelessWidget {
  final bool isActive;

  const _StepLine({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 28),
      child: SizedBox(
        width: 48,
        height: 2,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: isActive ? ColorConst.colorButton : const Color(0xFFE5E7EB),
            borderRadius: BorderRadius.circular(100),
          ),
        ),
      ),
    );
  }
}

class _StepItem extends StatelessWidget {
  final dynamic icon;
  final String title;
  final bool isActive;

  const _StepItem({
    required this.icon,
    required this.title,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isActive ? ColorConst.colorButton : Colors.white,
            border: isActive
                ? null
                : Border.all(color: const Color(0xFFE5E7EB), width: 1.5),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: ColorConst.colorButton.withValues(alpha: 0.4),
                      blurRadius: 18,
                      offset: const Offset(0, 6),
                    ),
                  ]
                : [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.05),
                      blurRadius: 8,
                      offset: const Offset(0, 3),
                    ),
                  ],
          ),
          child: Center(
            child: HugeIcon(
              icon: icon,
              size: 22,
              color: isActive ? Colors.black87 : const Color(0xFFB0B7C3),
            ),
          ),
        ),

        const SizedBox(height: 10),

        Text(
          title,
          style: TextStyle(
            fontSize: 13,
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
            color: isActive ? const Color(0xFF111827) : const Color(0xFF9CA3AF),
          ),
        ),
      ],
    );
  }
}
