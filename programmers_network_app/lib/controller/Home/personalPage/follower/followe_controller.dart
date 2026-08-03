import 'package:get/get.dart';
import 'package:programmers_network_app/data/models/Home/personalPage/follower/get_follows_model.dart';
import 'package:programmers_network_app/data/services/Home/personalPage/follower/followe_services.dart';

enum FollowAction { followed, unfollowed }

class FolloweController extends GetxController {
  final FolloweServices services = FolloweServices();

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxBool isLoadingMore = false.obs;
  final RxString followStatus = 'none'.obs;

  void setFollowStatus(String status) {
    followStatus.value = status;
  }

  Future<FollowAction?> toggleFollowing({required int targetUserId}) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final result = await services.toggleFollowing(targetUserId: targetUserId);

      if (result.success) {
        FollowAction? action;

        switch (followStatus.value) {
          case 'none':
            followStatus.value = 'following';
            action = FollowAction.followed;
            break;

          case 'following':
            followStatus.value = 'none';
            action = FollowAction.unfollowed;
            break;

          case 'follower':
            followStatus.value = 'mutual';
            action = FollowAction.followed;
            break;

          case 'mutual':
            followStatus.value = 'follower';
            action = FollowAction.unfollowed;
            break;
        }

        update();

        return action;
      } else {
        Get.snackbar("Error", result.message);
      }
    } catch (e) {
      errorMessage.value = e.toString();

      Get.snackbar("Error", errorMessage.value);
      return null;
    } finally {
      isLoading.value = false;
      update();
    }
    return null;
  }

  final RxList<FollowerUser> followers = <FollowerUser>[].obs;

  int _currentPage = 1;
  int _lastPage = 1;
  int total = 0;

  int? _targetUserId;
  String? _type;

  bool get hasMore => _currentPage < _lastPage;

  Future<void> fetchFollowers({
    required int targetUserId,
    required String type,
    bool refresh = false,
  }) async {
    if (!refresh &&
        _targetUserId == targetUserId &&
        _type == type &&
        followers.isNotEmpty) {
      return;
    }

    _targetUserId = targetUserId;
    _type = type;
    _currentPage = 1;

    try {
      isLoading.value = true;
      errorMessage.value = '';

      final result = await services.getFollowers(
        targetUserId: targetUserId,
        type: type,
        page: _currentPage,
      );

      if (result.success) {
        followers.assignAll(result.data.followers);
        _currentPage = result.data.currentPage;
        _lastPage = result.data.lastPage;
        total = result.data.total;
      } else {
        errorMessage.value = result.message;
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMore() async {
    if (isLoadingMore.value || isLoading.value) return;
    if (!hasMore) return;
    if (_targetUserId == null || _type == null) return;

    try {
      isLoadingMore.value = true;

      final result = await services.getFollowers(
        targetUserId: _targetUserId!,
        type: _type!,
        page: _currentPage + 1,
      );

      if (result.success) {
        followers.addAll(result.data.followers);
        _currentPage = result.data.currentPage;
        _lastPage = result.data.lastPage;
        total = result.data.total;
      } else {
        errorMessage.value = result.message;
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoadingMore.value = false;
    }
  }

  void reset() {
    followers.clear();
    _currentPage = 1;
    _lastPage = 1;
    total = 0;
    _targetUserId = null;
    _type = null;
    errorMessage.value = '';
  }
}
