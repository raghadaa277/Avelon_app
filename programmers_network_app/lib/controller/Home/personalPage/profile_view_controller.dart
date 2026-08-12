import 'package:get/get.dart';
import 'package:programmers_network_app/data/services/Home/personalPage/profile_view_services.dart';

class ProfileViewController extends GetxController {
  final ProfileViewServices _profileViewServices = ProfileViewServices();

  Future<void> recordProfileView(int targetUserId) async {
    try {
      await _profileViewServices.recordProfileVeiw(targetUserId: targetUserId);
    } catch (e) {
      print('recordProfileView failed silently: $e');
    }
  }
}
