import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:programmers_network_app/data/models/Home/posts/comments/edit_comment_model.dart';
import 'package:programmers_network_app/data/services/Home/posts/comments/comments_services.dart';

class EditCommentController extends GetxController {
  final CommentsServices _commentsServices = CommentsServices();

  final RxBool isLoading = false.obs;

  final Rx<EditCommentModel?> editCommentResult = Rx<EditCommentModel?>(null);

  final RxString errorMessage = ''.obs;

  Future<bool> editComment({
    required int targetUserId,
    required int postId,
    required int commentId,
    required String content,
  }) async {
    if (content.trim().isEmpty) {
      errorMessage.value = 'Content cannot be empty';
      return false;
    }

    try {
      isLoading.value = true;
      errorMessage.value = '';

      final result = await _commentsServices.editComment(
        targetUserId: targetUserId,
        postId: postId,
        commentId: commentId,
        content: content,
      );

      editCommentResult.value = result;

      if (result.success) {
        return true;
      } else {
        errorMessage.value = result.message;
        Get.snackbar(
          'Error',
          result.message,
          snackPosition: SnackPosition.TOP,

          colorText: Colors.white,
        );
        return false;
      }
    } catch (e) {
      errorMessage.value = e.toString().replaceAll('Exception: ', '');
      Get.snackbar(
        'Error',
        errorMessage.value,
        snackPosition: SnackPosition.TOP,

        colorText: Colors.white,
      );
      return false;
    } finally {
      isLoading.value = false;
    }
  }
}
