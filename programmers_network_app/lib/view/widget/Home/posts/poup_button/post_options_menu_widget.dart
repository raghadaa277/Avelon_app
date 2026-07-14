import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:programmers_network_app/core/const/color_const.dart';

class PostOptionsMenu extends StatelessWidget {
  final bool isPinned;
  final ValueChanged<String> onSelected;

  const PostOptionsMenu({
    super.key,
    this.isPinned = false,
    required this.onSelected,
  });

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
          value: 'pin',
          icon: HugeIcons.strokeRoundedPin,
          label: isPinned ? 'Unpin Post' : 'Pin Post',
        ),
        _buildItem(
          value: 'edit',
          icon: HugeIcons.strokeRoundedEdit02,
          label: 'Edit',
        ),
        _buildItem(
          value: 'archive',
          icon: HugeIcons.strokeRoundedArchive02,
          label: 'Archive',
        ),
        _buildItem(
          value: 'save',
          icon: HugeIcons.strokeRoundedBookmark02,
          label: 'Save',
        ),
        _buildItem(
          value: "statistics",
          icon: HugeIcons.strokeRoundedChartHistogram,
          label: "Statistics",
        ),
        _buildItem(
          value: 'delete',
          icon: HugeIcons.strokeRoundedDelete02,
          label: 'Delete',
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
