import 'package:flutter/material.dart';
import 'package:programmers_network_app/controller/Home/personalPage/get_target_user_post_controllerl.dart';
import 'package:programmers_network_app/controller/Home/posts/edit_post_controller.dart';
import 'package:programmers_network_app/controller/Home/reactions_controller.dart';
import 'package:get/get.dart';
import 'package:programmers_network_app/view/widget/Home/comment_widget.dart';
import 'package:programmers_network_app/view/widget/Home/search/searchPost/post_card_widget.dart';
import 'package:programmers_network_app/view/widget/Home/search/searchPost/post_viewed.dart';

class OtherUserPostsTab extends StatefulWidget {
  final int targetUserId;
  const OtherUserPostsTab({super.key, required this.targetUserId});

  @override
  State<OtherUserPostsTab> createState() => _OtherUserPostsTabState();
}

class _OtherUserPostsTabState extends State<OtherUserPostsTab> {
  late final TargetUserPostsController controller;
  final ReactionsController reactionsController =
      Get.find<ReactionsController>();
  final EditPostController editPostController = Get.find<EditPostController>();
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    controller = Get.put(
      TargetUserPostsController(),
      tag: 'posts_${widget.targetUserId}',
    );
    controller.fetchPosts(targetUserId: widget.targetUserId);
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      controller.loadMore(targetUserId: widget.targetUserId);
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    Get.delete<TargetUserPostsController>(
      tag: 'posts_${widget.targetUserId}',
      force: true,
    );
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value && controller.posts.isEmpty) {
        return const Center(child: CircularProgressIndicator());
      }

      if (controller.errorMessage.value.isNotEmpty &&
          controller.posts.isEmpty) {
        return Center(child: Text(controller.errorMessage.value));
      }

      if (controller.posts.isEmpty) {
        return const Center(child: Text('No posts yet'));
      }

      return RefreshIndicator(
        onRefresh: () =>
            controller.refreshPosts(targetUserId: widget.targetUserId),
        child: ListView.builder(
          controller: _scrollController,
          padding: const EdgeInsets.symmetric(vertical: 8),
          itemCount:
              controller.posts.length +
              (controller.isLoadingMore.value ? 1 : 0),
          itemBuilder: (context, index) {
            if (index >= controller.posts.length) {
              return const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: Center(child: CircularProgressIndicator()),
              );
            }

            final post = controller.posts[index];

            return PostViewTrackerWrapper(
              source: "profile",
              post: post,
              child: PostCardWidget(
                key: ValueKey(post.id),
                post: post,
                media: post.postMedia,
                onUserTap: () {},
                onLike: () async {
                  controller.updateReaction(postId: post.id, reaction: "like");
                  final success = await reactionsController.reactions(
                    targetUserId: post.user.id,
                    postId: post.id,
                    type: "like",
                  );
                  if (!success) {
                    controller.refreshPosts(targetUserId: widget.targetUserId);
                  }
                },
                onDislike: () async {
                  controller.updateReaction(
                    postId: post.id,
                    reaction: "dislike",
                  );
                  final success = await reactionsController.reactions(
                    targetUserId: post.user.id,
                    postId: post.id,
                    type: "dislike",
                  );
                  if (!success) {
                    controller.refreshPosts(targetUserId: widget.targetUserId);
                  }
                },
                onComment: () {
                  showCommentsPage(
                    context,
                    postId: post.id,
                    targetUserId: post.user.id,
                  );
                },
                onShare: () {},
                onSave: () async {
                  await editPostController.savePost(
                    targetUserId: post.user.id,
                    postId: post.id,
                  );
                },
                onTap: () {},
              ),
            );
          },
        ),
      );
    });
  }
}
