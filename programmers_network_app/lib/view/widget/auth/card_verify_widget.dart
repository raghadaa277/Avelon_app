import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:programmers_network_app/core/const/color_const.dart';
import 'package:programmers_network_app/view/widget/auth/verify_icon_widget.dart';

class CardVerifyWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: ColorConst.colorBackGroung,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          children: [
            Row(
              children: [
                VerifyHugeIconWidget(
                  icon: HugeIcons.strokeRoundedMail01,
                  iconColor: ColorConst.colorButton,
                  backgroundColor: const Color(0xFFF3FCE5),
                  size: 40,
                  iconSize: 20,
                ),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Check your in box',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF111827),
                      ),
                    ),
                    Text(
                      'Lock for an email\n from Avelon .',
                      style: TextStyle(fontSize: 14, color: Color(0xFF9CA3AF)),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: [
                VerifyHugeIconWidget(
                  icon: HugeIcons.strokeRoundedLink01,
                  iconColor: ColorConst.colorButton,
                  backgroundColor: const Color(0xFFF3FCE5),
                  size: 40,
                  iconSize: 20,
                ),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Click the verification link',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF111827),
                      ),
                    ),
                    Text(
                      'It will confirm your\n email address .',
                      style: TextStyle(fontSize: 14, color: Color(0xFF9CA3AF)),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 15),
            Row(
              children: [
                VerifyHugeIconWidget(
                  icon: HugeIcons.strokeRoundedSecurityValidation,
                  iconColor: ColorConst.colorButton,
                  backgroundColor: const Color(0xFFF3FCE5),
                  size: 40,
                  iconSize: 20,
                ),
                SizedBox(width: 8),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'You are all set !',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF111827),
                      ),
                    ),
                    Text(
                      'Once verifed , you can\n start building .',
                      style: TextStyle(fontSize: 14, color: Color(0xFF9CA3AF)),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 15),
            Card(
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 10,
                ),
                child: Row(
                  children: [
                    VerifyHugeIconWidget(
                      icon: HugeIcons.strokeRoundedInformationCircle,
                      iconColor: ColorConst.colorButton,
                      backgroundColor: const Color(0xFFF3FCE5),
                      size: 40,
                      iconSize: 20,
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: RichText(
                        text: TextSpan(
                          style: const TextStyle(
                            fontSize: 13,
                            color: Colors.black87,
                          ),
                          children: [
                            const TextSpan(text: 'The link will expire in '),
                            TextSpan(
                              text: '15 minutes',
                              style: TextStyle(
                                color: ColorConst.colorApp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const TextSpan(text: ' for your security.'),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
