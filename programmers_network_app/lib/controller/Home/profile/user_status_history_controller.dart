import 'package:get/get.dart';
import 'package:programmers_network_app/data/models/Profile/user_status_history_model.dart';
import 'package:programmers_network_app/data/services/profile/user_status_history_services.dart';

class UserStatusHistoryController extends GetxController {
  final UserStatusHistoryServices _userStatusHistoryServices =
      UserStatusHistoryServices();

  bool isLoading = false;
  String? errorMessage;

  UserStatusHistoryModel? userStatusHistoryModel;

  Future<void> getUserStatus() async {
    try {
      isLoading = true;
      errorMessage = null;
      update();

      final result = await _userStatusHistoryServices.getUserStatus();

      if (result != null && result.success) {
        userStatusHistoryModel = result;
      } else {
        errorMessage = result?.message;
      }
    } catch (e) {
      errorMessage = e.toString();
    } finally {
      isLoading = false;
      update();
    }
  }
}
