import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class QuestionTypeSelectorWidget extends StatelessWidget {
  final List<String> types;
  final String selectedType;
  final ValueChanged<String> onChanged;

  const QuestionTypeSelectorWidget({
    super.key,
    required this.types,
    required this.selectedType,
    required this.onChanged,
  });

  String _label(String type) {
    switch (type) {
      case 'general':
        return 'General';
      case 'technical':
        return 'Technical';
      case 'problem':
        return 'Problem';
      case 'debugging':
        return 'Debugging';
      case 'code_review':
        return 'Code Review';
      case 'career':
        return 'Career';
      case 'job':
        return 'Job';
      case 'project':
        return 'Project';
      case 'advice':
        return 'Advice';
      case 'opinion':
        return 'Opinion';
      case 'recommendation':
        return 'Recommendation';
      case 'feedback':
        return 'Feedback';
      default:
        return type;
    }
  }

  dynamic _icon(String type) {
    switch (type) {
      case 'general':
        return HugeIcons.strokeRoundedMessage01;

      case 'technical':
        return HugeIcons.strokeRoundedComputer;

      case 'problem':
        return HugeIcons.strokeRoundedAlert02;

      case 'debugging':
        return HugeIcons.strokeRoundedBug01;

      case 'code_review':
        return HugeIcons.strokeRoundedCode;

      case 'career':
        return HugeIcons.strokeRoundedBriefcase01;

      case 'job':
        return HugeIcons.strokeRoundedJobSearch;

      case 'project':
        return HugeIcons.strokeRoundedFolder01;

      case 'advice':
        return HugeIcons.strokeRoundedIdea01;

      case 'opinion':
        return HugeIcons.strokeRoundedComment01;

      case 'recommendation':
        return HugeIcons.strokeRoundedStar;

      case 'feedback':
        return HugeIcons.strokeRoundedMessageAdd01;

      default:
        return HugeIcons.strokeRoundedMessage01;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Question Type',
          style: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
        ),

        const SizedBox(height: 5),

        Text(
          'Choose the type that best describes your question.',
          style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
        ),

        const SizedBox(height: 12),

        SizedBox(
          height: 42,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: types.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              final type = types[index];
              final bool selected = type == selectedType;

              return GestureDetector(
                onTap: () => onChanged(type),

                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),

                  padding: const EdgeInsets.symmetric(horizontal: 13),

                  decoration: BoxDecoration(
                    color: selected ? const Color(0xFFF0FDF4) : Colors.white,

                    borderRadius: BorderRadius.circular(12),

                    border: Border.all(
                      color: selected
                          ? const Color(0xFF84CC16)
                          : const Color(0xFFE2E8F0),
                      width: selected ? 1.4 : 1,
                    ),
                  ),

                  child: Row(
                    children: [
                      HugeIcon(
                        icon: _icon(type),
                        size: 17,
                        color: selected
                            ? const Color(0xFF65A30D)
                            : const Color(0xFF64748B),
                      ),

                      const SizedBox(width: 7),

                      Text(
                        _label(type),
                        style: TextStyle(
                          fontSize: 12.5,
                          fontWeight: selected
                              ? FontWeight.w700
                              : FontWeight.w500,
                          color: selected
                              ? const Color(0xFF65A30D)
                              : const Color(0xFF475569),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
