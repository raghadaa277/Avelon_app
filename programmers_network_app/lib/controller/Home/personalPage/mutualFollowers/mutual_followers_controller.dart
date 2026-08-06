import 'package:get/get.dart';
import 'package:programmers_network_app/core/helper/api_error_dialog.dart';
import 'package:programmers_network_app/data/models/Home/personalPage/mutualFollowers/get_connection_analysis_model.dart';
import 'package:programmers_network_app/data/models/Home/personalPage/mutualFollowers/get_mutual_followers_model.dart';
import 'package:programmers_network_app/data/services/Home/personalPage/mutual_services.dart/get_connection_analysis_services.dart';
import 'package:programmers_network_app/data/services/Home/personalPage/mutual_services.dart/get_mutual_followers_services.dart';

class MutualFollowersController extends GetxController {
  final GetMutualFollowersServices mutualFollowersServices =
      GetMutualFollowersServices();

  final RxBool isLoading = false.obs;
  final RxBool isLoadingMore = false.obs;
  final RxString errorMessage = ''.obs;

  final RxList<MutualFollowerUser> mutualFollowers = <MutualFollowerUser>[].obs;

  int currentPage = 1;
  int lastPage = 1;

  bool get hasMore => currentPage < lastPage;

  Future<void> fetchMutualFollowers({required int targetUserId}) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final result = await mutualFollowersServices.mutualFollowers(
        targetUserId: targetUserId,
        page: 1,
      );

      mutualFollowers.assignAll(result.data.users);

      currentPage = result.data.currentPage;
      lastPage = result.data.lastPage;
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst("Exception: ", "");

      ApiErrorDialog.show(errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> loadMore({required int targetUserId}) async {
    if (!hasMore || isLoadingMore.value) return;

    try {
      isLoadingMore.value = true;

      final result = await mutualFollowersServices.mutualFollowers(
        targetUserId: targetUserId,
        page: currentPage + 1,
      );

      mutualFollowers.addAll(result.data.users);

      currentPage = result.data.currentPage;
      lastPage = result.data.lastPage;
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst("Exception: ", "");

      ApiErrorDialog.show(errorMessage.value);
    } finally {
      isLoadingMore.value = false;
    }
  }

  Future<void> refreshMutualFollowers({required int targetUserId}) async {
    mutualFollowers.clear();
    currentPage = 1;
    lastPage = 1;

    await fetchMutualFollowers(targetUserId: targetUserId);
  }

  final GetConnectionAnalysisServices connectionAnalysisServices =
      GetConnectionAnalysisServices();

  final Rxn<GetConnectionAnalysisModel> connectionAnalysis =
      Rxn<GetConnectionAnalysisModel>();

  Future<void> fetchConnectionAnalysis({required int targetUserId}) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      final result = await connectionAnalysisServices.connectionAnalysis(
        targetUserId: targetUserId,
      );

      connectionAnalysis.value = result;
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst("Exception: ", "");

      ApiErrorDialog.show(errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshConnectionAnalysis({required int targetUserId}) async {
    await fetchConnectionAnalysis(targetUserId: targetUserId);
  }
}
