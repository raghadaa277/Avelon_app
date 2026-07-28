import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

void showHiddenCountDialog(
  BuildContext context, {
  required String countType,
  List<List>? iconStyle,
}) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      icon: HugeIcon(
        icon: _getIconByType(countType),
        size: 56,
        color: Colors.grey.shade600,
      ),
      iconColor: Colors.grey.shade600,
      title: Text(
        'Cannot View $countType',
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      content: Text(
        'The post author has hidden the $countType count from other users.',
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey.shade700,
          height: 1.5,
        ),
        textAlign: TextAlign.center,
      ),
      actions: [
        Center(
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.grey.shade800,
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 10),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            onPressed: () => Navigator.pop(context),
            child: const Text(
              'OK',
              style: TextStyle(
                color: Colors.white,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    ),
  );
}

Future<bool> handleViewCount({
  required BuildContext context,
  required String countType,
  required bool isHidden,
  required Future<Response> Function() apiCall,
}) async {
  // If count is not hidden, allow viewing
  if (!isHidden) {
    return true;
  }

  // If count is hidden, make API call to validate permission
  try {
    final response = await apiCall();

    if (response.statusCode == 200) {
      // Permission granted - can view count
      return true;
    } else {
      // Permission denied - show dialog
      if (context.mounted) {
        showHiddenCountDialog(
          context,
          countType: countType,
          iconStyle: HugeIcons.strokeRoundedSettingError03,
        );
      }
      return false;
    }
  } catch (e) {
    // Error occurred - show dialog
    if (context.mounted) {
      showHiddenCountDialog(
        context,
        countType: countType,
        iconStyle: HugeIcons.strokeRoundedSettingError03,
      );
    }
    return false;
  }
}

List<List> _getIconByType(String countType) {
  switch (countType.toLowerCase()) {
    case 'likes':
      return HugeIcons.strokeRoundedThumbsUp;
    case 'views':
      return HugeIcons.strokeRoundedEye;
    case 'comments':
      return HugeIcons.strokeRoundedComment01;
    case 'dislikes':
      return HugeIcons.strokeRoundedThumbsDown;
    default:
      return HugeIcons.strokeRoundedEye;
  }
}

class Response {
  final int statusCode;
  final dynamic body;

  Response({required this.statusCode, this.body});
}
