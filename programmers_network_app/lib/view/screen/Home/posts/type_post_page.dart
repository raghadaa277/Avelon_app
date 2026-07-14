import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:programmers_network_app/controller/Home/posts/posts_controller.dart';

import 'package:programmers_network_app/core/const/color_const.dart';
import 'package:programmers_network_app/view/screen/Home/posts/tage_post_page.dart';
import 'package:programmers_network_app/view/widget/Home/posts/create_post_steperr_widget.dart';
import 'package:programmers_network_app/view/widget/Home/posts/type_post_widget.dart';

class TypePostPage extends StatefulWidget {
  const TypePostPage({super.key});

  @override
  State<TypePostPage> createState() => _TypePostPageState();
}

class _TypePostPageState extends State<TypePostPage> {
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
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 10),
            const CreatePostSteperrWidget(currentStep: 0, totalSteps: 6),
            const SizedBox(height: 24),

            Container(
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
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Text(
                    "What do you want to create ?",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF111827),
                    ),
                  ),

                  const SizedBox(height: 6),

                  const Text(
                    "Choose the type of post that fits your content",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 13.5, color: Color(0xFF6B7280)),
                  ),

                  const SizedBox(height: 20),

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
                    )
                  else
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.postTypes.length,
                      separatorBuilder: (_, __) => const SizedBox(height: 10),
                      itemBuilder: (context, index) {
                        final type = controller.postTypes[index];

                        return TypePostChip(
                          type: type,
                          isSelected: controller.selectedType == type.type,
                          onTap: () {
                            controller.selectType(type.type);
                          },
                        );
                      },
                    ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
              child: SizedBox(
                width: double.infinity,
                height: 52,
                child: ElevatedButton(
                  onPressed: controller.selectedType == null
                      ? null
                      : () {
                          Get.to(() => const TagPostPage());
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
                      Icon(Icons.arrow_forward, size: 18, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
