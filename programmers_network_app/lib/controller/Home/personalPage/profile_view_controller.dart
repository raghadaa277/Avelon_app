import 'package:get/get.dart';
import 'package:programmers_network_app/data/services/Home/personalPage/profile_view_services.dart';

class ProfileViewController extends GetxController {
  final ProfileViewServices _profileViewServices = ProfileViewServices();

  void recordProfileView(int targetUserId) {
    _profileViewServices.recordProfileVeiw(targetUserId: targetUserId)
    // ignore: body_might_complete_normally_catch_error
    .catchError((e) {
      // ignore: avoid_print
      print('recordProfileView failed silently: $e');
    });
  }
}
