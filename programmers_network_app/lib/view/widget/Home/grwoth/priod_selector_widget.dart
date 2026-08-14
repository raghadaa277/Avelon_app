import 'package:flutter/material.dart';
import 'package:programmers_network_app/controller/Home/get_grwoth_controller.dart';

import 'package:programmers_network_app/core/helper/growth.dart';

class PeriodSelectorGrowth extends StatefulWidget {
  final GrowthController controller;

  const PeriodSelectorGrowth({super.key, required this.controller});

  @override
  State<PeriodSelectorGrowth> createState() => PeriodSelectorState();
}

class PeriodSelectorState extends State<PeriodSelectorGrowth> {
  String _label(GrowthPeriod period) {
    final value = period.value.toLowerCase();

    switch (value) {
      case 'today':
        return 'Today';

      case '7_days':
      case '7days':
      case '7-days':
        return '7 Days';

      case '30_days':
      case '30days':
      case '30-days':
        return '30 Days';

      case 'this_month':
      case 'thismonth':
      case 'this-month':
        return 'This Month';

      case 'this_year':
      case 'thisyear':
      case 'this-year':
        return 'This Year';

      default:
        return value
            .replaceAll('_', ' ')
            .split(' ')
            .map(
              (e) => e.isEmpty ? e : '${e[0].toUpperCase()}${e.substring(1)}',
            )
            .join(' ');
    }
  }

  @override
  Widget build(BuildContext context) {
    final periods = GrowthPeriod.values;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Time Range',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: Color(0xFF6B7280),
          ),
        ),

        const SizedBox(height: 8),

        Container(
          height: 45,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(13),
            border: Border.all(color: const Color(0xFFE5E7EB)),
          ),
          child: Row(
            children: periods.map((period) {
              final selected = widget.controller.currentPeriod == period;

              return Expanded(
                child: GestureDetector(
                  onTap: widget.controller.isLoading
                      ? null
                      : () {
                          widget.controller.changePeriod(period);
                        },
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    margin: const EdgeInsets.all(3),
                    decoration: BoxDecoration(
                      color: selected ? Colors.pink[100] : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      _label(period),
                      style: TextStyle(
                        fontSize: 11,
                        fontWeight: selected
                            ? FontWeight.w700
                            : FontWeight.w500,
                        color: selected
                            ? Colors.white
                            : const Color(0xFF6B7280),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
