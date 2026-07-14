import 'package:get/state_manager.dart';
import 'package:programmers_network_app/data/models/Home/search_model.dart';
import 'package:programmers_network_app/data/services/Home/search_services.dart';

class SearchPageController extends GetxController {
  final SearchServices _searchServices = SearchServices();

  List<SearchUserModel> users = [];
  bool isSearching = false;

  final RxString errorMessage = ''.obs;

  bool isLoading = false;
  bool isLoadingMore = false;

  int currentPage = 1;
  int lastPage = 1;

  String? currentType;
  String? currentSearch;

  Future<void> search({
    required String user,
    required String search,
    bool refresh = true,
  }) async {
    if (refresh) {
      currentPage = 1;
      users.clear();
    }
    if (isLoading) return;

    isLoading = true;
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
    if (isLoadingMore) return;

    if (currentPage >= lastPage) return;

    isLoadingMore = true;
    update();

    try {
      currentPage++;

      final result = await _searchServices.search(
        user: currentType!,
        search: currentSearch!,
        page: currentPage,
      );

      if (result.success) {
        users.addAll(result.data.users);
      }
    } catch (e) {
      currentPage--;
    } finally {
      isLoadingMore = false;
      update();
    }
  }
}
