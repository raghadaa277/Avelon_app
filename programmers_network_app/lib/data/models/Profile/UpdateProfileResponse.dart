import 'profile_model.dart';

class UpdateProfileResponseModel {
  final bool success;
  final String message;
  final ProfileData userProfile;
  final String profileCompletion;

  UpdateProfileResponseModel({
    required this.success,
    required this.message,
    required this.userProfile,
    required this.profileCompletion,
  });

  factory UpdateProfileResponseModel.fromJson(Map<String, dynamic> json) {
    return UpdateProfileResponseModel(
      success: json['success'] ?? false,
      message: json['message'] ?? '',
      userProfile: ProfileData.fromJson(json['data']?['user_profile'] ?? {}),
      profileCompletion: json['data']?['profile_completion'] ?? '0%',
    );
  }
}