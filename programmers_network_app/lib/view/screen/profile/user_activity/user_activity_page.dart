import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:programmers_network_app/controller/Home/profile/user_session_controller.dart';
import 'package:programmers_network_app/core/const/color_const.dart';
import 'package:programmers_network_app/core/const/routesPage.dart';
import 'package:programmers_network_app/data/models/Profile/user_sessions/get_user_daily_model.dart';
import 'package:programmers_network_app/view/screen/profile/user_activity/activity_header_widget.dart';
import 'package:programmers_network_app/view/screen/profile/user_activity/period_selector_widget.dart';
import 'package:programmers_network_app/view/screen/profile/user_activity/session_list_widget.dart';
import 'package:programmers_network_app/view/screen/profile/user_activity/state_widget.dart';
import 'package:programmers_network_app/view/screen/profile/user_activity/tip_card_widget.dart';
import 'package:programmers_network_app/view/screen/profile/user_activity/usgae_formate_widget.dart';

class UserActivityScreen extends StatefulWidget {
  const UserActivityScreen({super.key});

  @override
  State<UserActivityScreen> createState() => _UserActivityScreenState();
}

class _UserActivityScreenState extends State<UserActivityScreen> {
  final UserSessionController controller = Get.put(UserSessionController());

  ActivityPeriod _selectedPeriod = ActivityPeriod.today;
  DateTime _selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  void _fetchData() {
    final isCustom = _selectedPeriod == ActivityPeriod.custom;
    controller.getUserDaily(
      _selectedPeriod.apiValue,
      customDate: isCustom ? _formatDateForApi(_selectedDate) : null,
    );
  }

  String _formatDateForApi(DateTime date) {
    return '${date.year}-${date.month}-${date.day}';
  }

  Future<void> _pickCustomDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
        _selectedPeriod = ActivityPeriod.custom;
      });
      _fetchData();
    }
  }

  void _onPeriodChanged(ActivityPeriod period) {
    if (period == ActivityPeriod.custom) {
      _pickCustomDate();
      return;
    }
    setState(() => _selectedPeriod = period);
    _fetchData();
  }

  String _formatFullDateLabel(DateTime date) {
    const months = [
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
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  String _periodSubtitleLabel() {
    switch (_selectedPeriod) {
      case ActivityPeriod.today:
      case ActivityPeriod.custom:
        return _formatFullDateLabel(_selectedDate);
      case ActivityPeriod.last7Days:
        return 'Last 7 Days';
      case ActivityPeriod.last30Days:
        return 'Last 30 Days';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConst.colorBackGroung,
      body: SafeArea(
        child: GetBuilder<UserSessionController>(
          builder: (ctrl) {
            final model = ctrl.dailyUsageModel;
            final details = model?.data.details;
            final days = model?.data.data ?? <DailyUsage>[];

            final totalTimeLabel = formatHoursToHms(details?.totalHours ?? 0.0);
            final appLaunchesCount = details?.numberOfAppLaunches ?? 0;

            return RefreshIndicator(
              onRefresh: () async => _fetchData(),
              child: ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.only(bottom: 24),
                children: [
                  ActivityHeader(
                    onBack: () => Get.offAllNamed(AppRoute.profilePage),
                    onCalendarTap: _pickCustomDate,
                  ),
                  const SizedBox(height: 8),
                  Container(
                    margin: const EdgeInsets.symmetric(horizontal: 12),
                    padding: const EdgeInsets.fromLTRB(4, 12, 4, 4),
                    decoration: BoxDecoration(
                      color: ColorConst.cardBg,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: ColorConst.border),
                    ),
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(left: 8, bottom: 8),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Select Period',
                              style: TextStyle(
                                fontSize: 12,
                                color: ColorConst.textGrey,
                              ),
                            ),
                          ),
                        ),
                        PeriodSelector(
                          selected: _selectedPeriod,
                          onChanged: _onPeriodChanged,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),

                  if (ctrl.isLoading)
                    const Padding(
                      padding: EdgeInsets.symmetric(vertical: 40),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else ...[
                    StatsSummary(
                      totalTimeLabel: totalTimeLabel,
                      appLaunchesCount: appLaunchesCount,
                    ),

                    SessionsList(
                      subtitleLabel: _periodSubtitleLabel(),
                      days: days,
                      onDayTap: (day) {},
                    ),

                    const TipCard(),
                  ],
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
