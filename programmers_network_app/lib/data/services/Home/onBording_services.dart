import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:programmers_network_app/core/const/api_constants.dart';
import 'package:programmers_network_app/core/storage/token_storage.dart';
import 'package:programmers_network_app/data/models/Home/OnBoarding/complete_model.dart';
import 'package:programmers_network_app/data/models/Home/OnBoarding/onboarding_model.dart';

class OnbordingServices {
  final Uri onboardingUrl = Uri.parse(
    ApiConstants.baseurl + ApiConstants.onboarding,
  );

  final Uri completeOnBoradingUrl = Uri.parse(
    ApiConstants.baseurl + ApiConstants.complete,
  );

  Future<OnboardingModel> getOnBoarding() async {
    try {
      final token = await TokenStorage.getToken();
      final response = await http.get(
        onboardingUrl,
        headers: {
          "Accept": "application/json",
          "Authorization": "Bearer $token",
        },
      );
      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return OnboardingModel.fromJson(decodedResponse);
      }
      throw Exception(decodedResponse['message'] ?? 'Onboarding failed');
    } catch (e) {
      throw Exception('Onboarding error: $e');
    }
  }

  Future<CompleteModel> completeOnboarding({
    required List<String> sources,
    required List<String> goals,
    required List<String> inspirations,
    required List<Map<String, dynamic>> tags,
  }) async {
    final token = await TokenStorage.getToken();

    final Map<String, String> body = {};

    for (int i = 0; i < sources.length; i++) {
      body['sources[$i][name]'] = sources[i];
    }

    for (int i = 0; i < goals.length; i++) {
      body['goals[$i][name]'] = goals[i];
    }

    for (int i = 0; i < inspirations.length; i++) {
      body['inspiration_sources[$i][name]'] = inspirations[i];
    }
    for (int i = 0; i < tags.length; i++) {
      body['tags[$i][name]'] = tags[i]['name'];
      body['tags[$i][weight]'] = tags[i]['weight'].toString();
    }

    final response = await http.post(
      completeOnBoradingUrl,
      headers: {"Accept": "application/json", "Authorization": "Bearer $token"},
      body: body,
    );
    print(body);
    final json = jsonDecode(response.body);

    if (response.statusCode == 201 || response.statusCode == 200) {
      return CompleteModel.fromJson(json);
    }

    print(response.body);
    throw Exception(response.body);
  }
}
