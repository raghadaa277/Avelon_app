import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

class OverviewFilterWidget extends StatelessWidget {
  final bool isCustom;

  final DateTime? startDate;
  final DateTime? endDate;

  final VoidCallback onAllSelected;
  final VoidCallback onCustomSelected;

  final VoidCallback onStartDate;
  final VoidCallback onEndDate;

  const OverviewFilterWidget({
    super.key,
    required this.isCustom,
    required this.startDate,
    required this.endDate,
    required this.onAllSelected,
    required this.onCustomSelected,
    required this.onStartDate,
    required this.onEndDate,
  });

  static const Color primaryColor = Color.fromARGB(255, 206, 241, 130);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(20, 12, 20, 20),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE5E7EB)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Type',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: Color(0xFF374151),
            ),
          ),

          const SizedBox(height: 8),

          Row(
            children: [
              Expanded(
                child: _TypeButton(
                  title: 'All',
                  icon: HugeIcons.strokeRoundedAnalytics01,
                  selected: !isCustom,
                  onTap: onAllSelected,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: _TypeButton(
                  title: 'Custom',
                  icon: HugeIcons.strokeRoundedCalendar03,
                  selected: isCustom,
                  onTap: onCustomSelected,
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          Row(
            children: [
              Expanded(
                child: _DateField(
                  label: 'Start Date',
                  date: startDate,
                  enabled: isCustom,
                  onTap: onStartDate,
                ),
              ),

              const SizedBox(width: 12),

              Expanded(
                child: _DateField(
                  label: 'End Date',
                  date: endDate,
                  enabled: isCustom,
                  onTap: onEndDate,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _TypeButton extends StatelessWidget {
  final String title;
  final dynamic icon;
  final bool selected;
  final VoidCallback onTap;

  const _TypeButton({
    required this.title,
    required this.icon,
    required this.selected,
    required this.onTap,
  });

  static const Color primaryColor = Color.fromARGB(255, 206, 241, 130);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        height: 40,
        decoration: BoxDecoration(
          color: selected ? primaryColor : Colors.white,
          borderRadius: BorderRadius.circular(9),
          border: Border.all(
            color: selected ? primaryColor : const Color(0xFFE5E7EB),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            HugeIcon(icon: icon, size: 17, color: const Color(0xFF374151)),

            const SizedBox(width: 7),

            Text(
              title,
              style: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF374151),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DateField extends StatelessWidget {
  final String label;
  final DateTime? date;
  final bool enabled;
  final VoidCallback onTap;

  const _DateField({
    required this.label,
    required this.date,
    required this.enabled,
    required this.onTap,
  });

  String _formatDate(DateTime date) {
    return '${date.day.toString().padLeft(2, '0')}/'
        '${date.month.toString().padLeft(2, '0')}/'
        '${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF374151),
          ),
        ),

        const SizedBox(height: 7),

        GestureDetector(
          onTap: enabled ? onTap : null,
          child: Container(
            height: 42,
            padding: const EdgeInsets.symmetric(horizontal: 11),
            decoration: BoxDecoration(
              color: enabled ? Colors.white : const Color(0xFFF9FAFB),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: const Color(0xFFE5E7EB)),
            ),
            child: Row(
              children: [
                HugeIcon(
                  icon: HugeIcons.strokeRoundedCalendar03,
                  size: 17,
                  color: enabled
                      ? const Color(0xFF6B7280)
                      : const Color(0xFFD1D5DB),
                ),

                const SizedBox(width: 8),

                Expanded(
                  child: Text(
                    date == null ? '—' : _formatDate(date!),
                    style: TextStyle(
                      fontSize: 12,
                      color: enabled
                          ? const Color(0xFF374151)
                          : const Color(0xFFD1D5DB),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
