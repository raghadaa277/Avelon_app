import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:programmers_network_app/core/helper/api_error_dialog.dart';
import 'package:programmers_network_app/data/models/Home/personalPage/get_target_user_skills_model.dart';
import 'package:programmers_network_app/data/services/Home/personalPage/get_target_user_skills_services.dart';

class GetTargetUserSkillsController extends GetxController {
  final GetTargetUserSkillsServices _services = GetTargetUserSkillsServices();

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;

  final RxList<UserSkill> userSkills = <UserSkill>[].obs;

  Future<void> getSkills({required int targetUserId}) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      final result = await _services.getSkills(targetUserId: targetUserId);
      if (result.success) {
        userSkills.value = result.data.skills;
      } else {
        errorMessage.value = result.message;
      }
    } catch (e) {
      errorMessage.value = e.toString().replaceFirst("Exception: ", "");
      ApiErrorDialog.show(errorMessage.value);
    } finally {
      isLoading.value = false;
    }
  }
}
