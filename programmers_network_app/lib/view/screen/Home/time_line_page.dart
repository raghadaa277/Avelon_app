import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:programmers_network_app/controller/Home/get_time_line_controller.dart';
import 'package:programmers_network_app/core/const/color_const.dart';
import 'package:programmers_network_app/data/models/Home/get_time_line_model.dart';

const String _kUnitLabel = 'Followers';
const String _kUnitLabelSingular = 'Follower';

const Color _kTimelineRose = Color(0xFFD98A9E);

class FollowersTimelinePage extends StatefulWidget {
  const FollowersTimelinePage({super.key});

  @override
  State<FollowersTimelinePage> createState() => _FollowersTimelinePageState();
}

class _FollowersTimelinePageState extends State<FollowersTimelinePage> {
  final GetTimeLineController controller = Get.put(GetTimeLineController());

  @override
  void initState() {
    super.initState();
    controller.getTimeLine();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.colorBackGroung,
      appBar: AppBar(
        backgroundColor: ColorConst.colorBackGroung,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, size: 18),
          color: ColorConst.textDark,
          onPressed: () => Navigator.of(context).maybePop(),
        ),
        title: const Text(
          'Followers Timeline',
          style: TextStyle(
            color: ColorConst.textDark,
            fontSize: 17,
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
          IconButton(
            icon: const HugeIcon(
              icon: HugeIcons.strokeRoundedFilterHorizontal,
              color: ColorConst.primaryGreen,
            ),
            onPressed: () {},
          ),
        ],
      ),
      body: GetBuilder<GetTimeLineController>(
        init: controller,
        builder: (controller) {
          if (controller.isLoading && controller.data.isEmpty) {
            return const SizedBox.shrink();
          }

          if (controller.errorMessage.value.isNotEmpty &&
              controller.data.isEmpty) {
            return Center(
              child: Text(
                controller.errorMessage.value,
                style: const TextStyle(color: ColorConst.textGrey),
              ),
            );
          }

          if (controller.data.isEmpty) {
            return const Center(
              child: Text(
                "No history yet",
                style: TextStyle(color: ColorConst.textGrey, fontSize: 14),
              ),
            );
          }

          final entries = controller.data;

          return RefreshIndicator(
            color: ColorConst.primaryGreen,
            onRefresh: () => controller.getTimeLine(),
            child: ListView(
              physics: const AlwaysScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
              children: [
                _LatestCard(
                  latest: entries.first,
                  previous: entries.length > 1 ? entries[1] : null,
                ),
                const SizedBox(height: 22),
                for (int i = 0; i < entries.length; i++)
                  _TimelineRow(
                    entry: entries[i],
                    isLast: i == entries.length - 1,
                  ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _LatestCard extends StatelessWidget {
  final DataTimeLine latest;
  final DataTimeLine? previous;

  const _LatestCard({required this.latest, this.previous});

  @override
  Widget build(BuildContext context) {
    final delta = previous != null ? latest.value - previous!.value : null;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ColorConst.colorBackGroung,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(18),
              color: ColorConst.colorButton,
            ),
            child: const Center(
              child: HugeIcon(
                icon: HugeIcons.strokeRoundedUserGroup,
                color: ColorConst.textDark,
                size: 28,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Latest $_kUnitLabel',
                  style: const TextStyle(
                    fontSize: 12.5,
                    color: ColorConst.textGrey,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _formatNumber(latest.value),
                  style: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w800,
                    color: ColorConst.primaryGreen,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  _formatFull(latest.createdAt),
                  style: const TextStyle(
                    fontSize: 12,
                    color: ColorConst.textGrey,
                  ),
                ),
              ],
            ),
          ),
          if (delta != null)
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.6),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      HugeIcon(
                        icon: delta >= 0
                            ? HugeIcons.strokeRoundedArrowUp01
                            : HugeIcons.strokeRoundedArrowDown01,
                        size: 13,
                        color: delta >= 0 ? green : red,
                      ),
                      const SizedBox(width: 2),
                      Text(
                        '${delta >= 0 ? '+' : ''}${_formatNumber(delta)}',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: delta >= 0 ? green : red,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    'vs previous',
                    style: TextStyle(
                      fontSize: 10.5,
                      color: ColorConst.textGrey,
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

class _TimelineRow extends StatelessWidget {
  final DataTimeLine entry;
  final bool isLast;

  const _TimelineRow({required this.entry, required this.isLast});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 22,
            child: Column(
              children: [
                Container(
                  width: 10,
                  height: 10,
                  margin: const EdgeInsets.only(top: 22),
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: _kTimelineRose,
                  ),
                ),
                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin: const EdgeInsets.symmetric(vertical: 2),
                      color: _kTimelineRose.withOpacity(0.35),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 14),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  color: ColorConst.cardBg,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: ColorConst.border),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 3),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _formatDate(entry.createdAt),
                            style: const TextStyle(
                              fontSize: 14.5,
                              fontWeight: FontWeight.w700,
                              color: _kTimelineRose,
                            ),
                          ),
                          const SizedBox(height: 3),
                          Text(
                            _formatTime(entry.createdAt),
                            style: const TextStyle(
                              fontSize: 12.5,
                              color: ColorConst.textGrey,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          _formatNumber(entry.value),
                          style: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            color: ColorConst.primaryGreen,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          entry.value == 1 ? _kUnitLabelSingular : _kUnitLabel,
                          style: const TextStyle(
                            fontSize: 12,
                            color: ColorConst.textGrey,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const _months = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];

String _formatNumber(int? n) {
  if (n == null) return '';
  final s = n.abs().toString();
  final buffer = StringBuffer();
  for (int i = 0; i < s.length; i++) {
    if (i != 0 && (s.length - i) % 3 == 0) buffer.write(',');
    buffer.write(s[i]);
  }
  return (n < 0 ? '-' : '') + buffer.toString();
}

String _formatDate(String? iso) {
  final d = DateTime.tryParse(iso ?? '');
  if (d == null) return '';
  final day = d.day.toString().padLeft(2, '0');
  return '${_months[d.month - 1]} $day, ${d.year}';
}

String _formatTime(String? iso) {
  final d = DateTime.tryParse(iso ?? '');
  if (d == null) return '';
  final hour = d.hour % 12 == 0 ? 12 : d.hour % 12;
  final period = d.hour >= 12 ? 'PM' : 'AM';
  final minute = d.minute.toString().padLeft(2, '0');
  return '$hour:$minute $period';
}

String _formatFull(String? iso) {
  final d = DateTime.tryParse(iso ?? '');
  if (d == null) return '';
  return '${_formatDate(iso)} • ${_formatTime(iso)}';
}
