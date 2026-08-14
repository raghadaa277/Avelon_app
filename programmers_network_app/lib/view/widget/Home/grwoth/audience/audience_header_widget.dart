import 'package:flutter/material.dart';

import 'package:hugeicons/hugeicons.dart';

class AudienceHeaderWidget extends StatelessWidget {
  final VoidCallback onBack;

  const AudienceHeaderWidget({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 10),

      child: Column(
        children: [
          Row(
            children: [
              _HeaderButton(
                icon: HugeIcons.strokeRoundedArrowLeft01,
                onTap: onBack,
              ),

              Expanded(
                child: Column(
                  children: [
                    const HugeIcon(
                      icon: HugeIcons.strokeRoundedUserGroup,
                      size: 30,
                      color: Color.fromARGB(255, 211, 60, 103),
                    ),

                    const SizedBox(height: 4),

                    const Text(
                      'Audience Insights',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w800,
                        color: Color(0xFF111827),
                      ),
                    ),

                    const SizedBox(height: 2),

                    Text(
                      'Understand who views your content',
                      style: TextStyle(
                        fontSize: 13,
                        color: Colors.grey.shade500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeaderButton extends StatelessWidget {
  final List<List<dynamic>> icon;
  final VoidCallback onTap;

  const _HeaderButton({required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,

      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(14),

        child: Container(
          width: 48,
          height: 48,

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(14),

            border: Border.all(color: const Color(0xFFE7EAE7)),

            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(.025),
                blurRadius: 8,
                offset: const Offset(0, 3),
              ),
            ],
          ),

          child: Center(
            child: HugeIcon(
              icon: icon,
              size: 23,
              color: Color.fromARGB(255, 211, 60, 103),
            ),
          ),
        ),
      ),
    );
  }
}
