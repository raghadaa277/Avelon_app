import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:programmers_network_app/controller/Home/posts/edit_post_controller.dart';
import 'package:programmers_network_app/core/const/post_color.dart';
import 'package:programmers_network_app/data/models/Home/search_post_model.dart';
import 'package:timeago/timeago.dart' as timeago;

Future<void> showViewsSheet(
  BuildContext context, {
  required int postId,
  required int targetUserId,
  required Post post,
}) {
  return showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => ViewsSheetContent(
      postId: postId,
      targetUserId: targetUserId,
      post: post,
    ),
  );
}

class ViewsSheetContent extends StatefulWidget {
  final int postId;
  final int targetUserId;
  final Post post;

  const ViewsSheetContent({
    super.key,
    required this.postId,
    required this.targetUserId,
    required this.post,
  });

  @override
  State<ViewsSheetContent> createState() => _ViewsSheetContentState();
}

class _ViewsSheetContentState extends State<ViewsSheetContent> {
  final ScrollController _scrollController = ScrollController();

  late EditPostController controller;

  @override
  void initState() {
    super.initState();

    controller = Get.find<EditPostController>();

    controller.getViewPost(
      targetUserId: widget.targetUserId,
      postId: widget.postId,
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

  @override
  Widget build(BuildContext context) {
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
          child: GetBuilder<EditPostController>(
            init: controller,
            builder: (c) {
              final int viewCount = c.viewUser.fold(
                0,
                (sum, user) => sum + user.pivot.viewCount,
              );
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
                        const HugeIcon(
                          icon: HugeIcons.strokeRoundedUser,
                          color: PostColors.views,
                          size: 25,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          'Views ($viewCount)',
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(width: 3),
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

  Widget _buildBody(EditPostController c) {
    if (c.isLoading && c.viewUser.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (c.errorMessage.value.isNotEmpty && c.viewUser.isEmpty) {
      return Center(child: Text(c.errorMessage.value));
    }

    if (c.viewUser.isEmpty) {
      return const Center(child: Text('No one yet'));
    }

    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
      itemCount: c.viewUser.length + (c.isLoadingMore ? 1 : 0),
      itemBuilder: (context, index) {
        if (index >= c.viewUser.length) {
          return const Padding(
            padding: EdgeInsets.symmetric(vertical: 16),
            child: Center(child: CircularProgressIndicator()),
          );
        }
        final user = c.viewUser[index];

        final viewedAt = user.pivot.lastViewedAt;

        final time = viewedAt != null
            ? timeago.format(DateTime.tryParse(viewedAt) ?? DateTime.now())
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
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (user.userProfile.username.isNotEmpty)
                  Text(
                    '@${user.userProfile.username}',
                    style: TextStyle(color: Colors.grey.shade600, fontSize: 12),
                  ),

                const SizedBox(height: 4),

                // Row(
                //   children: [
                //     const HugeIcon(
                //       icon: HugeIcons.strokeRoundedView,
                //       size: 14,
                //       color: Colors.blueGrey,
                //     ),
                //     const SizedBox(width: 4),
                //     // Text(
                //     //   '${user.pivot.viewCount} views',
                //     //   style: TextStyle(
                //     //     color: Colors.grey.shade600,
                //     //     fontSize: 12,
                //     //   ),
                //     // ),
                //   ],
                // ),
              ],
            ),
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
