

import '../../data/models/Profile/UserFollowModel.dart';

abstract class FollowState {}

class FollowInitial extends FollowState {}

class FollowLoading extends FollowState {}

class FollowersLoaded extends FollowState {
  final List<UserFollowModel> followers;
  FollowersLoaded(this.followers);
}

class FollowHistoryLoaded extends FollowState {
  final List<UserFollowModel> historyItems;
  final int currentPage;
  final int lastPage;

  FollowHistoryLoaded({
    required this.historyItems,
    required this.currentPage,
    required this.lastPage,
  });
}

class FollowError extends FollowState {
  final String errorMessage;
  FollowError(this.errorMessage);
}