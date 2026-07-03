import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:programmers_network_app/controller/Home/posts/posts_controller.dart';
import 'package:get/get.dart';
import 'package:programmers_network_app/core/const/color_const.dart';
import 'package:programmers_network_app/view/screen/Home/posts/publish_page.dart';
import 'package:programmers_network_app/view/widget/Home/posts/card_switch_post_settings_widget.dart';
import 'package:programmers_network_app/view/widget/Home/posts/create_post_steperr_widget.dart';

class PostSettingPage extends StatefulWidget {
  const PostSettingPage({super.key});
  @override
  State<PostSettingPage> createState() => _PostSettingPageState();
}

class _PostSettingPageState extends State<PostSettingPage> {
  late PostsController controller;

  @override
  void initState() {
    super.initState();
    controller = Get.find<PostsController>();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostsController>(
      init: controller,
      builder: (controller) {
        return Scaffold(
          backgroundColor: ColorConst.colorBackGroung,

          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 30),

                  const Text(
                    "Create Post",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF111827),
                      height: 1.25,
                    ),
                  ),

                  const SizedBox(height: 20),

                  const Center(child: CreatePostSteperrWidget(currentStep: 3)),

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
                          "Customiz how your post will appare",
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

                        CardSwitchPostSettingsWidget(
                          icon: HugeIcons.strokeRoundedCommentAdd03,
                          text: "Add comments",
                          value: controller.allowComments,
                          onChanged: (value) {
                            controller.allowComments = value;
                            controller.update();
                          },
                        ),
                        SizedBox(height: 4),
                        CardSwitchPostSettingsWidget(
                          icon: HugeIcons.strokeRoundedMessageLock01,
                          text: "Hide comments count",
                          value: controller.hideCommentsCount,
                          onChanged: (value) {
                            controller.hideCommentsCount = value;
                            controller.update();
                          },
                        ),
                        SizedBox(height: 4),
                        CardSwitchPostSettingsWidget(
                          icon: HugeIcons.strokeRoundedFavourite,
                          text: "Hide reactions",
                          value: controller.hideReactions,
                          onChanged: (value) {
                            controller.hideReactions = value;
                            controller.update();
                          },
                        ),
                        SizedBox(height: 4),
                        CardSwitchPostSettingsWidget(
                          icon: HugeIcons.strokeRoundedHeartRemove,
                          text: "Hide reactions count",
                          value: controller.hideReactionsCount,
                          onChanged: (value) {
                            controller.hideReactionsCount = value;
                            controller.update();
                          },
                        ),
                        SizedBox(height: 4),
                        CardSwitchPostSettingsWidget(
                          icon: HugeIcons.strokeRoundedView,
                          text: "Hide views",
                          value: controller.hideViews,
                          onChanged: (value) {
                            controller.hideViews = value;
                            controller.update();
                          },
                        ),
                        SizedBox(height: 4),
                        CardSwitchPostSettingsWidget(
                          icon: HugeIcons.strokeRoundedViewOffSlash,
                          text: "Hide views count",
                          value: controller.hideViewsCount,
                          onChanged: (value) {
                            controller.hideViewsCount = value;
                            controller.update();
                          },
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 16,
                          ),
                          child: SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: ElevatedButton(
                              onPressed: controller.canContinue
                                  ? () {
                                      Get.to(() => PublishPage());
                                    }
                                  : null,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: controller.canSubmitSettings
                                    ? const Color(0xFF84CC16)
                                    : const Color(
                                        0xFF84CC16,
                                      ).withValues(alpha: 0.4),
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
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
