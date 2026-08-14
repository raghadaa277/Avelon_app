import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:programmers_network_app/data/models/Home/posts/get_my_posts_model.dart';
import 'package:programmers_network_app/data/services/Home/posts/posts_services.dart';

class MyPostsController extends GetxController {
  final PostsServices _services = PostsServices();

  List<PostModel> posts = [];

  int currentPage = 1;
  int lastPage = 1;
  bool isLoading = false;
  bool isLoadingMore = false;

  @override
  void onInit() {
    super.onInit();
    fetchPosts();
  }

  Future<void> refreshPosts() async {
    currentPage = 1;
    posts.clear();

    await fetchPosts();

    update();
  }

  void updatePinnedPost(int postId) {
    final index = posts.indexWhere((post) => post.id == postId);

    if (index != -1) {
      posts[index].isPinned = !posts[index].isPinned;

      posts.sort((a, b) {
        if (a.isPinned && !b.isPinned) {
          return -1;
        }

        if (!a.isPinned && b.isPinned) {
          return 1;
        }

        return b.createdAt.compareTo(a.createdAt);
      });

      update();
    }
  }

  Future<void> fetchPosts({bool refresh = false}) async {
    if (isLoading) return;

    if (refresh) {
      currentPage = 1;
      lastPage = 1;
      posts.clear();
    }

    isLoading = true;
    update();

    try {
      final result = await _services.getMyPosts(page: 1);

      posts = result.data.posts;

      final uniquePosts = <int, PostModel>{};

      for (var post in posts) {
        uniquePosts[post.id] = post;
      }

      posts = uniquePosts.values.toList();

      posts.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      currentPage = result.data.currentPage;
      lastPage = result.data.lastPage;

      debugPrint("POSTS REFRESHED");
    } catch (e) {
      debugPrint(e.toString());
    }

    isLoading = false;
    update();
  }

  Future<void> loadMore() async {
    if (isLoadingMore || currentPage >= lastPage) return;

    isLoadingMore = true;
    update();

    try {
      final result = await _services.getMyPosts(page: currentPage + 1);

      for (var post in result.data.posts) {
        if (!posts.any((p) => p.id == post.id)) {
          posts.add(post);
        }
      }

      posts.sort((a, b) => b.createdAt.compareTo(a.createdAt));

      currentPage = result.data.currentPage;
      lastPage = result.data.lastPage;
    } catch (e) {
      debugPrint(e.toString());
    }

    isLoadingMore = false;
    update();
  }

  void removePostById(int postId) {
    posts.removeWhere((post) => post.id == postId);
    update();
  }

  void removeMediaFromPost(int postId, int mediaId) {
    final index = posts.indexWhere((post) => post.id == postId);

    if (index != -1) {
      posts[index].postMedia.removeWhere((media) => media.id == mediaId);

      update();
    }
  }

  bool get hasMore => currentPage < lastPage;

  void updateReaction({required int postId, required String reaction}) {
    final index = posts.indexWhere((p) => p.id == postId);
    if (index == -1) return;

    final post = posts[index];
    final wasLiked = post.reactionStatus == 'like';
    final wasDisliked = post.reactionStatus == 'dislike';

    int likes = post.likesCount;
    String newStatus;

    if (reaction == 'like') {
      if (wasLiked) {
        likes--;
        newStatus = '';
      } else {
        likes++;
        newStatus = 'like';
      }
    } else {
      newStatus = wasDisliked ? '' : 'dislike';
    }

    posts[index] = post.copyWith(
      likesCount: likes < 0 ? 0 : likes,
      reactionStatus: newStatus,
    );

    update();
  }
}
