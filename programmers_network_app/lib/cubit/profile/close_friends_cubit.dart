import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/services/profile/close_friends_service.dart';
import 'close_friends_state.dart';

class CloseFriendsCubit extends Cubit<CloseFriendsState> {
  final CloseFriendsService closeFriendsService;

  CloseFriendsCubit(this.closeFriendsService) : super(CloseFriendsInitial());


  Future<void> fetchCloseFriends() async {
    emit(CloseFriendsLoading());
    try {
      final friends = await closeFriendsService.getCloseFriends();
      emit(CloseFriendsLoaded(friends));
    } catch (e) {
      emit(CloseFriendsError(e.toString()));
    }
  }


  Future<void> toggleCloseFriend(int userId) async {
    try {
      final success = await closeFriendsService.toggleCloseFriend(userId);
      if (success) {
        await fetchCloseFriends();
      }
    } catch (e) {
      emit(CloseFriendsError(e.toString()));
    }
  }


  int currentHistoryPage = 1;
  int lastHistoryPage = 1;
  List historyList = [];
  bool isLoadingMoreHistory = false;

  Future<void> fetchHistory({int page = 1}) async {
    if (page == 1) {
      emit(CloseFriendsLoading());
      historyList.clear();
      currentHistoryPage = 1;
    }

    try {

      final result = await closeFriendsService.getCloseFriendsHistory(page: page);

      final newItems = result['items'] ?? [];
      lastHistoryPage = result['lastPage'] ?? 1;

      if (page == 1) {
        historyList = List.from(newItems);
      } else {
        historyList.addAll(newItems);
      }

      currentHistoryPage = page;
      emit(CloseFriendsHistoryLoaded(List.from(historyList)));
    } catch (e) {
      emit(CloseFriendsError(e.toString()));
    }
  }


  Future<void> loadMoreHistory() async {
    if (isLoadingMoreHistory || currentHistoryPage >= lastHistoryPage) return;

    isLoadingMoreHistory = true;
    await fetchHistory(page: currentHistoryPage + 1);
    isLoadingMoreHistory = false;
  }
}