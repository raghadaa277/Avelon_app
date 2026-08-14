import 'package:flutter/material.dart';
import 'package:programmers_network_app/core/const/color_const.dart';
import 'package:programmers_network_app/data/models/Home/growth/get_growth_model.dart';
import 'package:programmers_network_app/view/widget/Home/grwoth/overall_grwoth_widget.dart';

class OverallGrowthCard extends StatefulWidget {
  final OverallGrowthModel growth;
  final String period;

  const OverallGrowthCard({
    super.key,
    required this.growth,
    required this.period,
  });

  @override
  State<OverallGrowthCard> createState() => _OverallGrowthCardState();
}

class _OverallGrowthCardState extends State<OverallGrowthCard> {
  bool get isIncrease {
    return widget.growth.status.toLowerCase().contains('increase') ||
        widget.growth.status.toLowerCase().contains('up');
  }

  @override
  Widget build(BuildContext context) {
    final percentage = widget.growth.percentage;

    return Container(
      height: 190,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE8E8EC)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.035),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 18,
            bottom: 18,
            width: 3,
            child: Container(
              decoration: const BoxDecoration(
                color: ColorConst.colorButton,
                borderRadius: BorderRadius.horizontal(
                  right: Radius.circular(4),
                ),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.fromLTRB(28, 22, 18, 18),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Overall Growth',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w800,
                    color: Colors.pinkAccent[400],
                  ),
                ),

                const SizedBox(height: 3),

                Text(
                  _periodTitle(widget.period),
                  style: const TextStyle(
                    fontSize: 12,
                    color: Color(0xFF6B7280),
                  ),
                ),

                const Spacer(),

                Text(
                  '${percentage >= 0 ? '+' : ''}${percentage.toStringAsFixed(2)}%',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w900,
                    color: Colors.pinkAccent[100],
                  ),
                ),

                const SizedBox(height: 2),

                Text(
                  isIncrease ? 'Growth increased' : widget.growth.status,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF6B7280),
                  ),
                ),
              ],
            ),
          ),

          Positioned(right: 10, bottom: 15, child: GrowthIllustration()),
        ],
      ),
    );
  }

  String _periodTitle(String value) {
    if (value.isEmpty) return '';

    return value
        .replaceAll('_', ' ')
        .split(' ')
        .map((e) => e.isEmpty ? e : '${e[0].toUpperCase()}${e.substring(1)}')
        .join(' ');
  }
}
