import 'dart:convert';
import 'package:http/http.dart' as http;

import '../../data/models/Profile/UpdateProfileResponse.dart';
import '../../data/models/Profile/profile_model.dart';

import '../const/api_Constants.dart';
import '../storage/token_storage.dart';

class ProfileServices {
  Future<UserProfileModel> getUserProfile() async {
    final url = Uri.parse(ApiConstants.userProfile);

    final token = await TokenStorage.getToken();
    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );
    print("📡 PROFILE RESPONSE STATUS => ${response.statusCode}");
    print("📡 PROFILE RESPONSE BODY => ${response.body}");
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
    //required int profilecompletion,
  }) async {
    final url = Uri.parse(ApiConstants.updateProfile);
    final token = await TokenStorage.getToken();

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
      //'profile_completion':profilecompletion,
    };

    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
      body: jsonEncode(bodyData),
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

  Future<Map<String, dynamic>> getPrivacySettings() async {

    final url = Uri.parse(ApiConstants.getPrivacySettings);
    final token = await TokenStorage.getToken();

    final response = await http.get(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
    );

    print("📡 GET PRIVACY STATUS => ${response.statusCode}");
    print("📡 GET PRIVACY BODY => ${response.body}");

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception(
        'Failed to load privacy settings: ${response.statusCode} - ${response.body}',
      );
    }
  }


  Future<bool> updatePrivacySettings(Map<String, dynamic> settingsJson) async {
    final url = Uri.parse(ApiConstants.updatePrivacySettings);
    final token = await TokenStorage.getToken();

    final response = await http.post(
      url,
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
      body: jsonEncode(settingsJson),
    );

    print("📡 UPDATE PRIVACY STATUS => ${response.statusCode}");
    print("📡 UPDATE PRIVACY BODY => ${response.body}");

    if (response.statusCode == 200 || response.statusCode == 201) {
      return true;
    } else {
      throw Exception(
        'Failed to update privacy settings: ${response.statusCode} - ${response.body}',
      );
    }
  }
}
