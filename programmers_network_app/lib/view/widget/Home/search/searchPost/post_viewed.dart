import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:programmers_network_app/controller/Home/posts/edit_post_controller.dart';
import 'package:programmers_network_app/data/models/Home/search_post_model.dart';
import 'package:visibility_detector/visibility_detector.dart';

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

class PostViewTrackerWrapper extends StatelessWidget {
  final Post post;
  final Widget child;
  final String source;

  const PostViewTrackerWrapper({
    super.key,
    required this.post,
    required this.child,
    required this.source,
  });

  @override
  Widget build(BuildContext context) {
    final EditPostController tracker = Get.find<EditPostController>();

    return VisibilityDetector(
      key: ValueKey('post-view-${post.id}'),
      onVisibilityChanged: (VisibilityInfo info) {
        if (info.visibleFraction >= 0.6) {
          tracker.registerView(
            targetUserId: post.user.id,
            postId: post.id,
            source: source,
          );
        }
      },
      child: child,
    );
  }
}
