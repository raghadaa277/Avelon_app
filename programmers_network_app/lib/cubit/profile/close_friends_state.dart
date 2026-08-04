import '../../data/models/Profile/close_friend_model.dart';

abstract class CloseFriendsState {}

class CloseFriendsInitial extends CloseFriendsState {}

class CloseFriendsLoading extends CloseFriendsState {}

class CloseFriendsLoaded extends CloseFriendsState {
  final List<CloseFriendModel> closeFriends;
  CloseFriendsLoaded(this.closeFriends);
}

class CloseFriendsHistoryLoaded extends CloseFriendsState {
  final List historyItems;
  CloseFriendsHistoryLoaded(this.historyItems);
}

class CloseFriendsError extends CloseFriendsState {
  final String errorMessage;
  CloseFriendsError(this.errorMessage);
}