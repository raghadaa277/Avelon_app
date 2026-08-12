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

  bool isLoadingMore = false;

  String currentHistoryType = 'sent';

  Future<void> fetchMutedUsers() async {
    if (isClosed) return;

    emit(MutedUsersLoading());

    try {
      final users = await mutedUsersService.getMutedUsers();

      if (isClosed) return;

      currentMutedUsers = users;

      emit(MutedUsersLoaded(users));
    } catch (e) {
      if (isClosed) return;

      emit(MutedUsersError(e.toString()));
    }
  }

  Future<void> fetchMutedHistory({required String type, int page = 1}) async {
    if (isClosed) return;

    if (type != currentHistoryType) {
      currentHistoryType = type;

      currentPage = 1;
      lastPage = 1;

      historyList.clear();

      page = 1;
    }

    if (page > 1 && isLoadingMore) {
      return;
    }

    if (page > lastPage) {
      return;
    }

    if (page == 1) {
      historyList.clear();

      currentPage = 1;
      lastPage = 1;

      emit(MutedHistoryLoading());
    } else {
      isLoadingMore = true;
    }

    try {
      final result = await mutedUsersService.getMutedUserHistory(
        type: type,
        page: page,
      );

      if (isClosed) return;

      final List<MutedUserModel> newItems = List<MutedUserModel>.from(
        result['items'] ?? [],
      );

      currentPage = result['currentPage'] ?? page;

      lastPage = result['lastPage'] ?? 1;

      historyList.addAll(newItems);

      emit(
        MutedHistoryLoaded(
          historyItems: List.from(historyList),
          lastPage: lastPage,
          currentPage: currentPage,
        ),
      );
    } catch (e) {
      if (isClosed) return;

      emit(MutedUsersError(e.toString()));
    } finally {
      isLoadingMore = false;
    }
  }

  Future<void> loadMoreHistory() async {
    if (isClosed) return;

    if (isLoadingMore) return;

    if (currentPage >= lastPage) return;

    await fetchMutedHistory(type: currentHistoryType, page: currentPage + 1);
  }
}
