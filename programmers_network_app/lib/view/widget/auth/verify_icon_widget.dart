import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class VerifyHugeIconWidget extends StatelessWidget {
  final dynamic icon;

  final Color iconColor;
  final Color backgroundColor;
  final double size;
  final double iconSize;

  const VerifyHugeIconWidget({
    super.key,
    required this.icon,
    this.iconColor = const Color(0xFFB7F51A),
    this.backgroundColor = const Color(0xFFF3FCE5),
    this.size = 40,
    this.iconSize = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: backgroundColor, shape: BoxShape.circle),
      child: Center(
        child: HugeIcon(icon: icon, color: iconColor, size: iconSize),
      ),
    );
  }
}
