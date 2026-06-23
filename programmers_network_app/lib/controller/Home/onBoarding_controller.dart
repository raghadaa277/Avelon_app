import 'package:get/get.dart';
import 'package:programmers_network_app/core/const/routesPage.dart';
import 'package:programmers_network_app/data/models/Home/OnBoarding/complete_model.dart';
import 'package:programmers_network_app/data/models/Home/OnBoarding/onboarding_model.dart';
import 'package:programmers_network_app/data/services/Home/onBording_services.dart';

class OnboardingController extends GetxController {
  final OnbordingServices onbordingServices = OnbordingServices();

  bool isLoading = false;
  String? errorMessage;

  OnboardingModel? onboardingModel;
  CompleteModel? completeModel;

  Future<void> getOnBoarding() async {
    try {
      isLoading = true;
      errorMessage = null;
      update();

      onboardingModel = await onbordingServices.getOnBoarding();
    } catch (e) {
      Get.snackbar("Error", onboardingModel?.message ?? "Error");
    } finally {
      isLoading = false;
      update();
    }
  }

  Future<void> completeOnboarding({
    required List<String> sources,
    required List<String> goals,
    required List<String> inspirations,
    required List<Map<String, dynamic>> tags,
  }) async {
    try {
      isLoading = true;
      update();

      completeModel = await onbordingServices.completeOnboarding(
        sources: sources,
        goals: goals,
        inspirations: inspirations,
        tags: tags,
      );

      Get.snackbar("Success", completeModel?.message ?? "Success");

      Get.offAllNamed(AppRoute.readyPage);
    } catch (e) {
      Get.snackbar("Error", completeModel?.message ?? "Error");
    } finally {
      isLoading = false;
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    getOnBoarding();
  }
}
