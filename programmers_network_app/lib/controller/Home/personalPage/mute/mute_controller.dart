import 'package:get/get.dart';
import 'package:programmers_network_app/core/helper/api_error_dialog.dart';
import 'package:programmers_network_app/data/services/Home/personalPage/mute/mute_services.dart';

enum MuteAction { muted, unmuted }

class MuteController extends GetxController {
  final MuteServices muteServices = MuteServices();

  final RxBool isLoading = false.obs;

  final RxString errorMessage = ''.obs;

  final RxBool isMuted = false.obs;

  void setMuteStatus(bool value) {
    isMuted.value = value;
  }

  Future<MuteAction?> toggleMute({
    required int targetUserId,

    required bool currentState,
  }) async {
    try {
      isLoading.value = true;

      errorMessage.value = '';

      final result = await muteServices.toggleMute(targetUserId: targetUserId);

      if (result.success) {
        final newState = !currentState;

        isMuted.value = newState;

        return newState ? MuteAction.muted : MuteAction.unmuted;
      }

      Get.snackbar("Error", result.message);

      return null;
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst("Exception: ", "");

      ApiErrorDialog.show(errorMessage.value);

      return null;
    } finally {
      isLoading.value = false;
    }
  }
}
