import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:programmers_network_app/controller/Home/posts/comments/edit_comment_controller.dart';
import 'package:programmers_network_app/core/const/color_const.dart';
import 'package:programmers_network_app/core/const/post_color.dart';
import 'package:programmers_network_app/core/const/routesPage.dart';
import 'package:programmers_network_app/view/widget/Home/comment_card_widget.dart';
import 'package:programmers_network_app/controller/Home/posts/comments/comments_controller.dart';

Future<void> showCommentsPage(
  BuildContext context, {
  required int postId,
  required int targetUserId,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    backgroundColor: Colors.transparent,
    builder: (_) => CommentsPage(postId: postId, targetUserId: targetUserId),
  );
}

class CommentsPage extends StatefulWidget {
  final int postId;
  final int targetUserId;

  const CommentsPage({
    super.key,
    required this.postId,
    required this.targetUserId,
  });

  @override
  State<CommentsPage> createState() => _CommentsPageState();
}

class _CommentsPageState extends State<CommentsPage> {
  late CommentsController controller;
  late EditCommentController editCommentController;
  final TextEditingController _commentTextController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  int? _replyingToRootId;

  String? _replyingToUserName;

  @override
  void initState() {
    super.initState();

    controller = Get.put(CommentsController(), tag: widget.postId.toString());
    editCommentController = Get.put(EditCommentController());

    WidgetsBinding.instance.addPostFrameCallback((_) {
      controller.getPostComments(
        targetUserId: widget.targetUserId,
        postId: widget.postId,
      );
    });

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 200) {
        controller.loadMore();
      }
    });
  }

  @override
  void dispose() {
    _commentTextController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _startReply(int rootCommentId, String userName) {
    setState(() {
      _replyingToRootId = rootCommentId;
      _replyingToUserName = userName;
    });
  }

  void _cancelReply() {
    setState(() {
      _replyingToRootId = null;
      _replyingToUserName = null;
    });
  }

  Future<void> _submitComment() async {
    final text = _commentTextController.text.trim();
    if (text.isEmpty) return;
    if (controller.isSubmittingComment) return;

    final replyingToRootId = _replyingToRootId;

    _commentTextController.clear();
    _cancelReply();
    FocusScope.of(context).unfocus();

    await controller.createComment(
      targetUserId: widget.targetUserId,
      postId: widget.postId,
      content: text,

      parentId: replyingToRootId,
    );

    if (replyingToRootId == null && _scrollController.hasClients) {
      _scrollController.animateTo(
        0,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  Future<void> _onRefresh() {
    return controller.getPostComments(
      targetUserId: widget.targetUserId,
      postId: widget.postId,
      refresh: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.95,
      minChildSize: 0.6,
      maxChildSize: 0.98,
      expand: false,
      builder: (context, dragScrollController) {
        return AnimatedPadding(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOut,
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
            ),
            child: Column(
              children: [
                _buildDragHandle(),
                _buildHeader(context),
                const Divider(height: 1),
                Expanded(
                  child: GetBuilder<CommentsController>(
                    tag: widget.postId.toString(),
                    builder: (c) => _buildBody(c),
                  ),
                ),
                const Divider(height: 1),
                _buildCommentInput(),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDragHandle() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: 40,
        height: 4,
        decoration: BoxDecoration(
          color: Colors.grey.shade300,
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(width: 40),
          HugeIcon(
            icon: HugeIcons.strokeRoundedComment01,
            size: 20,
            color: PostColors.comment,
          ),
          GetBuilder<CommentsController>(
            tag: widget.postId.toString(),
            builder: (c) => Text(
              c.total > 0 ? 'Comments (${c.total})' : 'Comments',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
          IconButton(
            icon: HugeIcon(
              icon: HugeIcons.strokeRoundedCancel01,
              color: Colors.grey.shade700,
              size: 20,
            ),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
    );
  }

  Widget _buildBody(CommentsController c) {
    if (c.isLoading && c.comments.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (c.errorMessage.value.isNotEmpty && c.comments.isEmpty) {
      return RefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView(
          children: [
            SizedBox(
              height: 300,
              child: Center(child: Text(c.errorMessage.value)),
            ),
          ],
        ),
      );
    }

    if (c.comments.isEmpty) {
      return RefreshIndicator(
        onRefresh: _onRefresh,
        child: ListView(
          children: [
            SizedBox(
              height: 300,
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    HugeIcon(
                      icon: HugeIcons.strokeRoundedComment01,
                      size: 48,
                      color: Colors.grey.shade300,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'No comments yet',
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Be the first to comment',
                      style: TextStyle(
                        color: Colors.grey.shade400,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    }

    return RefreshIndicator(
      onRefresh: _onRefresh,
      child: ListView.builder(
        controller: _scrollController,
        padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
        itemCount: c.sortedComments.length + (c.isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index >= c.sortedComments.length) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 16),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final comment = c.sortedComments[index];
          return CommentCard(
            comment: comment,

            replies: c.repliesOf(comment.id),

            isLoadingReplies: c.isLoadingRepliesOf(comment.id),

            isExpanded: c.isRepliesExpanded(comment.id),

            getReplies: c.repliesOf,
            getExpanded: c.isRepliesExpanded,
            getLoading: c.isLoadingRepliesOf,
            getHasMore: c.hasMoreReplies,
            getLoadingMore: c.isLoadingMoreRepliesOf,

            onReply: (target, rootId) =>
                _startReply(rootId, target.userPostComment.fullName),
            onLike: (target) {
              controller.reactToComment(
                targetUserId: widget.targetUserId,
                postId: widget.postId,
                commentId: target.id,
                type: 'like',
              );
            },
            onDislike: (target) {
              controller.reactToComment(
                targetUserId: widget.targetUserId,
                postId: widget.postId,
                commentId: target.id,
                type: 'dislike',
              );
            },
            onUserTap: (target) {
              Navigator.pop(context);
              Get.toNamed(
                AppRoute.otherUserProfilePage,
                arguments: target.userPostComment.id,
              );
            },
            onToggleExpand: (target) {
              controller.toggleReplies(
                targetUserId: widget.targetUserId,
                postId: widget.postId,
                commentId: target.id,
              );
            },
            onLoadMoreReplies: (target) {
              controller.loadMoreReplies(
                targetUserId: widget.targetUserId,
                postId: widget.postId,
                commentId: target.id,
              );
            },
            onEdit: (target) async {
              final editController = TextEditingController(
                text: target.content,
              );

              final newContent = await showDialog<String>(
                context: context,
                builder: (ctx) => AlertDialog(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  title: const Text('Edit comment'),
                  content: TextField(
                    controller: editController,
                    maxLines: 4,
                    autofocus: true,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Write something...',
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () =>
                          Navigator.pop(ctx, editController.text.trim()),
                      child: const Text('Save'),
                    ),
                  ],
                ),
              );

              if (newContent == null ||
                  newContent.isEmpty ||
                  newContent == target.content) {
                return;
              }

              final success = await editCommentController.editComment(
                targetUserId: widget.targetUserId,
                postId: widget.postId,
                commentId: target.id,
                content: newContent,
              );
              print('Edit success: $success');

              if (success) {
                controller.updateCommentContent(
                  commentId: target.id,
                  content: newContent,
                );
              }
            },
            onDelete: (comment) {
              controller.deleteComment(
                targetUserId: widget.targetUserId,
                postId: widget.postId,
                commentId: comment.id,
                removeMyComment: true,
              );
            },
            targetUserId: widget.targetUserId,
            postId: widget.postId,
          );
        },
      ),
    );
  }

  Widget _buildCommentInput() {
    return SafeArea(
      top: false,
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (_replyingToRootId != null)
              Padding(
                padding: const EdgeInsets.only(bottom: 6, left: 4),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        'Replying to $_replyingToUserName',
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade600,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: _cancelReply,
                      child: HugeIcon(
                        icon: HugeIcons.strokeRoundedCancel01,
                        size: 14,
                        color: Colors.grey.shade600,
                      ),
                    ),
                  ],
                ),
              ),

            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 18,
                  backgroundImage: controller.currentUser?.avatarFullUrl != null
                      ? NetworkImage(controller.currentUser!.avatarFullUrl!)
                      : null,
                  child: controller.currentUser?.avatarFullUrl == null
                      ? const Icon(Icons.person, size: 18)
                      : null,
                ),

                const SizedBox(width: 8),

                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 8,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: TextField(
                      controller: _commentTextController,
                      minLines: 1,
                      maxLines: 4,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,

                      decoration: InputDecoration(
                        hintText: _replyingToRootId != null
                            ? 'Write a reply...'
                            : 'Write a comment...',
                        hintStyle: TextStyle(color: Colors.grey.shade500),
                        border: InputBorder.none,
                        isDense: true,
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 8),

                GetBuilder<CommentsController>(
                  tag: widget.postId.toString(),
                  builder: (c) {
                    return GestureDetector(
                      onTap: c.isSubmittingComment ? null : _submitComment,

                      child: Container(
                        padding: const EdgeInsets.all(10),
                        decoration: const BoxDecoration(
                          color: ColorConst.colorApp,
                          shape: BoxShape.circle,
                        ),

                        child: c.isSubmittingComment
                            ? const SizedBox(
                                height: 16,
                                width: 16,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                  color: Colors.white,
                                ),
                              )
                            : const HugeIcon(
                                icon: HugeIcons.strokeRoundedSent,
                                size: 16,
                                color: Colors.white,
                              ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
