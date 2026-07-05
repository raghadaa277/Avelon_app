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
    fetchPosts();
    super.onInit();
  }

  Future<void> fetchPosts() async {
    isLoading = true;
    currentPage = 1;
    posts = [];
    update();

    try {
      final result = await _services.getMyPosts(page: 1);
      posts = result.data.posts;
      posts.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      currentPage = result.data.currentPage;
      lastPage = result.data.lastPage;
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
      posts.addAll(result.data.posts);
      posts.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      currentPage = result.data.currentPage;
      lastPage = result.data.lastPage;
    } catch (e) {
      debugPrint(e.toString());
    }
    isLoadingMore = false;
    update();
  }

  bool get hasMore => currentPage < lastPage;
}
