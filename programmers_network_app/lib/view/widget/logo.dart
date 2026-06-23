import 'package:flutter/material.dart';
import 'package:programmers_network_app/core/const/image_const.dart';

class BuildLogo extends StatelessWidget {
  const BuildLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Image.asset(
          ImageAsset.logo,
          height: 180,
          width: 250,
          fit: BoxFit.contain,
        ),

        const SizedBox(height: 8),

        const Text(
          "avelon",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.w800,
            color: Color(0xFF111827),
          ),
        ),

        const SizedBox(height: 4),

        const Text(
          "Built for developers, by developers.",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 13, color: Color(0xFF9CA3AF)),
        ),
      ],
    );
  }
}
