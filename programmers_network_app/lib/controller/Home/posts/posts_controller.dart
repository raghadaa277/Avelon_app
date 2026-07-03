import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:programmers_network_app/data/models/Home/posts/create_post_model.dart';
import 'package:programmers_network_app/data/services/Home/posts/posts_services.dart';

class PostsController extends GetxController {
  final PostsServices _postsServices = PostsServices();
  final titleController = TextEditingController();
  final contentController = TextEditingController();

  bool isLoading = false;
  String? errorMessage;

  final List<File> mediaFiles = [];
  final ImagePicker _picker = ImagePicker();

  final List<PostType> postTypes = const [
    PostType(type: "article", label: "Article"),
    PostType(type: "question", label: "Question"),
    PostType(type: "problem", label: "Problem"),
    PostType(type: "poll", label: "Poll"),
    PostType(type: "project", label: "Project"),
  ];
  String? selectedType;

  String visibility = "public";

  bool allowComments = false;
  bool hideCommentsCount = false;
  bool hideReactions = false;
  bool hideReactionsCount = false;
  bool hideViews = false;
  bool hideViewsCount = false;

  void selectType(String type) {
    selectedType = type;
    update();
  }

  CreatePostModel? createPostModel;

  Future<bool> createPost({
    required String type,
    required String title,
    required String content,
    required String visibility,
    required bool allowComments,
    required bool hideCommentsCount,
    required bool hideReactions,
    required bool hideReactionsCount,
    required bool hideViews,
    required bool hideViewsCount,
    String? publishedAt,
    List<File>? media,
  }) async {
    isLoading = true;
    errorMessage = null;
    update();

    try {
      createPostModel = await _postsServices.createPost(
        type: type,
        title: title,
        content: content,
        visibility: visibility,
        allowComments: allowComments,
        hideCommentsCount: hideCommentsCount,
        hideReactions: hideReactions,
        hideReactionsCount: hideReactionsCount,
        hideViews: hideViews,
        hideViewsCount: hideViewsCount,
        publishedAt: publishedAt,
        media: media,
      );
      if (createPostModel != null && createPostModel!.success) {
        clearPostData();
      }
      isLoading = false;
      update();

      return true;
    } catch (e) {
      errorMessage = e.toString().replaceFirst("Exception: ", "");
      isLoading = false;
      update();

      return false;
    }
  }

  bool get canSubmitSettings {
    return allowComments ||
        hideCommentsCount ||
        hideReactions ||
        hideReactionsCount ||
        hideViews ||
        hideViewsCount;
  }

  bool get canContinue {
    return selectedType != null &&
        titleController.text.trim().isNotEmpty &&
        contentController.text.trim().isNotEmpty;
  }

  Future<void> pickImage() async {
    final List<XFile> images = await _picker.pickMultiImage();

    if (images.isNotEmpty) {
      if (mediaFiles.length + images.length > 10) {
        errorMessage = "You can upload up to 10 images only";
        update();
        return;
      }

      mediaFiles.addAll(images.map((e) => File(e.path)));
      update();
    }
  }

  void removeImage(int index) {
    mediaFiles.removeAt(index);
    update();
  }

  @override
  void onClose() {
    titleController.dispose();
    contentController.dispose();
    super.onClose();
  }

  void clearPostData() {
    titleController.clear();
    contentController.clear();
    mediaFiles.clear();

    allowComments = false;
    hideCommentsCount = false;
    hideReactions = false;
    hideReactionsCount = false;
    hideViews = false;
    hideViewsCount = false;

    publishNow = true;
    scheduledAt = null;

    selectedType = null;

    update();
  }

  bool get canPublish {
    return publishNow || scheduledAt != null;
  }

  bool publishNow = false;

  DateTime? scheduledAt;

  void selectPublishNow() {
    publishNow = true;
    scheduledAt = null;
    update();
  }

  Future<void> selectSchedule(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
      initialDate: DateTime.now(),
    );

    if (date == null) return;

    final time = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (time == null) return;

    publishNow = false;

    scheduledAt = DateTime(
      date.year,
      date.month,
      date.day,
      time.hour,
      time.minute,
    );

    update();
  }
}
