import 'package:flutter/material.dart';
import 'package:programmers_network_app/data/models/Home/OnBoarding/onboarding_model.dart';

({IconData icon, Color color}) tagStyle(String name) {
  switch (name.toLowerCase()) {
    case 'php':
      return (icon: Icons.code_rounded, color: const Color(0xFF777BB4));
    case 'laravel':
      return (icon: Icons.layers_rounded, color: const Color(0xFFFF2D20));
    case 'javascript':
      return (icon: Icons.javascript_rounded, color: const Color(0xFFF7DF1E));
    case 'typescript':
      return (icon: Icons.code_rounded, color: const Color(0xFF3178C6));
    case 'python':
      return (icon: Icons.code_rounded, color: const Color(0xFF3776AB));
    case 'java':
      return (icon: Icons.coffee_rounded, color: const Color(0xFFEA2D2E));
    case 'cpp':
      return (icon: Icons.memory_rounded, color: const Color(0xFF00599C));
    case 'csharp':
      return (icon: Icons.code_rounded, color: const Color(0xFF239120));
    case 'go':
      return (icon: Icons.bolt_rounded, color: const Color(0xFF00ADD8));
    case 'rust':
      return (icon: Icons.settings_rounded, color: const Color(0xFFB7410E));
    case 'react':
      return (icon: Icons.hub_rounded, color: const Color(0xFF61DAFB));
    case 'nextjs':
      return (icon: Icons.code_rounded, color: const Color(0xFF111827));
    case 'vuejs':
      return (icon: Icons.hub_rounded, color: const Color(0xFF4FC08D));
    case 'angular':
      return (icon: Icons.hub_rounded, color: const Color(0xFFDD0031));
    case 'nodejs':
      return (icon: Icons.dns_rounded, color: const Color(0xFF339933));
    case 'expressjs':
      return (icon: Icons.dns_rounded, color: const Color(0xFF404040));
    case 'django':
      return (icon: Icons.code_rounded, color: const Color(0xFF0C4B33));
    case 'flutter':
      return (icon: Icons.flutter_dash_rounded, color: const Color(0xFF02569B));
    case 'mysql':
      return (icon: Icons.storage_rounded, color: const Color(0xFF4479A1));
    case 'postgresql':
      return (icon: Icons.storage_rounded, color: const Color(0xFF336791));
    case 'mongodb':
      return (icon: Icons.storage_rounded, color: const Color(0xFF47A248));
    case 'redis':
      return (icon: Icons.storage_rounded, color: const Color(0xFFDC382D));
    case 'docker':
      return (icon: Icons.inventory_2_rounded, color: const Color(0xFF2496ED));
    case 'kubernetes':
      return (icon: Icons.hub_rounded, color: const Color(0xFF326CE5));
    case 'git':
      return (icon: Icons.merge_type_rounded, color: const Color(0xFFF05032));
    case 'linux':
      return (icon: Icons.terminal_rounded, color: const Color(0xFFFCC624));
    case 'artificial_intelligence':
      return (icon: Icons.psychology_rounded, color: const Color(0xFF8B5CF6));
    case 'machine_learning':
      return (icon: Icons.smart_toy_rounded, color: const Color(0xFF06B6D4));
    case 'deep_learning':
      return (icon: Icons.account_tree_rounded, color: const Color(0xFF6366F1));
    case 'computer_vision':
      return (icon: Icons.visibility_rounded, color: const Color(0xFFF59E0B));
    case 'natural_language_processing':
      return (icon: Icons.translate_rounded, color: const Color(0xFF14B8A6));
    case 'cybersecurity':
      return (icon: Icons.shield_rounded, color: const Color(0xFFEF4444));
    case 'networking':
      return (icon: Icons.lan_rounded, color: const Color(0xFF0EA5E9));
    case 'system_design':
      return (icon: Icons.architecture_rounded, color: const Color(0xFF6366F1));
    case 'devops':
      return (
        icon: Icons.settings_suggest_rounded,
        color: const Color(0xFF0EA5E9),
      );
    case 'cloud_computing':
      return (icon: Icons.cloud_rounded, color: const Color(0xFFFF9900));
    case 'aws':
      return (icon: Icons.cloud_queue_rounded, color: const Color(0xFFFF9900));
    case 'rest_api':
      return (icon: Icons.api_rounded, color: const Color(0xFF10B981));
    case 'graphql':
      return (icon: Icons.hub_rounded, color: const Color(0xFFE10098));
    case 'data_science':
      return (icon: Icons.bar_chart_rounded, color: const Color(0xFFF59E0B));
    case 'mobile_development':
      return (icon: Icons.smartphone_rounded, color: const Color(0xFF3B82F6));
    default:
      return (icon: Icons.tag_rounded, color: const Color(0xFF6B7280));
  }
}

class TagSliderTile extends StatelessWidget {
  final TagsModel tag;
  final double value;
  final ValueChanged<double> onChanged;
  final bool isActivated;

  const TagSliderTile({
    super.key,
    required this.tag,
    required this.value,
    required this.onChanged,
    required this.isActivated,
  });

  static const Color _activeColor = Color(0xFF84CC16);
  static const Color _trackColor = Color(0xFFE5E7EB);
  static const Color _labelColor = Color(0xFF9CA3AF);

  static double _weightToIndex(double weight) {
    if (weight <= 2) return 0;
    if (weight <= 7) return 1;
    return 2;
  }

  @override
  Widget build(BuildContext context) {
    final style = tagStyle(tag.name);
    final sliderIndex = _weightToIndex(value).clamp(0, 2).toDouble();

    final active = isActivated;

    return GestureDetector(
      onTap: () {
        if (!active) {
          onChanged(1);
        }
      },
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFF9FAFB),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: const Color(0xFFF3F4F6)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 36,
                  height: 36,
                  decoration: BoxDecoration(
                    color: active
                        ? style.color.withValues(alpha: 0.12)
                        : const Color(0xFFE5E7EB),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  alignment: Alignment.center,
                  child: Icon(
                    style.icon,
                    size: 19,
                    color: active ? style.color : const Color(0xFF9CA3AF),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    tag.label.isNotEmpty ? tag.label : tag.name,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF111827),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 4),

            Row(
              children: [
                const Text(
                  'Low',
                  style: TextStyle(fontSize: 11, color: _labelColor),
                ),

                Expanded(
                  child: SliderTheme(
                    data: SliderTheme.of(context).copyWith(
                      activeTrackColor: active ? _activeColor : _trackColor,
                      inactiveTrackColor: _trackColor,
                      trackHeight: 4,
                      thumbColor: active
                          ? _activeColor
                          : const Color(0xFF9CA3AF),
                      overlayColor: _activeColor.withValues(alpha: 0.15),
                      thumbShape: _ValueThumbShape(value: value),
                    ),
                    child: Slider(
                      value: sliderIndex,
                      min: 0,
                      max: 2,
                      divisions: 2,

                      onChanged: active
                          ? (v) {
                              double weight;

                              if (v == 0) {
                                weight = 1;
                              } else if (v == 1) {
                                weight = 5;
                              } else {
                                weight = 10;
                              }

                              onChanged(weight);
                            }
                          : null,
                    ),
                  ),
                ),

                const Text(
                  'High',
                  style: TextStyle(fontSize: 11, color: _labelColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _ValueThumbShape extends SliderComponentShape {
  final double value;

  const _ValueThumbShape({required this.value});

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => const Size(26, 26);

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {
    final Canvas canvas = context.canvas;

    final Paint borderPaint = Paint()
      ..color = Colors.white
      ..style = PaintingStyle.fill;
    canvas.drawCircle(center, 14, borderPaint);

    final Paint fillPaint = Paint()
      ..color = sliderTheme.thumbColor ?? const Color(0xFF84CC16);
    canvas.drawCircle(center, 12, fillPaint);

    final TextSpan textSpan = TextSpan(
      text: this.value.round().toString(),
      style: const TextStyle(
        color: Colors.white,
        fontSize: 11,
        fontWeight: FontWeight.w700,
      ),
    );
    final TextPainter textPainter = TextPainter(
      text: textSpan,
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
    );
    textPainter.layout();
    textPainter.paint(
      canvas,
      center - Offset(textPainter.width / 2, textPainter.height / 2),
    );
  }
}
