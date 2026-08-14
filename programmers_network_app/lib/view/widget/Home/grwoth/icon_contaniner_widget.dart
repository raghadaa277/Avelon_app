import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class IconContainer extends StatefulWidget {
  final dynamic icon;
  final Color color;

  const IconContainer({super.key, required this.icon, required this.color});

  @override
  State<IconContainer> createState() => IconContainerState();
}

class IconContainerState extends State<IconContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: widget.color.withOpacity(0.10),
        shape: BoxShape.circle,
      ),
      alignment: Alignment.center,
      child: HugeIcon(icon: widget.icon, size: 18, color: widget.color),
    );
  }
}
