import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:programmers_network_app/data/models/Home/search_post_model.dart';
import 'package:timeago/timeago.dart' as timeago;
import 'package:programmers_network_app/core/const/post_color.dart';

import 'package:programmers_network_app/controller/Home/reactions_controller.dart';
import 'package:programmers_network_app/core/const/routesPage.dart';

Future<void> showReactionsSheet(
  BuildContext context, {
  required int postId,
  required int targetUserId,
  required String type,
  required Post post,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => ReactionsSheetContent(
      postId: postId,
      targetUserId: targetUserId,
      type: type,
      post: post,
    ),
  );
}

class ReactionsSheetContent extends StatefulWidget {
  final int postId;
  final int targetUserId;
  final String type;
  final Post post;

  const ReactionsSheetContent({
    super.key,
    required this.postId,
    required this.targetUserId,
    required this.type,
    required this.post,
  });

  @override
  State<ReactionsSheetContent> createState() => _ReactionsSheetContentState();
}

class _ReactionsSheetContentState extends State<ReactionsSheetContent> {
  final ScrollController _scrollController = ScrollController();

  late ReactionsController controller;

  @override
  void initState() {
    super.initState();

    controller = Get.find<ReactionsController>();

    controller.getReactions(
      targetUserId: widget.targetUserId,
      postId: widget.postId,
      type: widget.type,
      refresh: true,
    );

    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent - 150) {
        controller.loadMore();
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  bool get _isLike => widget.type == 'like';

  @override
  Widget build(BuildContext context) {
    final color = _isLike ? PostColors.like : PostColors.dislike;
    final title = _isLike ? 'Liked this post' : 'Disliked this post';

    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.35,
      maxChildSize: 0.9,
      expand: false,
      builder: (context, dragScrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(18)),
          ),
          child: GetBuilder<ReactionsController>(
            init: controller,
            builder: (c) {
              return Column(
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
                          _isLike
                              ? Icons.thumb_up_alt_rounded
                              : Icons.thumb_down_alt_rounded,
                          color: color,
                          size: 18,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          _isLike
                              ? (!widget.post.hideReactionsCount &&
                                        c.likesCount > 0
                                    ? '$title (${c.likesCount})'
                                    : title)
                              : (!widget.post.hideReactionsCount &&
                                        c.dislikesCount > 0
                                    ? '$title (${c.dislikesCount})'
                                    : title),
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1),
                  Expanded(child: _buildBody(c)),
                ],
              );
            },
          ),
        );
      },
    );
  }

  Widget _buildBody(ReactionsController c) {
    if (c.isLoading && c.reaction.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (c.errorMessage.value.isNotEmpty && c.reaction.isEmpty) {
      return Center(child: Text(c.errorMessage.value));
    }

    if (c.reaction.isEmpty) {
      return const Center(child: Text('No one yet'));
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
      itemCount: c.reaction.length + (c.isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= c.reaction.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        final user = c.reaction[index];
        final createdAt = user.pivot.createdAt;

        final time = createdAt != null
            ? timeago.format(DateTime.tryParse(createdAt) ?? DateTime.now())
            : '';

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
            onTap: () {
              Navigator.pop(context);
              Get.toNamed(AppRoute.otherUserProfilePage, arguments: user.id);
            },
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
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
            subtitle: user.userProfile.username.isNotEmpty
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
