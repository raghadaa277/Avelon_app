import 'package:flutter/material.dart';
import 'package:programmers_network_app/view/widget/Home/grwoth/icon_contaniner_widget.dart';
import 'package:programmers_network_app/view/widget/Home/grwoth/main_chart_painter_widget.dart';

class GrowthMetricCard extends StatefulWidget {
  final String title;
  final dynamic data;
  final dynamic icon;
  final Color iconColor;
  final bool fullWidth;

  const GrowthMetricCard({
    required this.title,
    required this.data,
    required this.icon,
    required this.iconColor,
    this.fullWidth = false,
  });

  @override
  State<GrowthMetricCard> createState() => _GrowthMetricCardState();
}

class _GrowthMetricCardState extends State<GrowthMetricCard> {
  bool get isIncrease {
    final status = widget.data.status.toString().toLowerCase();

    return status.contains('increase') ||
        status.contains('up') ||
        status.contains('positive');
  }

  bool get isDecrease {
    final status = widget.data.status.toString().toLowerCase();

    return status.contains('decrease') ||
        status.contains('down') ||
        status.contains('negative');
  }

  @override
  Widget build(BuildContext context) {
    final percentage = widget.data.percentage as double;

    final statusColor = isIncrease
        ? const Color(0xFF20B879)
        : isDecrease
        ? const Color(0xFFE05272)
        : const Color(0xFF8A8F98);

    return Container(
      height: widget.fullWidth ? 100 : 132,
      padding: const EdgeInsets.fromLTRB(12, 12, 10, 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: const Color(0xFFE7E9ED)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.025),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: widget.fullWidth
          ? _buildFullWidth(percentage, statusColor)
          : _buildNormal(percentage, statusColor),
    );
  }

  Widget _buildNormal(double percentage, Color statusColor) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconContainer(icon: widget.icon, color: widget.iconColor),

            const SizedBox(width: 8),

            Expanded(
              child: Text(
                widget.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF374151),
                ),
              ),
            ),
          ],
        ),

        const Spacer(),

        Text(
          '${percentage.toStringAsFixed(2)}%',
          style: const TextStyle(
            fontSize: 23,
            fontWeight: FontWeight.w800,
            color: Color(0xFF1F2937),
          ),
        ),

        const SizedBox(height: 2),

        Row(
          children: [
            Icon(
              isDecrease
                  ? Icons.arrow_downward_rounded
                  : isIncrease
                  ? Icons.arrow_upward_rounded
                  : Icons.remove_rounded,
              size: 13,
              color: statusColor,
            ),

            const SizedBox(width: 3),

            Expanded(
              child: Text(
                _statusText(),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w600,
                  color: statusColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildFullWidth(double percentage, Color statusColor) {
    return Row(
      children: [
        IconContainer(icon: widget.icon, color: widget.iconColor),

        const SizedBox(width: 10),

        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: const TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF374151),
                ),
              ),

              const SizedBox(height: 5),

              Row(
                children: [
                  Text(
                    '${percentage.toStringAsFixed(2)}%',
                    style: const TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.w800,
                      color: Color(0xFF1F2937),
                    ),
                  ),

                  const SizedBox(width: 8),

                  Icon(
                    isDecrease
                        ? Icons.arrow_downward_rounded
                        : isIncrease
                        ? Icons.arrow_upward_rounded
                        : Icons.remove_rounded,
                    size: 13,
                    color: statusColor,
                  ),

                  const SizedBox(width: 3),

                  Text(
                    _statusText(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w600,
                      color: statusColor,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),

        SizedBox(
          width: 100,
          height: 55,
          child: CustomPaint(
            painter: MiniChartPainter(
              isIncrease: isIncrease,
              isDecrease: isDecrease,
            ),
          ),
        ),
      ],
    );
  }

  String _statusText() {
    if (isIncrease) return 'Increase';
    if (isDecrease) return 'Decrease';

    return 'Same';
  }
}
