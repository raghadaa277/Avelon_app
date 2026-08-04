import 'package:get/get.dart';
import 'package:programmers_network_app/data/models/Home/personalPage/closeFriends/get_my_close_friends_model.dart';
import 'package:programmers_network_app/data/services/Home/personalPage/closeFreinds/close_friend_services.dart';

enum CloseFriendAction { added, removed }

class CloseFriendsController extends GetxController {
  final CloseFriendServices closeFriendServices = CloseFriendServices();

  final RxBool isLoading = false.obs;

  final RxBool isLoadingList = false.obs;

  final RxString errorMessage = ''.obs;

  final RxBool isCloseFriend = false.obs;

  final RxList<CloseFriendUser> closeFriends = <CloseFriendUser>[].obs;

  int currentPage = 1;

  int lastPage = 1;

  @override
  void onInit() {
    super.onInit();
  }

  void setCloseFriend(bool value) {
    isCloseFriend.value = value;
  }

  Future<void> fetchCloseFriends() async {
    try {
      isLoadingList.value = true;

      errorMessage.value = '';

      final result = await closeFriendServices.getCloseFriends();

      if (result.success) {
        closeFriends.assignAll(result.data.users);

        currentPage = result.data.currentPage;

        lastPage = result.data.lastPage;
      } else {
        errorMessage.value = result.message;
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoadingList.value = false;
    }
  }

  Future<CloseFriendAction?> toggleCloseFriend({
    required int targetUserId,

    required bool currentState,
  }) async {
    try {
      isLoading.value = true;

      errorMessage.value = '';

      final result = await closeFriendServices.toggleCloseFriends(
        targetUserId: targetUserId,
      );

      if (result.success) {
        final newState = !currentState;

        isCloseFriend.value = newState;

        if (newState) {
          await fetchCloseFriends();
        } else {
          closeFriends.removeWhere((user) => user.id == targetUserId);
        }

        return newState ? CloseFriendAction.added : CloseFriendAction.removed;
      }
      return null;
    } catch (e) {
      errorMessage.value = e.toString();

      return null;
    } finally {
      isLoading.value = false;
    }
  }
}
