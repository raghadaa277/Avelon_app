import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:programmers_network_app/core/const/api_Constants.dart';
import 'package:programmers_network_app/core/storage/api_client.dart';
import 'package:programmers_network_app/data/models/Home/personalPage/user%20Flag/user_flag_model.dart';

class UserFlagServices {
  final ApiClient apiClient = ApiClient(baseUrl: ApiConstants.baseurl);

  Future<UserFlagModel> userFlag({
    required int targetUserId,
    required String reason,
    String? description,
  }) async {
    try {
      final response = await apiClient.post(
        "${ApiConstants.userFlag}/$targetUserId",
        body: {
          'reason': reason,
          if (description != null) 'description': description,
        },
      );

      final decodedResponse = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return UserFlagModel.fromJson(decodedResponse);
      } else if (response.statusCode == 409) {
        throw Exception(
          decodedResponse['message'] ?? 'You already reported this user',
        );
      }

      throw Exception(decodedResponse['message'] ?? 'Failed to report account');
    } catch (e) {
      rethrow;
    }
  }
}

class UserFlagConflictDialog extends StatelessWidget {
  final String message;

  const UserFlagConflictDialog({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 80,
              width: 80,
              decoration: BoxDecoration(
                // ignore: deprecated_member_use
                color: Colors.orange.withOpacity(.12),
                shape: BoxShape.circle,
              ),
              child: HugeIcon(
                icon: HugeIcons.strokeRoundedAlert02,
                size: 45,
                color: Colors.deepOrangeAccent,
              ),
            ),

            const SizedBox(height: 20),

            const Text(
              "Already Reported",
              style: TextStyle(fontSize: 21, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            Text(
              message,
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.grey.shade600,
                fontSize: 15,
                height: 1.5,
              ),
            ),

            const SizedBox(height: 25),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange.shade600,
                  foregroundColor: Colors.white,
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "OK",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
