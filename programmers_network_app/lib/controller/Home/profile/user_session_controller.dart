import 'package:get/get.dart';
import 'package:programmers_network_app/data/models/Profile/user_sessions/get_user_daily_model.dart';
import 'package:programmers_network_app/data/services/profile/user_session_services.dart';

class UserSessionController extends GetxController {
  final UserSessionServices _userSessionServices = UserSessionServices();

  bool isLoading = false;

  UserDailyUsageModel? dailyUsageModel;

  Future<void> startSession() async {
    try {
      isLoading = true;
      update();
      final result = await _userSessionServices.startSession();
      if (result != null && result.success) {}
    } catch (e) {
      // Get.snackbar("Error", e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> endSession() async {
    try {
      isLoading = true;
      update();
      final result = await _userSessionServices.endSession();
      if (result != null && result.success) {}
    } catch (e) {
      // Get.snackbar("Error", e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> getUserDaily(String filter, {String? customDate}) async {
    try {
      isLoading = true;
      update();

      final result = await _userSessionServices.getUserDailyUsage(
        filter,
        customDate: customDate,
      );

      if (result != null && result.success) {
        dailyUsageModel = result;
      } else {
        // Get.snackbar("Error", result?.message ?? 'Unknown error');
      }
    } catch (e) {
      // Get.snackbar("Error", e.toString());
    } finally {
      isLoading = false;
      update();
    }
  }
}
