import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class PasswordStrengthCard extends StatelessWidget {
  final bool hasMinLength;
  final bool hasUpperAndLower;
  final bool hasNumber;
  final bool hasSpecialChar;

  const PasswordStrengthCard({
    super.key,
    required this.hasMinLength,
    required this.hasUpperAndLower,
    required this.hasNumber,
    required this.hasSpecialChar,
  });

  int get strength {
    int score = 0;

    if (hasMinLength) score++;
    if (hasUpperAndLower) score++;
    if (hasNumber) score++;
    if (hasSpecialChar) score++;

    return score;
  }

  String get strengthText {
    switch (strength) {
      case 4:
        return "Excellent";
      case 3:
        return "Strong";
      case 2:
        return "Medium";
      case 1:
        return "Weak";
      default:
        return "Poor";
    }
  }

  @override
  Widget build(BuildContext context) {
    const lime = Color(0xFFB7F51A);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: const Color(0xFFEAEAEA)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Password Strength",
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF374151),
                ),
              ),

              Text(
                strengthText,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: lime,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          Row(
            children: List.generate(
              5,
              (index) => Expanded(
                child: Container(
                  margin: EdgeInsets.only(right: index == 4 ? 0 : 6),
                  height: 5,
                  decoration: BoxDecoration(
                    color: index < strength ? lime : const Color(0xFFE5E7EB),
                    borderRadius: BorderRadius.circular(100),
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 18),

          _RequirementItem(text: "12+ characters", isValid: hasMinLength),

          const SizedBox(height: 10),

          _RequirementItem(
            text: "Uppercase & lowercase",
            isValid: hasUpperAndLower,
          ),

          const SizedBox(height: 10),

          _RequirementItem(text: "Number included", isValid: hasNumber),

          const SizedBox(height: 10),

          _RequirementItem(text: "Special character", isValid: hasSpecialChar),
        ],
      ),
    );
  }
}

class _RequirementItem extends StatelessWidget {
  final String text;
  final bool isValid;

  const _RequirementItem({required this.text, required this.isValid});

  @override
  Widget build(BuildContext context) {
    const lime = Color(0xFFB7F51A);

    return Row(
      children: [
        HugeIcon(
          icon: HugeIcons.strokeRoundedCheckmarkCircle02,
          size: 18,
          color: isValid ? lime : const Color(0xFFD1D5DB),
        ),

        const SizedBox(width: 10),

        Text(
          text,
          style: TextStyle(
            fontSize: 14,
            color: isValid ? const Color(0xFF4B5563) : const Color(0xFF9CA3AF),
          ),
        ),
      ],
    );
  }
}
