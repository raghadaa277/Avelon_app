import 'package:get/state_manager.dart';
import 'package:programmers_network_app/data/models/Home/search_model.dart';
import 'package:programmers_network_app/data/models/Home/search_post_model.dart';
import 'package:programmers_network_app/data/services/Home/search_services.dart';

class SearchPageController extends GetxController {
  final SearchServices _searchServices = SearchServices();

  List<SearchUserModel> users = [];
  bool isLoading = false;
  bool isLoadingMore = false;
  int currentPage = 1;
  int lastPage = 1;
  String? currentType;
  String? currentSearch;

  List<Post> posts = [];
  bool isLoadingPosts = false;
  bool isLoadingMorePosts = false;
  int currentPostPage = 1;
  int lastPostPage = 1;
  String? currentPostType;
  String? currentPostSearch;

  final RxString errorMessage = ''.obs;

  bool hasSearchedPosts = false;

  Future<void> search({
    required String user,
    required String search,
    bool refresh = true,
  }) async {
    if (isLoading) return;
    hasSearchedPosts = true;
    if (refresh) {
      currentPage = 1;
      users.clear();
    }

    isLoading = true;
    errorMessage.value = '';
    update();

    try {
      currentType = user;
      currentSearch = search;

      final result = await _searchServices.search(
        user: user,
        search: search,
        page: currentPage,
      );

      if (result.success) {
        users.addAll(result.data.users);
        lastPage = result.data.lastPage;
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> loadMore() async {
    if (isLoadingMore || isLoading) return;
    if (currentPage >= lastPage) return;
    if (currentType == null || currentSearch == null) return;

    isLoadingMore = true;
    update();

    currentPage++;

    try {
      final result = await _searchServices.search(
        user: currentType!,
        search: currentSearch!,
        page: currentPage,
      );

      if (result.success) {
        users.addAll(result.data.users);
        lastPage = result.data.lastPage;
      }
    } catch (e) {
      currentPage--;
      errorMessage.value = e.toString();
    } finally {
      isLoadingMore = false;
      update();
    }
  }

  Future<void> searchPost({
    required String type,
    required String search,
    bool refresh = true,
  }) async {
    if (isLoadingPosts) return;

    hasSearchedPosts = true;

    if (refresh) {
      currentPostPage = 1;
      posts.clear();
    }

    isLoadingPosts = true;
    errorMessage.value = '';
    update();

    try {
      currentPostType = type;
      currentPostSearch = search;

      final result = await _searchServices.getPostSearch(
        type: type,
        search: search,
        page: currentPostPage,
      );

      if (result.success) {
        posts.addAll(result.data.data);
        lastPostPage = result.data.lastPage;
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoadingPosts = false;
      update();
    }
  }

  Future<void> loadMorePosts() async {
    if (isLoadingMorePosts || isLoadingPosts) return;
    if (currentPostPage >= lastPostPage) return;
    if (currentPostType == null || currentPostSearch == null) return;

    isLoadingMorePosts = true;
    update();

    currentPostPage++;

    try {
      final result = await _searchServices.getPostSearch(
        type: currentPostType!,
        search: currentPostSearch!,
        page: currentPostPage,
      );

      if (result.success) {
        posts.addAll(result.data.data);
        lastPostPage = result.data.lastPage;
      }
      for (final post in posts) {
        print("Post ID: ${post.id}");
      }
    } catch (e) {
      currentPostPage--;
      errorMessage.value = e.toString();
    } finally {
      isLoadingMorePosts = false;
      update();
    }
  }

  void updateReaction({required int postId, required String reaction}) {
    final index = posts.indexWhere((e) => e.id == postId);

    if (index == -1) return;

    final post = posts[index];

    print("========== BEFORE UPDATE ==========");
    print("Post ID: ${post.id}");
    print("likesCount: ${post.likesCount}");
    print("disLikesCount: ${post.disLikesCount}");
    print("reactionStatus: ${post.reactionStatus}");
    print("====================================");

    int likes = post.likesCount;
    int dislikes = post.disLikesCount;

    String? status = post.reactionStatus;
    if (status == "nolike" ||
        status == "null" ||
        status == "" ||
        status == null) {
      status = null;
    }

    if (reaction == "like") {
      if (status == "like") {
        likes--;
        status = null;
      } else if (status == "dislike") {
        dislikes--;
        likes++;
        status = "like";
      } else {
        likes++;
        status = "like";
      }
    } else if (reaction == "dislike") {
      if (status == "dislike") {
        dislikes--;
        status = null;
      } else if (status == "like") {
        likes--;
        dislikes++;
        status = "dislike";
      } else {
        dislikes++;
        status = "dislike";
      }
    }

    if (likes < 0) likes = 0;
    if (dislikes < 0) dislikes = 0;

    posts[index] = post.copyWith(
      likesCount: likes,
      disLikesCount: dislikes,
      reactionStatus: status ?? "",
    );

    print("========== AFTER UPDATE ==========");
    print("Post ID: ${posts[index].id}");
    print("likesCount: ${posts[index].likesCount}");
    print("disLikesCount: ${posts[index].disLikesCount}");
    print("reactionStatus: ${posts[index].reactionStatus}");
    print("====================================");

    update();
  }

  void updateSavedPost(int postId) {
    final index = posts.indexWhere((post) => post.id == postId);

    if (index == -1) return;

    final post = posts[index];
    posts[index] = post.copyWith(isSaved: !post.isSaved);

    update();
  }
}
