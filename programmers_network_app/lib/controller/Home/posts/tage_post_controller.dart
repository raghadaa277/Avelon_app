import 'package:get/get.dart';
import 'package:programmers_network_app/data/models/Home/posts/tage_post_model.dart';
import 'package:programmers_network_app/data/services/Home/posts/tage_post_services.dart';

class TagePostController extends GetxController {
  final TagePostServices _tagePostServices = TagePostServices();

  bool isLoading = false;
  String? errorMessage;

  TagePostModel? tagePostModel;

  Future<void> getTags() async {
    try {
      isLoading = true;
      errorMessage = null;
      update();

      tagePostModel = await _tagePostServices.getTage();
    } catch (e) {
      errorMessage = e.toString().replaceFirst("Exception: ", "");
    } finally {
      isLoading = false;
      update();
    }
  }

  @override
  void onInit() {
    super.onInit();
    getTags();
  }
}
