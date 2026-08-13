import 'package:get/get.dart';

import 'package:programmers_network_app/data/models/Home/suggestions/get_suggestions_model.dart';
import 'package:programmers_network_app/data/services/Home/suggestions/suggestions_services.dart';

class SuggestionsController extends GetxController {
  final SuggestionsServices services = SuggestionsServices();

  final RxBool isLoading = false.obs;
  final RxBool isLoadingMore = false.obs;

  final RxSet<int> ignoringIds = <int>{}.obs;
  final RxSet<int> viewingId = <int>{}.obs;

  final RxString errorMessage = ''.obs;

  final RxList<SuggestionModel> suggestions = <SuggestionModel>[].obs;

  int currentPage = 1;
  int lastPage = 1;

  @override
  void onInit() {
    super.onInit();
    getSuggestions();
  }

  Future<void> getSuggestions({bool isLoadMore = false}) async {
    if (isLoadMore) {
      if (isLoadingMore.value || currentPage >= lastPage) {
        return;
      }

      isLoadingMore.value = true;
    } else {
      if (isLoading.value) return;

      isLoading.value = true;
      errorMessage.value = '';
    }

    try {
      final int page = isLoadMore ? currentPage + 1 : 1;

      final response = await services.getSuggestions(page: page);

      if (isLoadMore) {
        suggestions.addAll(response.data.suggestions);
      } else {
        suggestions.assignAll(response.data.suggestions);
      }

      currentPage = response.data.currentPage;
      lastPage = response.data.lastPage;
    } catch (e) {
      print('Suggestions Controller Error: $e');

      if (!isLoadMore) {
        errorMessage.value = e.toString();
      }
    } finally {
      if (isLoadMore) {
        isLoadingMore.value = false;
      } else {
        isLoading.value = false;
      }
    }
  }

  Future<void> loadMore() async {
    if (isLoadingMore.value) return;

    if (currentPage >= lastPage) return;

    await getSuggestions(isLoadMore: true);
  }

  Future<void> refreshSuggestions() async {
    if (isLoading.value) return;

    currentPage = 1;
    lastPage = 1;

    errorMessage.value = '';

    await getSuggestions();
  }

  Future<bool> ignoreSuggestion({required int id}) async {
    if (ignoringIds.contains(id) || viewingId.contains(id)) {
      return false;
    }

    ignoringIds.add(id);
    viewingId.add(id);

    try {
      final result = await services.ignoreSuggestions(id: id);

      if (result.success) {
        final index = suggestions.indexWhere(
          (suggestion) => suggestion.id == id,
        );

        if (index != -1) {
          final ignoredSuggestion = suggestions.removeAt(index);

          suggestions.add(ignoredSuggestion);
        }

        return true;
      }

      errorMessage.value = result.message;

      return false;
    } catch (e) {
      print('Ignore Suggestion Controller Error: $e');

      errorMessage.value = e.toString();

      return false;
    } finally {
      ignoringIds.remove(id);
      viewingId.remove(id);
    }
  }

  bool isIgnoring(int id) {
    return ignoringIds.contains(id);
  }

  bool isViewing(int id) {
    return viewingId.contains(id);
  }
}
