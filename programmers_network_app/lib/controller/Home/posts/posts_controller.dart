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

  int get totalSteps => selectedType == "poll" ? 5 : 6;

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

  List<String> tagIDS = [];

  void toggleTag(String id) {
    print("Before: $tagIDS");

    if (tagIDS.contains(id)) {
      tagIDS.remove(id);
    } else {
      tagIDS.add(id);
    }

    print("After: $tagIDS");

    update();
  }

  bool get canContinueTags => tagIDS.isNotEmpty;

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
    required List<String> tagIDS,

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
        tagIDS: tagIDS,

        pollQuestion: type == "poll" ? pollQuestion : null,
        pollOptions: type == "poll" ? pollOptions : null,
        allowMultipleAnswers: type == "poll" ? allowMultipleAnswers : null,
      );
      Get.snackbar(
        "Success",
        createPostModel!.message,
        snackPosition: SnackPosition.TOP,
      );

      clearPostData();

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

  bool get canSubmitSettings => true;

  bool get canContinue {
    return selectedType != null &&
        titleController.text.trim().isNotEmpty &&
        contentController.text.trim().isNotEmpty;
  }

  Future<void> pickImage() async {
    try {
      final List<XFile> images = await _picker.pickMultiImage();

      if (images.isEmpty) return;

      final newFiles = images
          .map((e) => File(e.path))
          .where(
            (file) => !mediaFiles.any((oldFile) => oldFile.path == file.path),
          )
          .toList();

      if (mediaFiles.length + newFiles.length > 10) {
        errorMessage = "You can upload up to 10 images only";
        update();
        return;
      }

      mediaFiles.addAll(newFiles);

      errorMessage = null;
      update();
    } catch (e, s) {
      debugPrint(e.toString());
      debugPrint(s.toString());

      Get.snackbar("Error", e.toString(), snackPosition: SnackPosition.BOTTOM);
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

    tagIDS.clear();

    allowComments = false;
    hideCommentsCount = false;
    hideReactions = false;
    hideReactionsCount = false;
    hideViews = false;
    hideViewsCount = false;

    publishNow = true;
    scheduledAt = null;

    selectedType = null;

    pollQuestion = '';
    pollOptions = ['', ''];
    allowMultipleAnswers = false;

    update();
  }

  bool get canPublish {
    return publishNow || scheduledAt != null;
  }

  bool publishNow = true;

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

  String pollQuestion = '';
  List<String> pollOptions = ['', ''];
  bool allowMultipleAnswers = false;

  void setPollQuestion(String value) {
    pollQuestion = value;
    update();
  }

  void addPollOption() {
    if (pollOptions.length < 10) {
      pollOptions.add('');
      update();
    }
  }

  void removePollOption(int index) {
    if (pollOptions.length > 2) {
      pollOptions.removeAt(index);
      update();
    }
  }

  void updatePollOption(int index, String value) {
    pollOptions[index] = value;
    update();
  }

  void toggleMultipleAnswers(bool value) {
    allowMultipleAnswers = value;
    update();
  }

  bool get canContinuePoll {
    return pollQuestion.trim().isNotEmpty &&
        pollOptions.where((o) => o.trim().isNotEmpty).length >= 2;
  }
}
