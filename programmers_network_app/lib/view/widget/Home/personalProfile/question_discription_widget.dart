import 'package:flutter/material.dart';

class QuestionDescriptionFieldWidget extends StatelessWidget {
  final TextEditingController controller;

  const QuestionDescriptionFieldWidget({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Description',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        ),

        const SizedBox(height: 5),

        Text(
          'Please provide as much detail as possible.',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),

        const SizedBox(height: 9),

        TextField(
          controller: controller,
          maxLines: 7,
          maxLength: 1000,
          textInputAction: TextInputAction.newline,

          decoration: InputDecoration(
            hintText: 'Enter your question here...',
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),

            filled: true,
            fillColor: Colors.white,

            alignLabelWithHint: true,

            contentPadding: const EdgeInsets.all(16),

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
