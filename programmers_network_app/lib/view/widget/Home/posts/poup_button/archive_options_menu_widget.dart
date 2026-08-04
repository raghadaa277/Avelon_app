import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:programmers_network_app/core/const/color_const.dart';

class ArchiveOptionsMenuWidget extends StatelessWidget {
  const ArchiveOptionsMenuWidget({super.key, required this.onSelected});

  final ValueChanged<String> onSelected;
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: HugeIcon(icon: HugeIcons.strokeRoundedMoreHorizontal),

      color: ColorConst.colorBackGroung,

      elevation: 6,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

      offset: const Offset(0, 40),

      onSelected: onSelected,

      itemBuilder: (context) => [
        _buildItem(
          value: "restore",
          icon: HugeIcons.strokeRoundedArchiveRestore,
          label: "Restore",
        ),
        _buildItem(
          value: "delete",
          icon: HugeIcons.strokeRoundedDelete02,
          label: "Delete",
          color: Colors.red,
        ),
      ],
    );
  }

  PopupMenuItem<String> _buildItem({
    required String value,
    required dynamic icon,
    required String label,
    Color color = Colors.black87,
  }) {
    return PopupMenuItem<String>(
      value: value,
      height: 44,
      child: Row(
        children: [
          HugeIcon(icon: icon, size: 20, color: color),
          const SizedBox(width: 12),
          Text(
            label,
            style: TextStyle(
              color: color,
              fontSize: 15,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
