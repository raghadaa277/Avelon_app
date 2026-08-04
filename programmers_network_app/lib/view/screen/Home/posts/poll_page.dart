import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:programmers_network_app/controller/Home/posts/posts_controller.dart';
import 'package:programmers_network_app/core/const/color_const.dart';
import 'package:programmers_network_app/view/screen/Home/posts/post_setting_page.dart';
import 'package:programmers_network_app/view/widget/Home/posts/card_switch_post_settings_widget.dart';
import 'package:programmers_network_app/view/widget/Home/posts/create_post_steperr_widget.dart';

class PollPage extends StatefulWidget {
  const PollPage({super.key});

  @override
  State<PollPage> createState() => _PollPageState();
}

class _PollPageState extends State<PollPage> {
  final PostsController controller = Get.find<PostsController>();
  final List<TextEditingController> optionControllers = [];
  final TextEditingController questionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    questionController.text = controller.pollQuestion;
    for (var option in controller.pollOptions) {
      optionControllers.add(TextEditingController(text: option));
    }
  }

  @override
  void dispose() {
    questionController.dispose();
    for (var c in optionControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _addOption() {
    controller.addPollOption();
    optionControllers.add(TextEditingController());
    setState(() {});
  }

  void _removeOption(int index) {
    controller.removePollOption(index);
    optionControllers[index].dispose();
    optionControllers.removeAt(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostsController>(
      builder: (ctrl) {
        return Scaffold(
          backgroundColor: ColorConst.colorBackGroung,
          appBar: AppBar(
            backgroundColor: ColorConst.colorBackGroung,
            elevation: 0,
            leading: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: ColorConst.colorApp,
                borderRadius: BorderRadius.circular(14),
              ),
              child: IconButton(
                onPressed: () => Get.back(),
                icon: const Icon(
                  Icons.arrow_back_ios_rounded,
                  size: 18,
                  color: Colors.black,
                ),
              ),
            ),
          ),
          body: SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    "Create Post",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF111827),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Center(child: CreatePostSteperrWidget(currentStep: 2)),
                  const SizedBox(height: 24),
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(24),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.06),
                          blurRadius: 24,
                          offset: const Offset(0, 8),
                        ),
                      ],
                    ),
                    child: Column(
                      children: [
                        Text(
                          "Post settings",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w800,
                            color: Color(0xFF111827),
                          ),
                        ),
                        const SizedBox(height: 6),
                        Text(
                          "Create your poll questions and options",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 13.5,
                            color: Color(0xFF6B7280),
                          ),
                        ),
                        if (controller.isLoading)
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 32),
                            child: Center(
                              child: CircularProgressIndicator(
                                color: ColorConst.colorButton,
                              ),
                            ),
                          )
                        else if (controller.errorMessage != null)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 24),
                            child: Text(
                              controller.errorMessage!,
                              textAlign: TextAlign.center,
                              style: const TextStyle(color: Colors.redAccent),
                            ),
                          ),

                        const SizedBox(height: 50),

                        Container(
                          padding: const EdgeInsets.all(24),
                          decoration: BoxDecoration(
                            color: ColorConst.colorApp,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.06),
                                blurRadius: 24,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                "Poll question",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 10),
                              TextField(
                                controller: questionController,
                                onChanged: ctrl.setPollQuestion,
                                decoration: InputDecoration(
                                  hintText: "What do you want to ask ?",
                                  hintStyle: TextStyle(
                                    color: Colors.grey.shade400,
                                    fontSize: 13,
                                  ),
                                  filled: true,
                                  fillColor: const Color(0xFFF9FAFB),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    borderSide: BorderSide.none,
                                  ),
                                ),
                              ),

                              const SizedBox(height: 16),
                              const Text(
                                "Options",
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(height: 10),
                              ...List.generate(optionControllers.length, (i) {
                                return Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: TextField(
                                          controller: optionControllers[i],
                                          onChanged: (val) =>
                                              ctrl.updatePollOption(i, val),
                                          decoration: InputDecoration(
                                            hintText: "Option ${i + 1}",
                                            hintStyle: TextStyle(
                                              color: Colors.grey.shade400,
                                            ),
                                            filled: true,
                                            fillColor: const Color(0xFFF9FAFB),
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(12),
                                              borderSide: BorderSide.none,
                                            ),
                                          ),
                                        ),
                                      ),
                                      if (optionControllers.length > 2) ...[
                                        const SizedBox(width: 8),
                                        GestureDetector(
                                          onTap: () => _removeOption(i),
                                          child: const Icon(
                                            Icons.close,
                                            color: Colors.redAccent,
                                            size: 20,
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                );
                              }),
                              if (optionControllers.length < 10)
                                TextButton.icon(
                                  onPressed: _addOption,
                                  icon: const Icon(
                                    Icons.add,
                                    color: Color(0xFF84CC16),
                                  ),
                                  label: const Text(
                                    "Add Option",
                                    style: TextStyle(color: Color(0xFF84CC16)),
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 14,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: CardSwitchPostSettingsWidget(
                      icon: HugeIcons.strokeRoundedNote,
                      text: "Allow multiple choices",
                      value: controller.allowMultipleAnswers,
                      onChanged: (value) {
                        controller.allowMultipleAnswers = value;
                        controller.update();
                      },
                    ),
                  ),
                  const SizedBox(height: 24),

                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 16,
                    ),
                    child: SizedBox(
                      width: double.infinity,
                      height: 52,
                      child: ElevatedButton(
                        onPressed: controller.allowMultipleAnswers
                            ? () {
                                Get.to(() => PostSettingPage());
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: controller.canContinuePoll
                              ? const Color(0xFF84CC16)
                              : const Color(0xFF84CC16).withValues(alpha: 0.4),
                          disabledBackgroundColor: const Color(
                            0xFF84CC16,
                          ).withValues(alpha: 0.4),
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(14),
                          ),
                        ),
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "Continue",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(width: 8),
                            Icon(
                              Icons.arrow_forward,
                              size: 18,
                              color: Colors.white,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
