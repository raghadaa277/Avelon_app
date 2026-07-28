import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:programmers_network_app/data/models/Home/search_post_model.dart';

class PostViewedBadge extends StatelessWidget {
  final Post post;

  const PostViewedBadge({super.key, required this.post});

  @override
  Widget build(BuildContext context) {
    int myViewCount = 0;

    if (post.viewers.isNotEmpty) {
      myViewCount = post.viewers.first.pivot.viewCount;
    }

    final bool isViewed = myViewCount > 0;

    final String label = isViewed
        ? myViewCount == 1
              ? "Viewed"
              : "Viewed x$myViewCount"
        : "Not viewed yet";

    final Color color = isViewed ? Colors.green : Colors.grey;

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        HugeIcon(
          icon: isViewed
              ? HugeIcons.strokeRoundedView
              : HugeIcons.strokeRoundedViewOffSlash,
          size: 16,
          color: color,
        ),
        const SizedBox(width: 4),
        Text(
          label,
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: color,
          ),
        ),
      ],
    );
  }
}
