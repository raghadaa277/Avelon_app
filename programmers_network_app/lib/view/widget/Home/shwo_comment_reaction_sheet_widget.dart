import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:programmers_network_app/controller/Home/posts/comments/get_reactions_comments_controller.dart';
import 'package:programmers_network_app/core/const/post_color.dart';
import 'package:timeago/timeago.dart' as timeago;

Future<void> showCommentReactionsSheet(
  BuildContext context, {
  required int commentId,
  required int postId,
  required int targetUserId,
  required String type,
}) {
  final tag = "${commentId}_$type";

  Get.put(GetReactionsCommentController(), tag: tag);

  return showModalBottomSheet(
    context: context,

    isScrollControlled: true,

    backgroundColor: Colors.transparent,

    builder: (_) => CommentReactionsSheetContent(
      tag: tag,
      commentId: commentId,
      postId: postId,
      targetUserId: targetUserId,
      type: type,
    ),
  ).whenComplete(() {
    if (Get.isRegistered<GetReactionsCommentController>(tag: tag)) {
      Get.delete<GetReactionsCommentController>(tag: tag);
    }
  });
}

class CommentReactionsSheetContent extends StatefulWidget {
  final String tag;

  final int commentId;
  final int postId;
  final int targetUserId;
  final String type;

  const CommentReactionsSheetContent({
    super.key,
    required this.tag,
    required this.commentId,
    required this.postId,
    required this.targetUserId,
    required this.type,
  });

  @override
  State<CommentReactionsSheetContent> createState() =>
      _CommentReactionsSheetContentState();
}

class _CommentReactionsSheetContentState
    extends State<CommentReactionsSheetContent> {
  late GetReactionsCommentController controller;

  final ScrollController scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    controller = Get.find<GetReactionsCommentController>(tag: widget.tag);

    controller.getReactions(
      targetUserId: widget.targetUserId,
      postId: widget.postId,
      commentId: widget.commentId,
      type: widget.type,
      refresh: true,
    );

    scrollController.addListener(() {
      if (scrollController.position.pixels >=
          scrollController.position.maxScrollExtent - 150) {
        controller.loadMore();
      }
    });
  }

  @override
  void dispose() {
    scrollController.dispose();

    super.dispose();
  }

  bool get isLike => widget.type == "like";

  @override
  Widget build(BuildContext context) {
    final color = isLike ? PostColors.like : PostColors.dislike;

    final title = isLike ? "Liked this comment" : "Disliked this comment";

    return DraggableScrollableSheet(
      initialChildSize: .6,

      minChildSize: .35,

      maxChildSize: .9,

      expand: false,

      builder: (context, _) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,

          borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
        ),

        child: GetBuilder<GetReactionsCommentController>(
          tag: widget.tag,

          builder: (c) => Column(
            children: [
              const SizedBox(height: 8),

              Container(
                width: 40,

                height: 4,

                decoration: BoxDecoration(
                  color: Colors.grey.shade300,

                  borderRadius: BorderRadius.circular(2),
                ),
              ),

              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12),

                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,

                  children: [
                    Icon(
                      isLike
                          ? Icons.thumb_up_alt_rounded
                          : Icons.thumb_down_alt_rounded,

                      color: color,

                      size: 18,
                    ),

                    const SizedBox(width: 6),

                    Text(
                      "$title (${c.total})",

                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),

              const Divider(height: 1),

              Expanded(child: _body(c)),
            ],
          ),
        ),
      ),
    );
  }

  Widget _body(GetReactionsCommentController c) {
    if (c.isLoading && c.reactions.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (c.errorMessage.value.isNotEmpty && c.reactions.isEmpty) {
      return Center(child: Text(c.errorMessage.value));
    }

    if (c.reactions.isEmpty) {
      return const Center(child: Text("No one yet"));
    }

    return ListView.builder(
      controller: scrollController,

      padding: const EdgeInsets.all(12),

      itemCount: c.reactions.length + (c.isLoadingMore ? 1 : 0),

      itemBuilder: (context, index) {
        if (index >= c.reactions.length) {
          return const Padding(
            padding: EdgeInsets.all(16),

            child: Center(child: CircularProgressIndicator()),
          );
        }

        final user = c.reactions[index];

        final time = user.pivot.createdAt != null
            ? timeago.format(
                DateTime.tryParse(user.pivot.createdAt!) ?? DateTime.now(),
              )
            : "";

        return Card(
          margin: const EdgeInsets.only(bottom: 8),
          elevation: 10,
          shadowColor: Colors.black,
          color: Colors.grey.shade50,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
            side: BorderSide(color: Colors.grey.shade200),
          ),

          child: ListTile(
            leading: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey.shade200,
              backgroundImage: user.userProfile.avatarFullUrl != null
                  ? NetworkImage(user.userProfile.avatarFullUrl!)
                  : null,
              child: user.userProfile.avatarFullUrl == null
                  ? Text(user.fullName.isNotEmpty ? user.fullName[0] : '?')
                  : null,
            ),

            title: Text(
              user.fullName,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
            subtitle: user.userProfile.username != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '@${user.userProfile.username}',
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 12,
                        ),
                      ),
                      const SizedBox(height: 4),
                    ],
                  )
                : null,
            trailing: Text(
              time,
              style: TextStyle(color: Colors.grey.shade500, fontSize: 12),
            ),
          ),
        );
      },
    );
  }
}
