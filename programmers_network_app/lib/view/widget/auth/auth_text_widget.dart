import 'package:flutter/material.dart';
import 'package:programmers_network_app/core/const/color_const.dart';

class AuthTextAction extends StatelessWidget {
  final String normalText;
  final String actionText;
  final VoidCallback onTap;
  final TextAlign align;

  const AuthTextAction({
    super.key,
    required this.normalText,
    required this.actionText,
    required this.onTap,
    this.align = TextAlign.center,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(normalText, style: const TextStyle(color: Colors.grey)),
        InkWell(
          onTap: onTap,
          child: Text(
            actionText,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: ColorConst.colorButton,
            ),
          ),
        ),
      ],
    );
  }
}
