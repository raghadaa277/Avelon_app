import 'package:get/get.dart';
import 'package:programmers_network_app/data/services/profile/start_user_session_services.dart';

class UserSessionController extends GetxController {
  final UserSessionServices _startUserSessionServices = UserSessionServices();

  bool isLoading = false;

  Future<void> startSession() async {
    try {
      isLoading = true;
      update();

      final result = await _startUserSessionServices.startSession();

      if (result != null && result.success) {
        Get.snackbar("Success", result.message);
        print("Session started successfully");
      } else {
        Get.snackbar("Error", result!.message);
        print("Session start failed");
      }
    } catch (e) {
      print("Error starting session: $e");
    } finally {
      isLoading = false;
      update();
    }
  }
}
