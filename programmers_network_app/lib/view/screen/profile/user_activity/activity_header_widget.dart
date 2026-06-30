import 'package:flutter/material.dart';
import 'package:programmers_network_app/core/const/color_const.dart';

class ActivityHeader extends StatelessWidget {
  final VoidCallback? onBack;
  final VoidCallback? onCalendarTap;

  const ActivityHeader({super.key, this.onBack, this.onCalendarTap});

  Widget _roundIconButton({
    required IconData icon,
    required VoidCallback? onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: ColorConst.colorApp,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: ColorConst.colorBackGroung),
        ),
        child: Icon(icon, size: 20, color: ColorConst.textColor),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _roundIconButton(icon: Icons.arrow_back_ios_new, onTap: onBack),
          Expanded(
            child: Column(
              children: [
                const Text(
                  "User Activity",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF111827),
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  "Track and review your activity sessions.",
                  style: TextStyle(fontSize: 10, color: Color(0xFF9CA3AF)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
