import 'package:get/get.dart';
import 'package:programmers_network_app/data/models/Home/personalPage/get_other_user_profile_model.dart';
import 'package:programmers_network_app/data/models/Home/personalPage/get_target_user_count_model.dart';
import 'package:programmers_network_app/data/services/Home/personalPage/get_target_user_count_services.dart';

class GetTargetUserCountController extends GetxController {
  final GetTargetUserCountServices _services = GetTargetUserCountServices();

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  final Rx<CountsModel?> counts = Rx<CountsModel?>(null);

  final Rx<DataOtherUserProfile?> userProfile = Rx<DataOtherUserProfile?>(null);

  String get avatarFullUrl => userProfile.value?.avatarFullUrl ?? '';

  String get fullName => userProfile.value?.fullName ?? '';

  String? get username => userProfile.value?.username;

  String? get specialization => userProfile.value?.specialization;

  String? get city => userProfile.value?.city;

  String? get country => userProfile.value?.country;

  String? get bio => userProfile.value?.bio;

  int get postsCount => counts.value?.postsCount ?? 0;

  int get followersCount => counts.value?.followersCount ?? 0;

  int get followingsCount => counts.value?.followingsCount ?? 0;

  bool get isClosed => userProfile.value?.isCloseFriend ?? false;

  Future<void> fetchTargetUserCount({required int targetUserId}) async {
    try {
      final result = await _services.getTargetUserCount(
        targetUserId: targetUserId,
      );

      if (result.success) {
        counts.value = result.data.counts;
      }
    } catch (e) {
      errorMessage.value = e.toString();
    }
  }

  Future<void> fetchOtherUserProfile({required int targetUserId}) async {
    try {
      isLoading.value = true;

      final result = await _services.getOtherUserProfile(
        targetUserId: targetUserId,
      );

      if (result.success) {
        userProfile.value = result.data;
      } else {
        errorMessage.value = result.message;
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
    }
  }

  void increaseFollowersCount() {
    if (counts.value == null) return;

    counts.value = counts.value!.copyWith(
      followersCount: counts.value!.followersCount + 1,
    );
  }

  void decreaseFollowersCount() {
    if (counts.value == null) return;

    counts.value = counts.value!.copyWith(
      followersCount: counts.value!.followersCount > 0
          ? counts.value!.followersCount - 1
          : 0,
    );
  }

  void setCloseFriend(bool value) {
    if (userProfile.value == null) return;

    userProfile.value = userProfile.value!.copyWith(isCloseFriend: value);
  }

  void setFollowStatus(String value) {
    if (userProfile.value == null) return;

    userProfile.value = userProfile.value!.copyWith(followStatus: value);
  }
}
