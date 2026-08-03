import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:programmers_network_app/core/const/color_const.dart';
import 'package:programmers_network_app/core/const/post_color.dart';
import 'package:programmers_network_app/view/widget/Home/shwo_comment_reaction_sheet_widget.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:programmers_network_app/data/models/Home/posts/comments/get_post_comments_model.dart';

class CommentCard extends StatefulWidget {
  final DataPostComments comment;
  final List<DataPostComments> replies;
  final bool isLoadingReplies;
  final bool isExpanded;
  final int targetUserId;
  final int postId;

  final void Function(DataPostComments comment, int rootCommentId) onReply;
  final void Function(DataPostComments comment) onLike;
  final void Function(DataPostComments comment) onDislike;

  final void Function(DataPostComments comment)? onEdit;
  final void Function(DataPostComments comment)? onDelete;

  final void Function(DataPostComments comment) onToggleExpand;

  final bool hasMoreReplies;
  final bool isLoadingMoreReplies;

  final void Function(DataPostComments comment)? onLoadMoreReplies;
  final void Function(DataPostComments comment)? onUserTap;

  final int depth;

  final int? rootCommentId;

  final List<DataPostComments> Function(int) getReplies;
  final bool Function(int) getExpanded;
  final bool Function(int) getLoading;
  final bool Function(int) getHasMore;
  final bool Function(int) getLoadingMore;

  const CommentCard({
    super.key,

    required this.comment,

    required this.targetUserId,
    required this.postId,
    this.replies = const [],
    this.isLoadingReplies = false,
    this.isExpanded = false,

    required this.onReply,
    required this.onLike,
    required this.onDislike,

    this.onEdit,
    this.onDelete,

    required this.onToggleExpand,

    this.hasMoreReplies = false,
    this.isLoadingMoreReplies = false,
    this.onLoadMoreReplies,

    this.depth = 0,
    this.rootCommentId,

    required this.getReplies,
    required this.getExpanded,
    required this.getLoading,
    required this.getHasMore,
    required this.getLoadingMore,

    this.onUserTap,
  });

  @override
  State<CommentCard> createState() => _CommentCardState();
}

class _CommentCardState extends State<CommentCard> {
  @override
  Widget build(BuildContext context) {
    final user = widget.comment.userPostComment;

    final avatar = user.userProfileComments.avatarFullUrl ?? '';
    final fullName = user.fullName.trim().isEmpty
        ? 'Unknown User'
        : user.fullName;

    final isLiked = widget.comment.reactionStatus == 'like';
    final isDisliked = widget.comment.reactionStatus == 'dislike';

    if (widget.comment.isHidden && !widget.comment.isMyComment) {
      return const SizedBox.shrink();
    }

    return Padding(
      padding: EdgeInsets.only(left: widget.depth > 0 ? 36.0 : 0, bottom: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          border: widget.comment.isPinned
              ? Border.all(color: const Color(0xFFB8860B), width: 1)
              : null,
          boxShadow: [
            BoxShadow(
              color: Colors.black,
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (widget.comment.isPinned)
              Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  children: [
                    HugeIcon(
                      icon: HugeIcons.strokeRoundedPin,
                      size: 15,
                      color: ColorConst.colorApp,
                    ),
                    const SizedBox(width: 4),
                  ],
                ),
              ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () => widget.onUserTap?.call(widget.comment),
                  child: CircleAvatar(
                    radius: 18,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: avatar.isNotEmpty
                        ? NetworkImage(avatar)
                        : null,
                    child: avatar.isEmpty
                        ? Text(
                            fullName[0].toUpperCase(),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 13,
                            ),
                          )
                        : null,
                  ),
                ),

                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () =>
                                  widget.onUserTap?.call(widget.comment),
                              child: Text(
                                fullName,
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 13.5,
                                ),
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),

                          if (widget.comment.isBest)
                            Container(
                              margin: const EdgeInsets.only(left: 4),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFF4CC),
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  HugeIcon(
                                    icon: HugeIcons.strokeRoundedStar,
                                    size: 10,
                                    color: const Color(0xFFB8860B),
                                  ),
                                  const SizedBox(width: 2),
                                  const Text(
                                    'Best',
                                    style: TextStyle(
                                      fontSize: 9,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFFB8860B),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          if (widget.comment.isHidden)
                            Container(
                              margin: const EdgeInsets.only(left: 4),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 6,
                                vertical: 2,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.grey.shade200,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              child: Text(
                                'Hidden',
                                style: TextStyle(
                                  fontSize: 9,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                          IconButton(
                            padding: EdgeInsets.zero,
                            constraints: const BoxConstraints(),
                            visualDensity: VisualDensity.compact,
                            icon: HugeIcon(
                              icon: HugeIcons.strokeRoundedMoreHorizontal,
                              size: 16,
                              color: Colors.grey.shade500,
                            ),
                            onPressed: () => _showOptionsMenu(context),
                          ),
                        ],
                      ),
                      const SizedBox(height: 3),
                      Text(
                        widget.comment.content,
                        style: const TextStyle(fontSize: 13.5, height: 1.35),
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(height: 8),

            Padding(
              padding: const EdgeInsets.only(left: 46),
              child: Wrap(
                spacing: 14,
                runSpacing: 6,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    widget.comment.createdAt != null
                        ? timeago.format(widget.comment.createdAt!)
                        : '',
                    style: TextStyle(
                      fontSize: 11.5,
                      color: Colors.grey.shade500,
                    ),
                  ),

                  GestureDetector(
                    onTap: () => widget.onLike(widget.comment),
                    onLongPress: () {
                      showCommentReactionsSheet(
                        context,
                        targetUserId: widget.targetUserId,
                        postId: widget.postId,
                        commentId: widget.comment.id,
                        type: 'like',
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        HugeIcon(
                          icon: HugeIcons.strokeRoundedThumbsUp,
                          size: 15,
                          color: isLiked
                              ? PostColors.like
                              : Colors.grey.shade500,
                        ),
                        if (widget.comment.likesCount > 0) ...[
                          const SizedBox(width: 3),
                          Text(
                            '${widget.comment.likesCount}',
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                              color: isLiked
                                  ? PostColors.like
                                  : Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  GestureDetector(
                    onTap: () => widget.onDislike(widget.comment),
                    onLongPress: () {
                      showCommentReactionsSheet(
                        context,
                        targetUserId: widget.targetUserId,
                        postId: widget.postId,
                        commentId: widget.comment.id,
                        type: 'dislike',
                      );
                    },
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        HugeIcon(
                          icon: HugeIcons.strokeRoundedThumbsDown,
                          size: 15,
                          color: isDisliked
                              ? PostColors.dislike
                              : Colors.grey.shade500,
                        ),
                        if (widget.comment.disLikesCount > 0) ...[
                          const SizedBox(width: 3),
                          Text(
                            '${widget.comment.disLikesCount}',
                            style: TextStyle(
                              fontSize: 11.5,
                              fontWeight: FontWeight.w600,
                              color: isDisliked
                                  ? PostColors.dislike
                                  : Colors.grey.shade600,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),

                  GestureDetector(
                    onTap: () =>
                        widget.onReply(widget.comment, widget.comment.id),
                    child: Text(
                      'Reply',
                      style: TextStyle(
                        fontSize: 11.5,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            if (widget.comment.repliesExists) ...[
              const SizedBox(height: 6),
              Padding(
                padding: const EdgeInsets.only(left: 46),
                child: GestureDetector(
                  onTap: () => widget.onToggleExpand(widget.comment),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AnimatedRotation(
                        turns: widget.isExpanded ? 0.5 : 0,
                        duration: const Duration(milliseconds: 200),
                        child: HugeIcon(
                          icon: HugeIcons.strokeRoundedArrowDown01,
                          size: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(width: 4),
                      Text(
                        widget.isExpanded
                            ? 'Hide replies'
                            : widget.comment.repliesCount > 0
                            ? 'View ${widget.comment.repliesCount} replies'
                            : 'View replies',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: Colors.grey.shade600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],

            if (widget.isExpanded) ...[
              const SizedBox(height: 8),
              if (widget.isLoadingReplies)
                const Padding(
                  padding: EdgeInsets.only(left: 46),
                  child: SizedBox(
                    height: 20,
                    width: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                )
              else ...[
                ...widget.replies.map(
                  (reply) => Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: CommentCard(
                      comment: reply,
                      targetUserId: widget.targetUserId,
                      postId: widget.postId,
                      replies: widget.getReplies(reply.id),
                      isExpanded: widget.getExpanded(reply.id),
                      isLoadingReplies: widget.getLoading(reply.id),
                      hasMoreReplies: widget.getHasMore(reply.id),
                      isLoadingMoreReplies: widget.getLoadingMore(reply.id),
                      getReplies: widget.getReplies,
                      getExpanded: widget.getExpanded,
                      getLoading: widget.getLoading,
                      getHasMore: widget.getHasMore,
                      getLoadingMore: widget.getLoadingMore,
                      onReply: widget.onReply,
                      onLike: widget.onLike,
                      onDislike: widget.onDislike,
                      onToggleExpand: widget.onToggleExpand,
                      onLoadMoreReplies: widget.onLoadMoreReplies,
                      onEdit: widget.onEdit,
                      onDelete: widget.onDelete,
                      onUserTap: widget.onUserTap,
                    ),
                  ),
                ),

                if (widget.hasMoreReplies)
                  Padding(
                    padding: const EdgeInsets.only(left: 46, top: 8),
                    child: widget.isLoadingMoreReplies
                        ? const SizedBox(
                            height: 16,
                            width: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : GestureDetector(
                            onTap: () =>
                                widget.onLoadMoreReplies?.call(widget.comment),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                HugeIcon(
                                  icon: HugeIcons.strokeRoundedArrowDown01,
                                  size: 12,
                                  color: ColorConst.colorApp,
                                ),
                                const SizedBox(width: 4),
                                Text(
                                  'View more replies',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: ColorConst.colorApp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                  ),
              ],
            ],
          ],
        ),
      ),
    );
  }

  void _showOptionsMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (_) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.comment.isMyComment) ...[
              ListTile(
                leading: HugeIcon(
                  icon: HugeIcons.strokeRoundedPencilEdit01,
                  size: 20,
                  color: Colors.grey.shade700,
                ),
                title: const Text('Edit'),
                onTap: () {
                  Navigator.pop(context);
                  widget.onEdit?.call(widget.comment);
                },
              ),
              ListTile(
                leading: HugeIcon(
                  icon: HugeIcons.strokeRoundedDelete02,
                  size: 20,
                  color: Colors.red,
                ),
                title: const Text(
                  'Delete',
                  style: TextStyle(color: Colors.red),
                ),
                onTap: () {
                  Navigator.pop(context);
                  widget.onDelete?.call(widget.comment);
                },
              ),
            ] else
              ListTile(
                leading: HugeIcon(
                  icon: HugeIcons.strokeRoundedFlag02,
                  size: 20,
                  color: Colors.grey.shade700,
                ),
                title: const Text('Report'),
                onTap: () => Navigator.pop(context),
              ),
          ],
        ),
      ),
    );
  }
}
