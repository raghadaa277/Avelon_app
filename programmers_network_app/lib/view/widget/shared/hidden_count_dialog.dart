import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:programmers_network_app/core/const/post_color.dart';

void showHiddenCountDialog(
  BuildContext context, {
  required String countType,
  String? message,
}) {
  final config = _getConfigByType(countType);

  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      icon: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: config.color.withOpacity(0.1),
          shape: BoxShape.circle,
        ),
        child: HugeIcon(icon: config.icon, size: 40, color: config.color),
      ),
      title: Text(
        'Cannot View $countType',
        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      content: Text(
        message?.isNotEmpty == true
            ? message!
            : 'The post author has hidden the $countType count from other users.',
        style: TextStyle(
          fontSize: 14,
          color: Colors.grey.shade700,
          height: 1.5,
        ),
        textAlign: TextAlign.center,
      ),
      actionsAlignment: MainAxisAlignment.center,
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: config.color,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 12),
            elevation: 0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          onPressed: () => Navigator.pop(context),
          child: const Text(
            'OK',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
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
  if (!isHidden) {
    return true;
  }

  try {
    final response = await apiCall();

    if (response.statusCode == 200) {
      return true;
    } else {
      // نجيب الرسالة من الـ body إذا موجودة
      final backendMessage = response.body is Map
          ? response.body['message'] as String?
          : null;

      if (context.mounted) {
        showHiddenCountDialog(
          context,
          countType: countType,
          message: backendMessage,
        );
      }
      return false;
    }
  } catch (e) {
    if (context.mounted) {
      showHiddenCountDialog(context, countType: countType);
    }
    return false;
  }
}

class _HiddenCountConfig {
  final List<List> icon;
  final Color color;

  const _HiddenCountConfig({required this.icon, required this.color});
}

_HiddenCountConfig _getConfigByType(String countType) {
  switch (countType.toLowerCase()) {
    case 'likes':
      return _HiddenCountConfig(
        icon: HugeIcons.strokeRoundedThumbsUp,
        color: PostColors.like,
      );
    case 'dislikes':
      return _HiddenCountConfig(
        icon: HugeIcons.strokeRoundedThumbsDown,
        color: PostColors.dislike,
      );
    case 'comments':
      return _HiddenCountConfig(
        icon: HugeIcons.strokeRoundedComment01,
        color: PostColors.comment,
      );
    case 'views':
    case 'viewers':
      return _HiddenCountConfig(
        icon: HugeIcons.strokeRoundedEye,
        color: PostColors.views,
      );
    case 'people who liked':
      return _HiddenCountConfig(
        icon: HugeIcons.strokeRoundedUserGroup,
        color: PostColors.like,
      );
    case 'people who disliked':
      return _HiddenCountConfig(
        icon: HugeIcons.strokeRoundedUserGroup,
        color: PostColors.dislike,
      );
    case 'people who view':
      return _HiddenCountConfig(
        icon: HugeIcons.strokeRoundedUser,
        color: PostColors.views,
      );
    default:
      return _HiddenCountConfig(
        icon: HugeIcons.strokeRoundedEye,
        color: Colors.grey.shade700,
      );
  }
}

class Response {
  final int statusCode;
  final dynamic body;

  Response({required this.statusCode, this.body});
}
