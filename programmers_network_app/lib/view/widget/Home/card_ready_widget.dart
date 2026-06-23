import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:programmers_network_app/core/const/color_const.dart';
import 'package:programmers_network_app/core/const/font.dart';
import 'package:programmers_network_app/view/widget/auth/verify_icon_widget.dart';

class CardReadyWidget extends StatelessWidget {
  const CardReadyWidget({super.key});
  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                VerifyHugeIconWidget(
                  icon: HugeIcons.strokeRoundedCheckmarkCircle02,
                  iconColor: ColorConst.colorButton,
                  backgroundColor: const Color(0xFFF3FCE5),
                  size: 40,
                  iconSize: 20,
                ),
                const SizedBox(width: 10),
                Text(
                  "Interests Selected",
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: Font.font2,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF111827),
                  ),
                ),
                const Spacer(),
                HugeIcon(
                  icon: HugeIcons.strokeRoundedScanHeart,
                  color: const Color(0xFF9CA3AF),
                ),
              ],
            ),

            const Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),

            Row(
              children: [
                VerifyHugeIconWidget(
                  icon: HugeIcons.strokeRoundedCheckmarkCircle02,
                  iconColor: ColorConst.colorButton,
                  backgroundColor: const Color(0xFFF3FCE5),
                  size: 40,
                  iconSize: 20,
                ),
                const SizedBox(width: 10),
                Text(
                  "Community Access Enabled",
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: Font.font2,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF111827),
                  ),
                ),
                const Spacer(),
                HugeIcon(
                  icon: HugeIcons.strokeRoundedUserGroup,
                  color: const Color(0xFF9CA3AF),
                ),
              ],
            ),

            const Divider(height: 1, thickness: 1, color: Color(0xFFE5E7EB)),

            Row(
              children: [
                VerifyHugeIconWidget(
                  icon: HugeIcons.strokeRoundedCheckmarkCircle02,
                  iconColor: ColorConst.colorButton,
                  backgroundColor: const Color(0xFFF3FCE5),
                  size: 40,
                  iconSize: 20,
                ),
                const SizedBox(width: 10),
                Text(
                  "Personalized Feed Activated",
                  style: TextStyle(
                    fontSize: 15,
                    fontFamily: Font.font2,
                    fontWeight: FontWeight.w800,
                    color: const Color(0xFF111827),
                  ),
                ),
                const Spacer(),
                HugeIcon(
                  icon: HugeIcons.strokeRoundedFlash,
                  color: const Color(0xFF9CA3AF),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
