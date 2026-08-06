import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/Profile/UserFollowModel.dart';
import '../../data/services/profile/FollowService.dart';
import 'follow_state.dart';

class FollowCubit extends Cubit<FollowState> {
  final FollowService followService;

  FollowCubit(this.followService) : super(FollowInitial());

  List<UserFollowModel> _historyList = [];
  int _currentPage = 1;
  int _lastPage = 1;


  Future<void> fetchFollowers(int userId) async {
    emit(FollowLoading());
    try {
      final followers = await followService.getFollowers(userId);
      emit(FollowersLoaded(followers));
    } catch (e) {
      emit(FollowError(e.toString()));
    }
  }


  Future<void> toggleFollow(int userId, {int? currentProfileUserId}) async {
    try {
      final success = await followService.toggleFollow(userId);
      if (success && currentProfileUserId != null) {
        fetchFollowers(currentProfileUserId);
      }
    } catch (e) {
      emit(FollowError(e.toString()));
    }
  }


  Future<void> fetchFollowHistory({required String type, bool isLoadMore = false}) async {
    if (isLoadMore) {
      if (_currentPage >= _lastPage) return;
      _currentPage++;
    } else {
      _currentPage = 1;
      _historyList.clear();
      emit(FollowLoading());
    }

    try {
      final result = await followService.getFollowHistory(type: type, page: _currentPage);
      final List<UserFollowModel> items = result['items'];
      _lastPage = result['lastPage'];

      _historyList.addAll(items);

      emit(FollowHistoryLoaded(
        historyItems: List.from(_historyList),
        currentPage: _currentPage,
        lastPage: _lastPage,
      ));
    } catch (e) {
      emit(FollowError(e.toString()));
    }
  }
}