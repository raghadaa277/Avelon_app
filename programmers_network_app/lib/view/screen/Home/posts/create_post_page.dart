import 'package:flutter/material.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:get/route_manager.dart';
import 'package:get/state_manager.dart';
import 'package:programmers_network_app/controller/Home/posts/posts_controller.dart';
import 'package:programmers_network_app/core/const/color_const.dart';
import 'package:programmers_network_app/view/screen/Home/posts/type_post_page.dart';

class CreatePostPage extends StatefulWidget {
  const CreatePostPage({super.key});

  @override
  State<CreatePostPage> createState() => _CreatePostPageState();
}

class _CreatePostPageState extends State<CreatePostPage> {
  final PostsController controller = Get.put(PostsController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<PostsController>(
      builder: (_) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: ColorConst.colorBackGroung,
            elevation: 0,
            leading: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: ColorConst.colorApp,
                borderRadius: BorderRadius.circular(14),
                border: Border.all(color: ColorConst.colorBackGroung),
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
          backgroundColor: ColorConst.colorBackGroung,
          body: SafeArea(
            child: SingleChildScrollView(
              child: Column(
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

                  const TypePostPage(),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
