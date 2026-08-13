import 'package:get/get.dart';
import 'package:programmers_network_app/data/models/Home/search_post_model.dart';
import 'package:programmers_network_app/data/services/Home/home_page_services.dart';
import 'package:programmers_network_app/view/widget/Home/feed_source_dialoge_widget.dart';

class HomePageController extends GetxController {
  final HomePageServices _services = HomePageServices();

  List<Post> posts = [];
  bool isLoadingHome = false;
  bool isLoadingMoreHome = false;
  int currentHomePage = 1;
  int lastHomePage = 1;

  final RxString errorMessage = ''.obs;

  Future<void> getFeed({bool refresh = true}) async {
    if (isLoadingHome) return;

    if (refresh) {
      currentHomePage = 1;
    }

    isLoadingHome = true;
    errorMessage.value = '';
    update();

    try {
      final result = await _services.feed(page: currentHomePage);
      if (result.success) {
        posts = refresh ? result.data.posts : [...posts, ...result.data.posts];
        lastHomePage = result.data.lastPage;
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoadingHome = false;
      update();
    }
  }

  Future<void> loadMorePosts() async {
    if (isLoadingMoreHome || isLoadingHome) return;
    if (currentHomePage >= lastHomePage) return;

    isLoadingMoreHome = true;
    update();

    currentHomePage++;

    try {
      final result = await _services.feed(page: currentHomePage);

      if (result.success) {
        posts.addAll(result.data.posts);
        lastHomePage = result.data.lastPage;
      }
    } catch (e) {
      currentHomePage--;
      errorMessage.value = e.toString();
    } finally {
      isLoadingMoreHome = false;
      update();
    }
  }

  void removePostsByUser(int userId) {
    posts.removeWhere((post) => post.user.id == userId);
    update();
  }

  Future<void> getSource({required int feedId}) async {
    try {
      final result = await _services.getSource(feedId: feedId);

      if (result.success) {
        Get.dialog(FeedSourceDialog(reasons: result.data));
      } else {
        Get.snackbar("Error", result.message);
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    }
  }

  void updateReaction({required int postId, required String reaction}) {
    final index = posts.indexWhere((e) => e.id == postId);

    if (index == -1) return;

    final post = posts[index];

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

    update();
  }

  void updateSavedPost(int postId) {
    final index = posts.indexWhere((post) => post.id == postId);

    if (index == -1) return;

    final post = posts[index];
    posts[index] = post.copyWith(isSaved: !post.isSaved);

    update();
  }

  void incrementLocalViewCount(int postId) {
    final index = posts.indexWhere((p) => p.id == postId);
    if (index == -1) return;

    final post = posts[index];

    if (post.viewers.isEmpty) {
      posts[index] = post.copyWith(isViewed: true);
    } else {
      final myViewer = post.viewers.first;
      final updatedViewer = myViewer.copyWith(
        pivot: myViewer.pivot.copyWith(
          viewCount: myViewer.pivot.viewCount + 1,
          lastViewedAt: DateTime.now(),
        ),
      );

      final updatedViewers = List<Viewer>.from(post.viewers);
      updatedViewers[0] = updatedViewer;

      posts[index] = post.copyWith(isViewed: true, viewers: updatedViewers);
    }

    update();
  }
}
