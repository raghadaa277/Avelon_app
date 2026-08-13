import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

import 'package:programmers_network_app/controller/Home/get_activitis_controller.dart';
import 'package:programmers_network_app/controller/Home/posts/edit_post_controller.dart';
import 'package:programmers_network_app/controller/Home/reactions_controller.dart';
import 'package:programmers_network_app/controller/Home/search_controller.dart';
import 'package:programmers_network_app/core/const/color_const.dart';

import 'package:programmers_network_app/core/const/routesPage.dart';

import 'package:programmers_network_app/view/widget/Home/comment_widget.dart';
import 'package:programmers_network_app/view/widget/Home/search/searchPost/post_card_widget.dart';
import 'package:programmers_network_app/view/widget/Home/search/searchPost/post_viewed.dart';

class CommentedPostsPage extends StatefulWidget {
  const CommentedPostsPage({super.key});

  @override
  State<CommentedPostsPage> createState() => _CommentedPostsPageState();
}

class _CommentedPostsPageState extends State<CommentedPostsPage> {
  late final GetActivitiesController controller;

  late final SearchPageController searchController;

  late final ReactionsController reactionsController;

  late final EditPostController editPostController;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    controller = Get.put(GetActivitiesController(type: 'commented'));

    searchController = Get.put(SearchPageController());

    reactionsController = Get.put(ReactionsController());

    editPostController = Get.put(EditPostController());

    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (!_scrollController.hasClients) return;

    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      controller.loadMore();
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();

    Get.delete<GetActivitiesController>(force: true);

    Get.delete<SearchPageController>(force: true);

    Get.delete<ReactionsController>(force: true);

    Get.delete<EditPostController>(force: true);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.colorBackGroung,

      appBar: AppBar(
        backgroundColor: ColorConst.colorBackGroung,
        elevation: 0,
        centerTitle: false,

        title: const Text(
          'Commented Posts',
          style: TextStyle(
            fontSize: 19,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1F2937),
          ),
        ),

        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const HugeIcon(
            icon: HugeIcons.strokeRoundedArrowLeft01,
            size: 24,
            color: const Color(0xFF14B8A6),
          ),
        ),
      ),

      body: Obx(() {
        if (controller.isLoading.value && controller.posts.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(color: Color(0xFFB8FF1A)),
          );
        }

        if (controller.errorMessage.value.isNotEmpty &&
            controller.posts.isEmpty) {
          return _ErrorState(
            message: controller.errorMessage.value,
            onRetry: controller.refreshActivities,
          );
        }

        if (controller.posts.isEmpty) {
          return const _EmptyCommentedPosts();
        }

        return RefreshIndicator(
          color: const Color(0xFFB8FF1A),

          onRefresh: controller.refreshActivities,

          child: ListView.builder(
            controller: _scrollController,

            physics: const AlwaysScrollableScrollPhysics(),

            padding: const EdgeInsets.only(top: 8, bottom: 30),

            itemCount:
                controller.posts.length +
                (controller.currentPage < controller.lastPage ? 1 : 0),

            itemBuilder: (context, index) {
              if (index >= controller.posts.length) {
                return const Padding(
                  padding: EdgeInsets.symmetric(vertical: 20),
                  child: Center(
                    child: CircularProgressIndicator(color: Color(0xFFB8FF1A)),
                  ),
                );
              }

              final post = controller.posts[index];

              return PostViewTrackerWrapper(
                source: 'activities_commented',
                post: post,

                child: PostCardWidget(
                  key: ValueKey('commented-${post.id}'),

                  post: post,

                  media: post.postMedia,

                  onUserTap: () {
                    Get.toNamed(
                      AppRoute.otherUserProfilePage,
                      arguments: post.user.id,
                    );
                  },

                  onLike: () async {
                    searchController.updateReaction(
                      postId: post.id,
                      reaction: 'like',
                    );

                    final success = await reactionsController.reactions(
                      targetUserId: post.user.id,
                      postId: post.id,
                      type: 'like',
                    );

                    if (!success) {
                      controller.refreshActivities();
                    }
                  },

                  onDislike: () async {
                    searchController.updateReaction(
                      postId: post.id,
                      reaction: 'dislike',
                    );

                    final success = await reactionsController.reactions(
                      targetUserId: post.user.id,
                      postId: post.id,
                      type: 'dislike',
                    );

                    if (!success) {
                      controller.refreshActivities();
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
      }),
    );
  }
}

class _EmptyCommentedPosts extends StatelessWidget {
  const _EmptyCommentedPosts();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 78,
              height: 78,
              decoration: BoxDecoration(
                color: const Color(0xFF14B8A6).withOpacity(0.10),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedMessage01,
                  size: 36,
                  color: Color(0xFF14B8A6),
                ),
              ),
            ),

            const SizedBox(height: 18),

            const Text(
              'No commented posts yet',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w800,
                color: Color(0xFF1F2937),
              ),
            ),

            const SizedBox(height: 8),

            const Text(
              'Posts you comment on will appear here.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                height: 1.4,
                color: Color(0xFF6B7280),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorState({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const HugeIcon(
              icon: HugeIcons.strokeRoundedAlert02,
              size: 45,
              color: Colors.redAccent,
            ),

            const SizedBox(height: 15),

            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.redAccent, fontSize: 13),
            ),

            const SizedBox(height: 15),

            ElevatedButton(
              onPressed: onRetry,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFB8FF1A),
                foregroundColor: Colors.black,
                elevation: 0,
              ),
              child: const Text(
                'Try Again',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
