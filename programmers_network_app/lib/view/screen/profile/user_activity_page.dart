import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:programmers_network_app/controller/Home/profile/start_session_controller.dart';
import 'package:programmers_network_app/core/const/color_const.dart';

class UserActivityPage extends StatefulWidget {
  const UserActivityPage({super.key});

  @override
  State<UserActivityPage> createState() => _UserActivityPageState();
}

class _UserActivityPageState extends State<UserActivityPage> {
  final UserSessionController controller = Get.put(UserSessionController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserSessionController>(
      builder: (controller) {
        return Scaffold(
          backgroundColor: ColorConst.colorBackGroung,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            scrolledUnderElevation: 0,
            leadingWidth: 60,
            leading: Padding(
              padding: const EdgeInsets.only(left: 12),
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black54,
                    size: 14,
                  ),
                  onPressed: () => Navigator.pop(context),
                ),
              ),
            ),

            centerTitle: true,

            title: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "User Activity",
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w800,
                    color: Color(0xFF111827),
                  ),
                ),
                SizedBox(height: 6),
                Text(
                  "Track and review your activity sessions.",
                  style: TextStyle(fontSize: 10, color: Color(0xFF9CA3AF)),
                ),
              ],
            ),

            actions: [
              Padding(
                padding: const EdgeInsets.only(right: 16),
                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedActivity01,
                  color: Colors.black87,
                  size: 22,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
