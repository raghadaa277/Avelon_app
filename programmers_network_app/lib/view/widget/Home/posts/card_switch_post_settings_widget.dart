import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:programmers_network_app/core/const/color_const.dart';

class CardSwitchPostSettingsWidget extends StatelessWidget {
  final List<List> icon;
  final String text;
  final bool value;
  final ValueChanged<bool> onChanged;

  const CardSwitchPostSettingsWidget({
    super.key,
    required this.icon,
    required this.text,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            HugeIcon(icon: icon, color: Colors.black, size: 22),

            const SizedBox(width: 12),

            Expanded(
              child: Text(
                text,
                style: const TextStyle(
                  color: Color(0xFF111827),
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            Switch(
              value: value,
              activeThumbColor: Colors.white,
              activeTrackColor: ColorConst.colorButton,

              inactiveThumbColor: Colors.white,
              inactiveTrackColor: Colors.grey.shade300,

              onChanged: onChanged,
            ),
          ],
        ),
      ),
    );
  }
}
