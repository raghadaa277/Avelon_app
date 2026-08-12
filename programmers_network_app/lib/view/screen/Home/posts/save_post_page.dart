import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:programmers_network_app/controller/Home/posts/edit_post_controller.dart';
import 'package:programmers_network_app/controller/Home/posts/get_save_post_controller.dart';
import 'package:programmers_network_app/controller/Home/reactions_controller.dart';
import 'package:programmers_network_app/core/const/color_const.dart';
import 'package:programmers_network_app/core/const/routesPage.dart';
import 'package:programmers_network_app/view/widget/Home/comment_widget.dart';

import 'package:programmers_network_app/view/widget/Home/search/searchPost/post_viewed.dart';
import 'package:programmers_network_app/view/widget/Home/search/searchPost/post_card_widget.dart';

class SavedPostsPage extends StatefulWidget {
  const SavedPostsPage({super.key});

  @override
  State<SavedPostsPage> createState() => _SavedPostsPageState();
}

class _SavedPostsPageState extends State<SavedPostsPage> {
  final SavedPostsController controller = Get.put(SavedPostsController());
  final EditPostController editPostController = Get.put(EditPostController());
  final ReactionsController reactionsController = Get.put(
    ReactionsController(),
  );
  final FocusNode _searchFocusNode = FocusNode();

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();

    if (controller.savedPosts.isEmpty) {
      controller.getSavedPosts(refresh: true);
    }
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.dispose();

    Get.delete<SavedPostsController>(force: true);
    Get.delete<EditPostController>(force: true);
    Get.delete<ReactionsController>(force: true);
    super.dispose();
  }

  void _onScroll() {
    if (_scrollController.position.pixels >=
        _scrollController.position.maxScrollExtent - 200) {
      controller.loadMore();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.colorBackGroung,
      appBar: AppBar(
        backgroundColor: ColorConst.colorBackGroung,
        elevation: 0,
        title: const Text(
          "Saved Posts",
          style: TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
        ),
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SafeArea(
        child: GetBuilder<SavedPostsController>(
          init: controller,
          builder: (controller) => _buildBody(controller),
        ),
      ),
    );
  }

  Widget _buildBody(SavedPostsController controller) {
    if (controller.isLoading && controller.savedPosts.isEmpty) {
      return const Center(child: CircularProgressIndicator());
    }

    if (controller.errorMessage.value.isNotEmpty &&
        controller.savedPosts.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.error_outline_rounded,
                size: 45,
                color: Colors.redAccent,
              ),
              const SizedBox(height: 12),
              Text(
                controller.errorMessage.value,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 14, color: Colors.black87),
              ),
              const SizedBox(height: 15),
              ElevatedButton(
                onPressed: () {
                  controller.getSavedPosts(refresh: true);
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    if (controller.savedPosts.isEmpty) {
      return Center(child: const Text("No save post found"));
    }

    return RefreshIndicator(
      onRefresh: () {
        return controller.getSavedPosts(refresh: true);
      },
      child: ListView.builder(
        controller: _scrollController,
        physics: const AlwaysScrollableScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount:
            controller.savedPosts.length + (controller.isLoadingMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == controller.savedPosts.length) {
            return const Padding(
              padding: EdgeInsets.symmetric(vertical: 20),
              child: Center(child: CircularProgressIndicator()),
            );
          }

          final post = controller.savedPosts[index];

          return PostViewTrackerWrapper(
            source: "saved",
            post: post,
            child: PostCardWidget(
              key: ValueKey(post.id),
              post: post,
              media: post.postMedia,
              onUserTap: () {
                Get.toNamed(
                  AppRoute.otherUserProfilePage,
                  arguments: post.user.id,
                );
              },
              onLike: () async {
                await reactionsController.reactions(
                  targetUserId: post.user.id,
                  postId: post.id,
                  type: "like",
                );
              },
              onDislike: () async {
                await reactionsController.reactions(
                  targetUserId: post.user.id,
                  postId: post.id,
                  type: "dislike",
                );
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
                _searchFocusNode.unfocus();

                await editPostController.savePost(
                  targetUserId: post.user.id,
                  postId: post.id,
                );
                controller.removeSavedPost(post.id);
              },
              onTap: () {},
            ),
          );
        },
      ),
    );
  }
}
