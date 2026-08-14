import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:programmers_network_app/controller/Home/questions_controller.dart';
import 'package:programmers_network_app/view/widget/Home/personalProfile/ask_header_widget.dart';
import 'package:programmers_network_app/view/widget/Home/personalProfile/question_discription_widget.dart';
import 'package:programmers_network_app/view/widget/Home/personalProfile/questions_title_widget.dart';
import 'package:programmers_network_app/view/widget/Home/personalProfile/questions_type_selector_widget.dart';
import 'package:programmers_network_app/view/widget/Home/personalProfile/submit_question_widget.dart';

class AskQuestionPage extends StatefulWidget {
  final int targetUserId;

  const AskQuestionPage({super.key, required this.targetUserId});

  @override
  State<AskQuestionPage> createState() => _AskQuestionPageState();
}

class _AskQuestionPageState extends State<AskQuestionPage> {
  late final QuestionsController controller;

  final TextEditingController titleController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();

  String selectedType = 'general';

  static const List<String> questionTypes = [
    'general',
    'technical',
    'problem',
    'debugging',
    'code_review',
    'career',
    'job',
    'project',
    'advice',
    'opinion',
    'recommendation',
    'feedback',
  ];

  @override
  void initState() {
    super.initState();

    controller = Get.put(QuestionsController());
  }

  @override
  void dispose() {
    titleController.dispose();
    descriptionController.dispose();

    super.dispose();
  }

  Future<void> _submitQuestion() async {
    FocusScope.of(context).unfocus();

    final title = titleController.text.trim();
    final question = descriptionController.text.trim();

    // Validate title
    if (title.isEmpty) {
      Get.snackbar(
        'Missing title',
        'Please enter a title for your question.',
        snackPosition: SnackPosition.BOTTOM,
      );

      return;
    }

    // Validate question
    if (question.isEmpty) {
      Get.snackbar(
        'Missing question',
        'Please describe your question.',
        snackPosition: SnackPosition.BOTTOM,
      );

      return;
    }

    final bool success = await controller.createQuestion(
      targetUserId: widget.targetUserId,

      // Postman: type
      type: selectedType,

      // Postman: question
      question: question,

      // Postman: title
      title: title,
    );

    if (success && mounted) {
      Get.back();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFAFAFA),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,

        leading: IconButton(
          onPressed: () => Get.back(),
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
        ),

        centerTitle: true,

        title: const Text(
          'Ask Question',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
        ),
      ),

      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(16, 14, 16, 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AskQuestionHeaderWidget(),

                    const SizedBox(height: 22),

                    // TYPE
                    QuestionTypeSelectorWidget(
                      types: questionTypes,
                      selectedType: selectedType,
                      onChanged: (value) {
                        setState(() {
                          selectedType = value;
                        });
                      },
                    ),

                    const SizedBox(height: 22),

                    // TITLE
                    QuestionTitleFieldWidget(controller: titleController),

                    const SizedBox(height: 20),

                    // QUESTION / DESCRIPTION
                    QuestionDescriptionFieldWidget(
                      controller: descriptionController,
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),

            SubmitQuestionButtonWidget(
              isLoading: controller.isLoading,
              onPressed: _submitQuestion,
            ),
          ],
        ),
      ),
    );
  }
}
