import 'package:flutter/material.dart';
import 'package:programmers_network_app/core/const/color_const.dart';

class BuildLogo extends StatelessWidget {
  const BuildLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          'A',
          style: TextStyle(
            color: ColorConst.colorButton,
            fontSize: 100,
            fontWeight: FontWeight.w900,
            fontStyle: FontStyle.italic,
            fontFamily: 'sans-serif',
            height: 1.0,
          ),
        ),

        const SizedBox(width: 15),

        const Text(
          "A V E L O N ",
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
