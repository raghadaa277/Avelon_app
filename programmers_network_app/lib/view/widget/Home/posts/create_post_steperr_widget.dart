import 'package:flutter/material.dart';
import 'package:programmers_network_app/core/const/color_const.dart';

class CreatePostSteperrWidget extends StatelessWidget {
  final int currentStep;
  const CreatePostSteperrWidget({super.key, required this.currentStep});
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _StepItem(isActive: currentStep >= 0),

        _StepLine(isActive: currentStep >= 1),
        _StepItem(isActive: currentStep >= 1),

        _StepLine(isActive: currentStep >= 2),
        _StepItem(isActive: currentStep >= 2),

        _StepLine(isActive: currentStep >= 3),
        _StepItem(isActive: currentStep >= 3),

        _StepLine(isActive: currentStep >= 4),
        _StepItem(isActive: currentStep >= 4),

        _StepLine(isActive: currentStep >= 5),
        _StepItem(isActive: currentStep >= 5),
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
      padding: const EdgeInsets.only(bottom: 2),
      child: SizedBox(
        width: 20,
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
  final bool isActive;
  const _StepItem({required this.isActive});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 30,
          height: 30,
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
        ),
      ],
    );
  }
}
