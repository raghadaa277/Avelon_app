import 'package:programmers_network_app/data/services/auth/logout_services.dart';

import 'package:get/get.dart';
import 'package:programmers_network_app/core/const/routesPage.dart';
import 'package:programmers_network_app/core/storage/token_storage.dart';

class LogoutController extends GetxController {
  final LogoutServices logoutServices = LogoutServices();

  var isLoading = false.obs;

  Future<void> logout() async {
    try {
      isLoading.value = true;

      final result = await logoutServices.logout();

      if (result != null && result.success) {
        await TokenStorage.clearTokens();

        Get.offAllNamed(AppRoute.login);

        Get.snackbar("Success", result.message);
      } else {
        Get.snackbar("Error", "Logout failed");
      }
    } catch (e) {
      Get.snackbar("Error", e.toString());
    } finally {
      isLoading.value = false;
    }
  }
}
