import 'package:get/get.dart';
import 'package:programmers_network_app/data/models/Home/get_time_line_model.dart';
import 'package:programmers_network_app/data/services/Home/get_time_line_service.dart';

class GetTimeLineController extends GetxController {
  final GetTimeLineService _timeLineService = GetTimeLineService();

  final RxString errorMessage = ''.obs;
  bool isLoading = false;
  List<DataTimeLine> data = [];

  Future<void> getTimeLine() async {
    if (isLoading) return;

    try {
      isLoading = true;
      errorMessage.value = '';
      update();

      final result = await _timeLineService.getTimeLine();
      if (result.success) {
        data = result.data;
      } else {
        errorMessage.value = result.message;
      }
    } catch (e) {
      errorMessage.value = e.toString();
    } finally {
      isLoading = false;
      update();
    }
  }
}
