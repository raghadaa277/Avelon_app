import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

import 'package:programmers_network_app/controller/Home/posts/posts_controller.dart';
import 'package:programmers_network_app/controller/Home/posts/tage_post_controller.dart';
import 'package:programmers_network_app/core/const/color_const.dart';
import 'package:programmers_network_app/view/screen/Home/posts/add_your_content_page.dart';
import 'package:programmers_network_app/view/screen/Home/posts/poll_page.dart';
import 'package:programmers_network_app/view/widget/Home/posts/create_post_steperr_widget.dart';
import 'package:programmers_network_app/view/widget/Home/tage_slider.dart';

class TagPostPage extends StatefulWidget {
  const TagPostPage({super.key});

  @override
  State<TagPostPage> createState() => _TagPostPageState();
}

class _TagPostPageState extends State<TagPostPage> {
  late PostsController postsController;
  late TagePostController tagePostController;

  @override
  void initState() {
    super.initState();

    postsController = Get.find<PostsController>();

    if (Get.isRegistered<TagePostController>()) {
      tagePostController = Get.find<TagePostController>();
    } else {
      tagePostController = Get.put(TagePostController());
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TagePostController>(
      init: tagePostController,
      builder: (tagCtrl) {
        final tags = tagCtrl.tagePostModel?.data ?? [];

        return Scaffold(
          backgroundColor: ColorConst.colorBackGroung,

          body: SafeArea(
            child: GetBuilder<PostsController>(
              init: postsController,

              builder: (controller) {
                return Column(
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),

                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,

                          children: [
                            Align(
                              alignment: Alignment.centerLeft,

                              child: Container(
                                width: 48,
                                height: 48,

                                decoration: BoxDecoration(
                                  color: ColorConst.colorApp,

                                  borderRadius: BorderRadius.circular(14),

                                  border: Border.all(
                                    color: ColorConst.colorBackGroung,
                                  ),
                                ),

                                child: IconButton(
                                  padding: EdgeInsets.zero,

                                  onPressed: () {
                                    Get.back();
                                  },

                                  icon: const Icon(
                                    Icons.arrow_back_ios_rounded,
                                    size: 18,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 10),

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

                            Center(
                              child: CreatePostSteperrWidget(
                                currentStep: 1,
                                totalSteps: controller.totalSteps,
                              ),
                            ),

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
                                  Container(
                                    width: 56,
                                    height: 56,

                                    decoration: BoxDecoration(
                                      color: const Color(0xFFF0FDF4),

                                      shape: BoxShape.circle,

                                      border: Border.all(
                                        color: const Color(0xFFBBF7D0),
                                      ),
                                    ),

                                    child: HugeIcon(
                                      icon: HugeIcons.strokeRoundedTag01,

                                      color: const Color(0xFF16A34A),

                                      size: 26,
                                    ),
                                  ),

                                  const SizedBox(height: 16),

                                  const Text(
                                    "Tag your post",

                                    textAlign: TextAlign.center,

                                    style: TextStyle(
                                      fontSize: 20,

                                      fontWeight: FontWeight.w800,

                                      color: Color(0xFF111827),
                                    ),
                                  ),

                                  const SizedBox(height: 6),

                                  const Text(
                                    "Choose the topics that fit your post.",

                                    textAlign: TextAlign.center,

                                    style: TextStyle(
                                      fontSize: 13.5,

                                      color: Color(0xFF6B7280),
                                    ),
                                  ),

                                  const SizedBox(height: 20),

                                  if (tagCtrl.isLoading && tags.isEmpty)
                                    const Padding(
                                      padding: EdgeInsets.all(30),

                                      child: CircularProgressIndicator(
                                        color: ColorConst.colorButton,
                                      ),
                                    )
                                  else if (tags.isEmpty)
                                    const Text("No tags available")
                                  else
                                    ListView.separated(
                                      shrinkWrap: true,

                                      physics:
                                          const NeverScrollableScrollPhysics(),

                                      itemCount: tags.length,

                                      separatorBuilder: (_, __) =>
                                          const SizedBox(height: 14),

                                      itemBuilder: (context, index) {
                                        final tag = tags[index];

                                        final tagId = tag.id.toString();

                                        final isSelected = controller.tagIDS
                                            .any((id) => id == tagId);

                                        final style = tagStyle(tag.name);

                                        return InkWell(
                                          borderRadius: BorderRadius.circular(
                                            16,
                                          ),

                                          onTap: () {
                                            controller.toggleTag(tagId);

                                            print(
                                              "Selected: ${controller.tagIDS}",
                                            );
                                          },

                                          child: AnimatedContainer(
                                            duration: const Duration(
                                              milliseconds: 200,
                                            ),

                                            padding: const EdgeInsets.all(16),

                                            decoration: BoxDecoration(
                                              color: isSelected
                                                  ? style.color.withValues(
                                                      alpha: 0.08,
                                                    )
                                                  : const Color(0xFFF9FAFB),

                                              borderRadius:
                                                  BorderRadius.circular(16),

                                              border: Border.all(
                                                color: isSelected
                                                    ? style.color
                                                    : const Color(0xFFF3F4F6),

                                                width: isSelected ? 1.6 : 1,
                                              ),
                                            ),

                                            child: Row(
                                              children: [
                                                Container(
                                                  width: 40,
                                                  height: 40,

                                                  decoration: BoxDecoration(
                                                    color: style.color
                                                        .withValues(
                                                          alpha: 0.12,
                                                        ),

                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          12,
                                                        ),
                                                  ),

                                                  child: Icon(
                                                    style.icon,
                                                    color: style.color,
                                                    size: 22,
                                                  ),
                                                ),

                                                const SizedBox(width: 14),

                                                Expanded(
                                                  child: Text(
                                                    tag.name,

                                                    style: TextStyle(
                                                      fontSize: 15,

                                                      fontWeight: isSelected
                                                          ? FontWeight.w700
                                                          : FontWeight.w600,

                                                      color: const Color(
                                                        0xFF111827,
                                                      ),
                                                    ),
                                                  ),
                                                ),

                                                if (isSelected)
                                                  Icon(
                                                    Icons.check_circle_rounded,

                                                    color: style.color,

                                                    size: 22,
                                                  ),
                                              ],
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
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
                          onPressed: !controller.canContinueTags
                              ? null
                              : () {
                                  print(
                                    "Before next page: ${controller.tagIDS}",
                                  );

                                  if (controller.selectedType == "poll") {
                                    Get.to(() => const PollPage());
                                  } else {
                                    Get.to(() => const AddYourContentPage());
                                  }
                                },

                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF84CC16),

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
                                color: Colors.white,
                                size: 18,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        );
      },
    );
  }
}
