import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:programmers_network_app/core/const/color_const.dart';

class ClearAllHistoryDialog extends StatelessWidget {
  const ClearAllHistoryDialog({super.key, required this.onConfirm});

  final VoidCallback onConfirm;

  static const Color _text = Color(0xff171A17);
  static const Color _muted = Color(0xff858B84);
  static const Color _danger = Color(0xffD94A4A);
  static const Color _dangerBackground = Color(0xffFDEEEE);
  static const Color _cancelBackground = Color(0xffF1F2EF);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      elevation: 0,
      insetPadding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.fromLTRB(22, 24, 22, 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(26),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.10),
              blurRadius: 30,
              offset: const Offset(0, 10),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icon
            Container(
              width: 58,
              height: 58,
              decoration: BoxDecoration(
                color: _dangerBackground,
                borderRadius: BorderRadius.circular(18),
              ),
              child: const Center(
                child: HugeIcon(
                  icon: HugeIcons.strokeRoundedDelete02,
                  size: 27,
                  color: _danger,
                ),
              ),
            ),

            const SizedBox(height: 18),

            // Title
            const Text(
              'Clear search history?',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _text,
                fontSize: 20,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.45,
              ),
            ),

            const SizedBox(height: 8),

            // Description
            const Text(
              'All of your recent searches will be removed. '
              'This action cannot be undone.',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: _muted,
                fontSize: 13,
                height: 1.45,
                fontWeight: FontWeight.w500,
              ),
            ),

            const SizedBox(height: 24),

            // Buttons
            Row(
              children: [
                Expanded(
                  child: SizedBox(
                    height: 46,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: _cancelBackground,
                        foregroundColor: _text,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        'Cancel',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 10),

                Expanded(
                  child: SizedBox(
                    height: 46,
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                        onConfirm();
                      },
                      style: TextButton.styleFrom(
                        backgroundColor: ColorConst.colorApp,
                        foregroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                      ),
                      child: const Text(
                        'Clear all',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
