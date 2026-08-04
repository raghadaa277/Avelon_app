import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:programmers_network_app/core/const/color_const.dart';

class SearchTopBarWidget extends StatelessWidget {
  final TextEditingController textController;
  final FocusNode focusNode;
  final ValueChanged<String> onChanged;
  final VoidCallback onClear;

  const SearchTopBarWidget({
    super.key,
    required this.textController,
    required this.focusNode,
    required this.onChanged,
    required this.onClear,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
          child: Row(
            children: [
              Expanded(
                child: Container(
                  height: 48,
                  padding: const EdgeInsets.symmetric(horizontal: 14),
                  decoration: BoxDecoration(
                    color: const Color(0xffF0F1EC),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Row(
                    children: [
                      HugeIcon(
                        icon: HugeIcons.strokeRoundedSearch01,
                        color: Colors.grey.shade500,
                        size: 22,
                      ),

                      const SizedBox(width: 10),

                      Expanded(
                        child: TextFormField(
                          focusNode: focusNode,
                          controller: textController,
                          onChanged: onChanged,
                          style: const TextStyle(fontSize: 15),
                          decoration: const InputDecoration(
                            isDense: true,
                            border: InputBorder.none,
                            hintText: "Search developers or problems...",
                          ),
                        ),
                      ),

                      if (textController.text.isNotEmpty)
                        GestureDetector(
                          onTap: onClear,
                          child: HugeIcon(
                            icon: HugeIcons.strokeRoundedCancelCircle,
                            color: Colors.grey.shade400,
                            size: 20,
                          ),
                        ),
                    ],
                  ),
                ),
              ),

              const SizedBox(width: 10),

              GestureDetector(
                onTap: () {
                  focusNode.unfocus();
                  Get.back();
                },
                child: Text(
                  "Cancel",
                  style: TextStyle(
                    color: ColorConst.colorApp,
                    fontWeight: FontWeight.w600,
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
