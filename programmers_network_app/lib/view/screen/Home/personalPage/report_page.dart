import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:programmers_network_app/controller/Home/personalPage/user%20Flag/user_flag_controller.dart';
import 'package:programmers_network_app/data/services/Home/personalPage/user%20Flag/user_flag_services.dart';

class ReportUserPage extends StatefulWidget {
  final int userId;

  const ReportUserPage({super.key, required this.userId});

  @override
  State<ReportUserPage> createState() => _ReportUserPageState();
}

class _ReportUserPageState extends State<ReportUserPage> {
  late final UserFlagController controller;

  @override
  void initState() {
    super.initState();

    controller = Get.put(UserFlagController());
  }

  String? selectedReason;

  final List<Map<String, String>> reasons = [
    {"value": "spam", "label": "Spam"},
    {"value": "harassment", "label": "Harassment"},
    {"value": "fake_account", "label": "Fake Account"},
    {"value": "other", "label": "Other"},
  ];

  final TextEditingController descriptionController = TextEditingController();

  Future<void> submitReport() async {
    if (selectedReason == null) {
      Get.snackbar(
        "Missing reason",
        "Please select a reason",
        icon: const HugeIcon(
          icon: HugeIcons.strokeRoundedAlert02,
          color: Colors.white,
        ),
      );
      return;
    }

    final result = await controller.reportUser(
      targetUserId: widget.userId,
      reason: selectedReason!,
      description: descriptionController.text.trim(),
    );

    if (result == null) {
      if (controller.errorMessage.value.isNotEmpty) {
        showDialog(
          context: context,
          builder: (_) => UserFlagConflictDialog(
            message: controller.errorMessage.value.replaceFirst(
              "Exception: ",
              "",
            ),
          ),
        );
      }

      return;
    }

    Get.back();
    Future.delayed(const Duration(milliseconds: 300), () {
      Get.snackbar(
        "Report Sent",
        result.message,
        icon: const HugeIcon(
          icon: HugeIcons.strokeRoundedCheckmarkCircle02,
          color: Colors.black,
        ),

        colorText: Colors.black,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8FAFC),

      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.transparent,

        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const HugeIcon(
            icon: HugeIcons.strokeRoundedArrowLeft02,
            color: Color(0xff1E293B),
          ),
        ),

        title: const Text(
          "Report User",
          style: TextStyle(
            color: Color(0xff1E293B),
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(22),

              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xffDCFCE7), Color(0xffF0FDF4)],
                ),

                borderRadius: BorderRadius.circular(24),
              ),

              child: Column(
                children: [
                  Container(
                    height: 85,
                    width: 85,

                    decoration: BoxDecoration(
                      color: const Color(0xff84CC16).withOpacity(.15),
                      shape: BoxShape.circle,
                    ),

                    child: const HugeIcon(
                      icon: HugeIcons.strokeRoundedUserWarning01,
                      size: 48,
                      color: Color(0xff65A30D),
                    ),
                  ),

                  const SizedBox(height: 15),

                  const Text(
                    "Help us understand the issue",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xff1E293B),
                    ),
                  ),

                  const SizedBox(height: 8),

                  Text(
                    "Tell us why you want to report this user.",
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.grey.shade700, height: 1.4),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 25),

            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(.04),
                    blurRadius: 15,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: DropdownButtonFormField<String>(
                value: selectedReason,
                decoration: InputDecoration(
                  labelText: "Reason",
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(12),
                    child: HugeIcon(
                      icon: HugeIcons.strokeRoundedAlert02,
                      color: Color(0xff84CC16),
                    ),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
                borderRadius: BorderRadius.circular(16),
                icon: const HugeIcon(
                  icon: HugeIcons.strokeRoundedArrowDown01,
                  color: Color(0xff84CC16),
                ),
                items: reasons.map((reason) {
                  return DropdownMenuItem<String>(
                    value: reason["value"],
                    child: Text(reason["label"]!),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    selectedReason = value;
                  });
                },
              ),
            ),

            const SizedBox(height: 18),

            _inputField(
              controller: descriptionController,
              title: "Description",
              hint: "Explain the problem in more details...",
              icon: HugeIcons.strokeRoundedNote02,
              maxLines: 5,
            ),

            const SizedBox(height: 35),

            Obx(
              () => SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton(
                  onPressed: controller.isLoading.value ? null : submitReport,

                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff84CC16),

                    foregroundColor: Colors.white,

                    elevation: 0,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18),
                    ),
                  ),

                  child: controller.isLoading.value
                      ? const CircularProgressIndicator(color: Colors.white)
                      : const Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            HugeIcon(
                              icon: HugeIcons.strokeRoundedFlag02,
                              size: 22,
                              color: Colors.white,
                            ),

                            SizedBox(width: 10),

                            Text(
                              "Submit Report",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _inputField({
    required TextEditingController controller,
    required String title,
    required String hint,
    required List<List> icon,
    int maxLines = 1,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,

        borderRadius: BorderRadius.circular(20),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(.04),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),

      child: TextField(
        controller: controller,

        maxLines: maxLines,

        decoration: InputDecoration(
          labelText: title,

          hintText: hint,

          prefixIcon: Padding(
            padding: const EdgeInsets.all(12),
            child: HugeIcon(icon: icon, color: const Color(0xff84CC16)),
          ),

          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),

            borderSide: BorderSide.none,
          ),

          filled: true,

          fillColor: Colors.white,

          contentPadding: const EdgeInsets.all(18),
        ),
      ),
    );
  }
}
