import 'package:get/get.dart';

import 'package:programmers_network_app/data/models/Home/search_post_model.dart';
import 'package:programmers_network_app/data/services/Home/get_activites_services.dart';

class GetActivitiesController extends GetxController {
  final GetActivitesServices services = GetActivitesServices();

  final RxBool isLoading = false.obs;
  final RxBool isLoadingMore = false.obs;
  final RxString errorMessage = ''.obs;

  final RxList<Post> posts = <Post>[].obs;

  int currentPage = 1;
  int lastPage = 1;

  final String type;

  GetActivitiesController({required this.type});

  @override
  void onInit() {
    super.onInit();

    getActivities();
  }

  Future<void> getActivities({bool isLoadMore = false}) async {
    if (isLoadMore) {
      if (isLoadingMore.value) return;

      if (currentPage >= lastPage) return;

      isLoadingMore.value = true;
    } else {
      if (isLoading.value) return;

      isLoading.value = true;
      errorMessage.value = '';
    }

    try {
      final int page = isLoadMore ? currentPage + 1 : 1;

      final response = await services.getActivites(type: type, page: page);

      if (isLoadMore) {
        posts.addAll(response.data.posts);
      } else {
        posts.assignAll(response.data.posts);
      }

      currentPage = response.data.currentPage;
      lastPage = response.data.lastPage;
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading.value = false;
      isLoadingMore.value = false;
    }
  }

  Future<void> loadMore() async {
    if (isLoadingMore.value) return;

    if (currentPage >= lastPage) return;

    await getActivities(isLoadMore: true);
  }

  Future<void> refreshActivities() async {
    currentPage = 1;
    lastPage = 1;

    await getActivities();
  }
}
