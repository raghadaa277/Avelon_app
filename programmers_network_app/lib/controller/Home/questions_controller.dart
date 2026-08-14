import 'package:get/get.dart';
import 'package:programmers_network_app/data/services/Home/personalPage/question/questions_services.dart';

class QuestionsController extends GetxController {
  final QuestionsServices _questionsServices = QuestionsServices();

  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxString successMessage = ''.obs;

  Future<bool> createQuestion({
    required int targetUserId,
    required String type,
    required String question,
    required String title,
  }) async {
    try {
      isLoading.value = true;
      errorMessage.value = '';
      successMessage.value = '';

      final result = await _questionsServices.createQuestion(
        targetUserId: targetUserId,
        type: type,
        question: question,
        title: title,
      );

      if (result.success) {
        successMessage.value = result.message;
        return true;
      }

      errorMessage.value = result.message;
      return false;
    } catch (e) {
      errorMessage.value = e.toString();
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
