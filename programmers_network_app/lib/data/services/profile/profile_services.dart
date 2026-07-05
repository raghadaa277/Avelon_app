import 'dart:convert';
import 'dart:io';
import 'package:programmers_network_app/core/const/api_Constants.dart';
import 'package:programmers_network_app/core/storage/api_client.dart';
import 'package:programmers_network_app/core/storage/token_storage.dart';
import '../../models/Profile/AvatarActionResponseModel.dart';
import '../../models/Profile/UpdateProfileResponse.dart';
import '../../models/Profile/profile_model.dart';

class ProfileServices {
  final ApiClient profileApi = ApiClient(baseUrl: ApiConstants.baseurl);

  Future<UserProfileModel?> getUserProfile() async {
    final token = await TokenStorage.getToken();
    if (token == null) {
      await TokenStorage.clearTokens();
      return null;
    }

    try {
      final response = await profileApi.get(ApiConstants.userProfile);

      print("📡 PROFILE RESPONSE STATUS => ${response.statusCode}");
      print("📡 PROFILE RESPONSE BODY => ${response.body}");

      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return UserProfileModel.fromJson(decodedResponse);
      } else {
        throw Exception(decodedResponse['message'] ?? 'Failed to load profile');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<UpdateProfileResponseModel?> updateUserProfile({
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
    final token = await TokenStorage.getToken();
    if (token == null) {
      await TokenStorage.clearTokens();
      return null;
    }

    try {
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

      final response = await profileApi.post(
        ApiConstants.updateProfile,
        body: bodyData,
      );

      print("📡 UPDATE PROFILE STATUS => ${response.statusCode}");
      print("📡 UPDATE PROFILE BODY => ${response.body}");

      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return UpdateProfileResponseModel.fromJson(decodedResponse);
      } else {
        throw Exception(
          decodedResponse['message'] ?? 'Failed to update profile',
        );
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<Map<String, dynamic>?> getPrivacySettings() async {
    final token = await TokenStorage.getToken();
    if (token == null) {
      await TokenStorage.clearTokens();
      return null;
    }

    try {
      final response = await profileApi.get(ApiConstants.getPrivacySettings);

      print("📡 GET PRIVACY STATUS => ${response.statusCode}");
      print("📡 GET PRIVACY BODY => ${response.body}");

      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return decodedResponse as Map<String, dynamic>;
      } else {
        throw Exception(
          decodedResponse['message'] ?? 'Failed to load privacy settings',
        );
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<bool> updatePrivacySettings(Map<String, dynamic> bodyData) async {
    try {
      final response = await profileApi.post(
        ApiConstants.updatePrivacySettings,
        body: bodyData,
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = jsonDecode(response.body);
        return data['success'] == true;
      }
      return false;
    } catch (e) {
      print('❌ Exception in updatePrivacySettings: $e');
      return false;
    }
  }

  Future<AvatarActionResponseModel?> updateAvatar(File imageFile) async {
    final token = await TokenStorage.getToken();

    if (token == null) {
      await TokenStorage.clearTokens();
      return null;
    }

    try {
      final response = await profileApi.postMultipart(
        ApiConstants.updateAvatar,
        imageFile,
        'avatar',
      );

      print("📡 UPDATE AVATAR STATUS => ${response.statusCode}");
      print("📡 UPDATE AVATAR BODY => ${response.body}");

      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return AvatarActionResponseModel.fromJson(decodedResponse);
      } else {
        throw Exception(
          decodedResponse['message'] ?? 'Failed to update avatar',
        );
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<AvatarActionResponseModel?> removeAvatar() async {
    final token = await TokenStorage.getToken();

    if (token == null) {
      await TokenStorage.clearTokens();
      return null;
    }

    try {
      final response = await profileApi.post(
        ApiConstants.removeAvatar,
        body: {},
      );

      print("📡 REMOVE AVATAR STATUS => ${response.statusCode}");
      print("📡 REMOVE AVATAR BODY => ${response.body}");

      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return AvatarActionResponseModel.fromJson(decodedResponse);
      } else {
        throw Exception(
          decodedResponse['message'] ?? 'Failed to remove avatar',
        );
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
