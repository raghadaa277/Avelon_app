import 'package:flutter/material.dart';
import 'package:programmers_network_app/core/const/color_const.dart';

class CreatePostSteperrWidget extends StatelessWidget {
  final int currentStep;
  final int totalSteps;

  const CreatePostSteperrWidget({
    super.key,
    required this.currentStep,
    this.totalSteps = 6,
  });

  @override
  Widget build(BuildContext context) {
    final List<Widget> children = [];

    for (int i = 0; i < totalSteps; i++) {
      if (i > 0) {
        children.add(_StepLine(isActive: currentStep >= i));
      }
      children.add(_StepItem(isActive: currentStep >= i));
    }

    return Row(mainAxisAlignment: MainAxisAlignment.center, children: children);
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
