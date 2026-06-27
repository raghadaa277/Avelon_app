import 'dart:convert';
import '../../data/models/Profile/UpdateProfileResponse.dart';
import '../../data/models/Profile/profile_model.dart';
import '../../data/services/Home/refresh_token_services.dart';
import '../const/api_Constants.dart';

import '../storage/api_client.dart';

class ProfileServices {

  final ApiClient apiClient;

  ProfileServices(this.apiClient);

  Future<UserProfileModel> getUserProfile() async {

    final response = await apiClient.get("/api/get/user/profile");

    print("📡 PROFILE RESPONSE STATUS => ${response.statusCode}");
    print("📡 PROFILE RESPONSE BODY => ${response.body}");
    if (response.statusCode == 410) {
      print("🔄 Session expired (410). Attempting manual refresh token...");


      final bool refreshed = await RefreshTokenService().refreshToken();

      if (refreshed) {
        print("✅ Token refreshed successfully! Re-sending profile request...");


      } else {
        print("❌ Refresh token expired too. User must log in.");
        throw Exception('Session expired completely. Please login again.');
      }
    }
    if (response.statusCode == 200) {
      return UserProfileModel.fromJson(jsonDecode(response.body));
    } else {
      throw Exception(
        'Failed to load profile: ${response.statusCode} - ${response.body}',
      );
    }
  }

  Future<UpdateProfileResponseModel> updateUserProfile({
    required String fullName,
    required String username,
    required String specialization,
    required String bio,
    required String city,
    required String country,
    required String educationStatus,
    required String university,
    required String? major,
    required String studyYear,
    required String jobTitle,
    required String? company,
    required int experienceYears,
    required String? githubUrl,
    required String? linkedinUrl,
  }) async {
    final Map<String, dynamic> bodyData = {
      'full_name': fullName,
      'username': username,
      'specialization': specialization,
      'bio': bio,
      'city': city,
      'country': country,
      'education_status': educationStatus,
      'university': university,
      'major': major,
      'study_year': studyYear,
      'job_title': jobTitle,
      'company': company,
      'experience_years': experienceYears,
      'github_url': githubUrl,
      'linkedin_url': linkedinUrl,
    };


    final response = await apiClient.post(
      "/api/update/user/profile",
      body: bodyData,
    );

    print("📡 UPDATE PROFILE STATUS => ${response.statusCode}");
    print("📡 UPDATE PROFILE BODY => ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      final jsonResponse = jsonDecode(response.body);
      return UpdateProfileResponseModel.fromJson(jsonResponse);
    } else {
      throw Exception(
        'Failed to update profile: ${response.statusCode} - ${response.body}',
      );
    }
  }
}