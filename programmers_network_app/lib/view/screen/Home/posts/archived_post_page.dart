import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:programmers_network_app/controller/Home/posts/archive_post_controller.dart';
import 'package:programmers_network_app/core/const/color_const.dart';
import 'package:programmers_network_app/data/models/Profile/profile_model.dart';
import 'package:programmers_network_app/view/widget/Home/posts/archive_post_list_widget.dart';

class ArchivedPage extends StatefulWidget {
  final ProfileData profileData;

  const ArchivedPage({super.key, required this.profileData});

  @override
  State<ArchivedPage> createState() => _ArchivedPostState();
}

class _ArchivedPostState extends State<ArchivedPage> {
  final ArchivePostController controller = Get.find<ArchivePostController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorConst.colorBackGroung,
        elevation: 0,
        centerTitle: true,
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
        title: const Text(
          "Archived post page",
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: Color(0xFF111827),
            height: 1.25,
          ),
        ),
      ),
      backgroundColor: ColorConst.colorBackGroung,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [ArchivedPostsList(profileData: widget.profileData)],
          ),
        ),
      ),
    );
  }
}
