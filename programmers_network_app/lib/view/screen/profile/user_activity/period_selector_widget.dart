import 'package:flutter/material.dart';
import 'package:programmers_network_app/core/const/color_const.dart';

enum ActivityPeriod { today, last7Days, last30Days, custom }

extension ActivityPeriodFilter on ActivityPeriod {
  String get apiValue {
    switch (this) {
      case ActivityPeriod.today:
        return 'today';
      case ActivityPeriod.last7Days:
        return 'last_7_days';
      case ActivityPeriod.last30Days:
        return 'last_30_days';
      case ActivityPeriod.custom:
        return 'custome_date';
    }
  }
}

class PeriodSelector extends StatelessWidget {
  final ActivityPeriod selected;
  final ValueChanged<ActivityPeriod> onChanged;

  const PeriodSelector({
    super.key,
    required this.selected,
    required this.onChanged,
  });

  Widget _item({
    required ActivityPeriod period,
    required IconData icon,
    required String label,
  }) {
    final bool isSelected = period == selected;
    return Expanded(
      child: GestureDetector(
        onTap: () => onChanged(period),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          padding: const EdgeInsets.symmetric(vertical: 10),
          decoration: BoxDecoration(
            color: isSelected ? ColorConst.lightGreenBg : ColorConst.cardBg,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: isSelected ? ColorConst.primaryGreen : ColorConst.border,
              width: isSelected ? 1.4 : 1,
            ),
          ),
          child: Column(
            children: [
              Icon(
                icon,
                size: 18,
                color: isSelected
                    ? ColorConst.primaryGreen
                    : ColorConst.textGrey,
              ),
              const SizedBox(height: 6),
              Text(
                label,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12.5,
                  fontWeight: isSelected ? FontWeight.w700 : FontWeight.w500,
                  color: isSelected
                      ? ColorConst.primaryGreen
                      : ColorConst.textDark,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Row(
        children: [
          _item(
            period: ActivityPeriod.today,
            icon: Icons.calendar_today_outlined,
            label: 'Today',
          ),
          _item(
            period: ActivityPeriod.last7Days,
            icon: Icons.bar_chart_rounded,
            label: 'Last 7 Days',
          ),
          _item(
            period: ActivityPeriod.last30Days,
            icon: Icons.calendar_month_outlined,
            label: 'Last 30 Days',
          ),
          _item(
            period: ActivityPeriod.custom,
            icon: Icons.event_note_outlined,
            label: 'Custom Date',
          ),
        ],
      ),
    );
  }
}
