import 'dart:convert';

import 'package:programmers_network_app/core/const/api_Constants.dart';
import 'package:programmers_network_app/core/storage/api_client.dart';
import 'package:programmers_network_app/data/models/Home/suggestions/get_suggestions_model.dart';
import 'package:programmers_network_app/data/models/Home/suggestions/ignore_model.dart';
import 'package:programmers_network_app/data/models/Home/suggestions/suggestions_view_model.dart';

class SuggestionsServices {
  final ApiClient apiClient = ApiClient(baseUrl: ApiConstants.baseurl);

  Future<GetSuggestionsModel> getSuggestions({int page = 1}) async {
    try {
      final url = '${ApiConstants.getSuggestions}?page=$page';

      final response = await apiClient.get(url);

      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 200) {
        return GetSuggestionsModel.fromJson(decodedResponse);
      }

      throw Exception(
        decodedResponse['message'] ??
            'Failed to get suggestions. Status: ${response.statusCode}',
      );
    } catch (e) {
      print('Suggestions Service Error: $e');
      rethrow;
    }
  }

  Future<IgnoreModel> ignoreSuggestions({required int id}) async {
    try {
      final response = await apiClient.post(
        "${ApiConstants.handelIgrnore}/$id",
      );
      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return IgnoreModel.fromJson(decodedResponse);
      }
      throw Exception(
        decodedResponse['message'] ??
            'Failed to ignore suggestions. Status: ${response.statusCode}',
      );
    } catch (e) {
      print('Suggestions Service Error: $e');
      rethrow;
    }
  }

  Future<SuggestionsViewModel> suggestionsView({required int id}) async {
    try {
      final response = await apiClient.post(
        "${ApiConstants.suggestionsView}/$id",
      );
      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return SuggestionsViewModel.fromJson(decodedResponse);
      }
      throw Exception(
        decodedResponse['message'] ??
            'Failed to view suggestions. Status: ${response.statusCode}',
      );
    } catch (e) {
      print('Suggestions Service Error: $e');
      rethrow;
    }
  }
}
