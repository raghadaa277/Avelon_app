import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:programmers_network_app/core/const/color_const.dart';

class GrowthIllustration extends StatefulWidget {
  const GrowthIllustration({super.key});

  @override
  State<GrowthIllustration> createState() => _GrowthIllustrationState();
}

class _GrowthIllustrationState extends State<GrowthIllustration> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 170,
      height: 125,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            bottom: 4,
            left: 15,
            right: 5,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                _bar(35),
                const SizedBox(width: 7),
                _bar(52),
                const SizedBox(width: 7),
                _bar(70),
                const SizedBox(width: 7),
                _bar(88),
              ],
            ),
          ),

          Positioned(
            top: 8,
            right: 8,
            child: Transform.rotate(
              angle: -0.55,
              child: const HugeIcon(
                icon: HugeIcons.strokeRoundedRocket01,
                size: 45,
                color: ColorConst.colorButton,
              ),
            ),
          ),

          Positioned(
            right: 40,
            top: 35,
            child: Container(
              width: 90,
              height: 4,
              decoration: BoxDecoration(
                color: ColorConst.colorApp,
                borderRadius: BorderRadius.circular(10),
              ),
              transform: Matrix4.rotationZ(-0.5),
            ),
          ),

          const Positioned(
            left: 45,
            top: 35,
            child: Text(
              '✦',
              style: TextStyle(fontSize: 16, color: ColorConst.colorApp),
            ),
          ),
        ],
      ),
    );
  }

  Widget _bar(double height) {
    return Container(
      width: 22,
      height: height,
      decoration: BoxDecoration(
        color: ColorConst.lightGreenBg,
        borderRadius: BorderRadius.circular(6),
      ),
    );
  }
}
