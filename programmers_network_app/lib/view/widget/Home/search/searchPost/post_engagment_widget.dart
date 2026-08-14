import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:programmers_network_app/core/const/post_color.dart';
import 'package:programmers_network_app/data/models/Home/search_post_model.dart';
import 'package:programmers_network_app/view/widget/Home/post_view_bottom_sheet_widget.dart';
import 'package:programmers_network_app/view/widget/Home/reaction_bottom_sheet_widget.dart';
import 'package:programmers_network_app/view/widget/shared/hidden_count_dialog.dart';

class _ActionItem extends StatelessWidget {
  final Widget icon;
  final Widget disabledIcon;
  final Color color;
  final int? count;
  final bool disabled;
  final bool active;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const _ActionItem({
    required this.icon,
    required this.disabledIcon,
    required this.color,
    required this.count,
    required this.disabled,
    this.active = false,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: disabled ? null : onTap,
      onLongPress: disabled ? null : onLongPress,
      borderRadius: BorderRadius.circular(6),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            disabled ? disabledIcon : icon,
            if (!disabled && count != null) ...[
              const SizedBox(width: 4),
              Text(
                _formatCount(count!),
                style: TextStyle(
                  fontSize: 13,
                  color: active ? color : Colors.grey.shade600,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  static String _formatCount(int n) {
    if (n >= 1000) return '${(n / 1000).toStringAsFixed(1)}K';
    return '$n';
  }
}

class PostEngagementBar extends StatelessWidget {
  final Post post;
  final int sharesCount;

  final VoidCallback? onLike;
  final VoidCallback? onDislike;
  final VoidCallback? onComment;
  final VoidCallback? onSave;
  final bool isOwner;

  const PostEngagementBar({
    super.key,
    required this.post,
    this.sharesCount = 0,
    this.onLike,
    this.onDislike,
    this.onComment,
    this.onSave,
    this.isOwner = false,
  });

  @override
  Widget build(BuildContext context) {
    final String? normalizedStatus = post.reactionStatus;
    final isLiked = normalizedStatus == 'like';
    final isDisliked = normalizedStatus == 'dislike';

    final bool showReactionsCount = isOwner || !post.hideReactionsCount;
    final bool showCommentsCount = isOwner || !post.hideCommentsCount;
    final bool showViewsCount = isOwner || !post.hideViewsCount;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        // Like
        _ActionItem(
          icon: HugeIcon(
            icon: HugeIcons.strokeRoundedThumbsUp,
            size: 20,
            color: isLiked ? PostColors.like : Colors.grey.shade600,
          ),
          disabledIcon: HugeIcon(
            icon: HugeIcons.strokeRoundedThumbsUp,
            size: 20,
            color: PostColors.neutralIcon,
          ),
          color: PostColors.like,
          active: isLiked,
          disabled: false,
          count: showReactionsCount ? post.likesCount : null,
          onTap: onLike,
          onLongPress: () {
            if (post.hideReactions && !isOwner) {
              showHiddenCountDialog(context, countType: 'People who liked');
              return;
            }

            showReactionsSheet(
              context,
              postId: post.id,
              targetUserId: post.user.id,
              type: 'like',
              post: post,
            );
          },
        ),

        // Dislike
        _ActionItem(
          icon: HugeIcon(
            icon: HugeIcons.strokeRoundedThumbsDown,
            size: 20,
            color: isDisliked ? PostColors.dislike : Colors.grey.shade600,
          ),
          disabledIcon: HugeIcon(
            icon: HugeIcons.strokeRoundedThumbsDown,
            size: 20,
            color: PostColors.neutralIcon,
          ),
          color: PostColors.dislike,
          active: isDisliked,
          disabled: false,
          count: showReactionsCount ? post.disLikesCount : null,
          onTap: onDislike,
          onLongPress: () {
            if (post.hideReactions && !isOwner) {
              showHiddenCountDialog(context, countType: 'People who disliked');
              return;
            }

            showReactionsSheet(
              context,
              postId: post.id,
              targetUserId: post.user.id,
              type: 'dislike',
              post: post,
            );
          },
        ),

        // Comments
        _ActionItem(
          icon: HugeIcon(
            icon: HugeIcons.strokeRoundedComment01,
            size: 20,
            color: const Color(0xFF14B8A6),
          ),
          disabledIcon: HugeIcon(
            icon: HugeIcons.strokeRoundedComment01,
            size: 20,
            color: PostColors.neutralIcon,
          ),
          color: const Color(0xFF14B8A6),
          disabled: !post.allowComments,
          count: !post.allowComments || !showCommentsCount
              ? null
              : post.commentsCount,
          onTap: onComment,
        ),

        // Views
        _ActionItem(
          icon: HugeIcon(
            icon: HugeIcons.strokeRoundedView,
            size: 20,
            color: PostColors.views,
          ),
          disabledIcon: HugeIcon(
            icon: HugeIcons.strokeRoundedView,
            size: 20,
            color: PostColors.neutralIcon,
          ),
          color: PostColors.views,
          disabled: false,
          count: showViewsCount ? post.viewsCount : null,
          onTap: null,
          onLongPress: () {
            if (post.hideViews && !isOwner) {
              showHiddenCountDialog(context, countType: 'Viewers');
              return;
            }
            showViewsSheet(
              context,
              postId: post.id,
              targetUserId: post.user.id,
              post: post,
            );
          },
        ),

        // Save
        InkWell(
          onTap: onSave,
          borderRadius: BorderRadius.circular(6),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            child: HugeIcon(
              icon: post.isSaved
                  ? HugeIcons.strokeRoundedBookmark02
                  : HugeIcons.strokeRoundedBookmark01,
              size: 20,
              color: post.isSaved ? PostColors.save : Colors.grey.shade600,
            ),
          ),
        ),
      ],
    );
  }
}
