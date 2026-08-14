import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:programmers_network_app/core/const/color_const.dart';

class PostOptionsMenu extends StatelessWidget {
  final bool isPinned;
  final bool isSaved;
  final ValueChanged<String> onSelected;

  const PostOptionsMenu({
    super.key,
    this.isPinned = false,
    this.isSaved = false,
    required this.onSelected,
  });

  static const Color primaryColor = Color(0xffB8FF1A);

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const HugeIcon(
        icon: HugeIcons.strokeRoundedMoreHorizontal,
        size: 22,
        color: Colors.black87,
      ),

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
          label: isSaved ? 'Unsave' : 'Save',
          color: isSaved ? primaryColor : Colors.black87,
        ),
        _buildItem(
          value: 'post overview',
          icon: HugeIcons.strokeRoundedAnalytics01,
          label: 'Post Insights',
        ),

        _buildItem(
          value: 'audience',
          icon: HugeIcons.strokeRoundedUserGroup,
          label: 'Audience Insights',
        ),

        _buildItem(
          value: 'post views overview',
          icon: HugeIcons.strokeRoundedArrowUp01,
          label: 'Post Views Overview',
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

          Expanded(
            child: Text(
              label,
              style: TextStyle(
                color: color,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),

          if (value == 'save' && isSaved)
            const HugeIcon(
              icon: HugeIcons.strokeRoundedCheckmarkCircle02,
              size: 16,
              color: primaryColor,
            ),
        ],
      ),
    );
  }
}
