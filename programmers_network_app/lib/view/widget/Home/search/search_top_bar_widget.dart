import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';

import 'package:programmers_network_app/controller/Home/search_controller.dart';
import 'package:programmers_network_app/core/const/color_const.dart';
import 'package:programmers_network_app/view/widget/Home/dialog_widget.dart';

class SearchTopBarWidget extends StatefulWidget {
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
  State<SearchTopBarWidget> createState() => _SearchTopBarWidgetState();
}

class _SearchTopBarWidgetState extends State<SearchTopBarWidget> {
  late final SearchPageController controller;

  @override
  void initState() {
    super.initState();

    controller = Get.find<SearchPageController>();

    widget.textController.addListener(_textListener);
  }

  void _showClearAllDialog() {
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (_) {
        return ClearAllHistoryDialog(
          onConfirm: () {
            controller.clearAllSearchHistory();
          },
        );
      },
    );
  }

  void _textListener() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    widget.textController.removeListener(_textListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final hasText = widget.textController.text.isNotEmpty;

    return Padding(
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
                      focusNode: widget.focusNode,
                      controller: widget.textController,
                      onChanged: widget.onChanged,
                      style: const TextStyle(fontSize: 15),
                      decoration: const InputDecoration(
                        isDense: true,
                        border: InputBorder.none,
                        hintText: 'Search developers or problems...',
                      ),
                    ),
                  ),

                  if (hasText)
                    IconButton(
                      onPressed: widget.onClear,
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(
                        minWidth: 30,
                        minHeight: 30,
                      ),
                      splashRadius: 16,
                      tooltip: 'Clear search',
                      icon: HugeIcon(
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
              widget.focusNode.unfocus();
              _showClearAllDialog();
            },
            child: Text(
              'Clear all',
              style: TextStyle(
                color: ColorConst.colorApp,
                fontWeight: FontWeight.w600,
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
