import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class SearchStatusBadgeWidget extends StatelessWidget {
  final String followStatus;

  const SearchStatusBadgeWidget({super.key, required this.followStatus});

  @override
  Widget build(BuildContext context) {
    late String label;
    late dynamic icon;
    late Color bgColor;
    late Color textColor;

    switch (followStatus) {
      case 'mutual':
        label = "Mutual";
        icon = HugeIcons.strokeRoundedUserGroup;
        bgColor = const Color(0xffEAF7D6);
        textColor = const Color(0xff5C8A00);
        break;
      case 'following':
        label = "Following";
        icon = HugeIcons.strokeRoundedUserCheck01;
        bgColor = const Color(0xffEAF7D6);
        textColor = const Color(0xff5C8A00);
        break;
      default:
        label = "None";
        icon = HugeIcons.strokeRoundedUserAdd01;
        bgColor = const Color(0xffF0F1EC);
        textColor = Colors.grey.shade600;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          HugeIcon(icon: icon, color: textColor, size: 16),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w600,
              fontSize: 12.5,
            ),
          ),
        ],
      ),
    );
  }
}
