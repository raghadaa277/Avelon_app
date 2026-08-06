import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/Profile/muted_user_model.dart';
import '../../data/services/profile/MutedUsersService.dart';
import 'muted_users_state.dart';

class MutedUsersCubit extends Cubit<MutedUsersState> {
  final MutedUsersService mutedUsersService;

  MutedUsersCubit(this.mutedUsersService) : super(MutedUsersInitial());

  List<MutedUserModel> currentMutedUsers = [];
  List<MutedUserModel> historyList = [];
  int currentPage = 1;
  int lastPage = 1;


  Future<void> fetchMutedUsers() async {
    emit(MutedUsersLoading());
    try {
      final users = await mutedUsersService.getMutedUsers();
      currentMutedUsers = users;
      emit(MutedUsersLoaded(users));
    } catch (e) {
      emit(MutedUsersError(e.toString()));
    }
  }


  Future<void> fetchMutedHistory({required String type, int page = 1}) async {
    if (page == 1) {
      historyList.clear();
      emit(MutedHistoryLoading());
    }

    try {
      final result = await mutedUsersService.getMutedUserHistory(type: type, page: page);
      final List<MutedUserModel> newItems = result['items'];

      currentPage = page;
      lastPage = result['lastPage'];
      historyList.addAll(newItems);

      emit(MutedHistoryLoaded(
        historyItems: List.from(historyList),
        lastPage: lastPage,
        currentPage: currentPage,
      ));
    } catch (e) {
      emit(MutedUsersError(e.toString()));
    }
  }


  Future<void> toggleMuteUser(int userId) async {
    emit(ToggleMuteLoading(userId));
    try {
      final success = await mutedUsersService.toggleMuteUser(userId);
      if (success) {

        currentMutedUsers.removeWhere((user) => user.id == userId);
        emit(ToggleMuteSuccess(userId));
        emit(MutedUsersLoaded(List.from(currentMutedUsers)));
      }
    } catch (e) {
      emit(MutedUsersError(e.toString()));
    }
  }
}