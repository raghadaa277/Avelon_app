import 'package:get/get.dart';

import 'package:programmers_network_app/data/services/Home/home_page_services.dart';
import 'package:programmers_network_app/data/services/Home/personalPage/profile_view_services.dart';
import 'package:programmers_network_app/data/services/Home/suggestions/suggestions_services.dart';

class ProfileViewController extends GetxController {
  final ProfileViewServices _profileViewServices = ProfileViewServices();

  final HomePageServices _homePageServices = HomePageServices();

  final SuggestionsServices _suggestionsServices = SuggestionsServices();

  final Set<int> seenFeedIds = {};

  final Set<int> viewedSuggestionIds = {};

  Future<void> recordProfileView(int targetUserId) async {
    try {
      await _profileViewServices.recordProfileVeiw(targetUserId: targetUserId);
    } catch (e) {
      print('recordProfileView failed silently: $e');
    }
  }

  Future<void> feedSeen(int feedId) async {
    if (seenFeedIds.contains(feedId)) {
      return;
    }

    seenFeedIds.add(feedId);

    try {
      await _homePageServices.feedSeen(feedId: feedId);
    } catch (e) {
      seenFeedIds.remove(feedId);

      print('feedSeen failed silently: $e');
    }
  }

  Future<void> suggestionsView(int suggestionId) async {
    if (viewedSuggestionIds.contains(suggestionId)) {
      return;
    }

    viewedSuggestionIds.add(suggestionId);

    try {
      await _suggestionsServices.suggestionsView(id: suggestionId);
    } catch (e) {
      viewedSuggestionIds.remove(suggestionId);
      print('suggestionsView failed silently: $e');
    }
  }
}
