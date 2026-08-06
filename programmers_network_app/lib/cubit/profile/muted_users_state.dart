

import '../../data/models/Profile/muted_user_model.dart';

abstract class MutedUsersState {}

class MutedUsersInitial extends MutedUsersState {}


class MutedUsersLoading extends MutedUsersState {}
class MutedUsersLoaded extends MutedUsersState {
  final List<MutedUserModel> users;
  MutedUsersLoaded(this.users);
}


class MutedHistoryLoading extends MutedUsersState {}
class MutedHistoryLoaded extends MutedUsersState {
  final List<MutedUserModel> historyItems;
  final int lastPage;
  final int currentPage;

  MutedHistoryLoaded({
    required this.historyItems,
    required this.lastPage,
    required this.currentPage,
  });
}


class MutedUsersError extends MutedUsersState {
  final String message;
  MutedUsersError(this.message);
}


class ToggleMuteLoading extends MutedUsersState {
  final int userId;
  ToggleMuteLoading(this.userId);
}
class ToggleMuteSuccess extends MutedUsersState {
  final int userId;
  ToggleMuteSuccess(this.userId);
}