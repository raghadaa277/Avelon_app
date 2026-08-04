import 'package:get/get.dart';
import 'package:programmers_network_app/data/services/Home/personalPage/user%20Flag/user_flag_services.dart';
import 'package:programmers_network_app/data/models/Home/personalPage/user%20Flag/user_flag_model.dart';

class UserFlagController extends GetxController {
  final UserFlagServices userFlagServices = UserFlagServices();

  final RxBool isLoading = false.obs;

  final RxString errorMessage = ''.obs;

  Future<UserFlagModel?> reportUser({
    required int targetUserId,
    required String reason,
    String? description,
  }) async {
    try {
      isLoading.value = true;

      errorMessage.value = '';

      final result = await userFlagServices.userFlag(
        targetUserId: targetUserId,
        reason: reason,
        description: description,
      );

      return result;
    } catch (e) {
      errorMessage.value = e.toString();

      return null;
    } finally {
      isLoading.value = false;
    }
  }
}
