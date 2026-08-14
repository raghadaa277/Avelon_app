import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class QuestionTitleFieldWidget extends StatelessWidget {
  final TextEditingController controller;

  const QuestionTitleFieldWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Question Title',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        ),

        const SizedBox(height: 8),

        TextField(
          controller: controller,
          textInputAction: TextInputAction.next,
          maxLength: 150,

          decoration: InputDecoration(
            hintText: 'What would you like to ask?',
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),

            prefixIcon: const HugeIcon(
              icon: HugeIcons.strokeRoundedText,
              size: 20,
              color: Color(0xFF84CC16),
            ),

            filled: true,
            fillColor: Colors.white,

            counterText: '',

            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 16,
            ),

            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),

            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),

            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(14),
              borderSide: const BorderSide(
                color: Color(0xFF84CC16),
                width: 1.5,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
