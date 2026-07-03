import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:programmers_network_app/controller/Home/onBoarding_controller.dart';
import 'package:programmers_network_app/core/const/color_const.dart';
import 'package:programmers_network_app/view/screen/Home/inspir_page.dart';
import 'package:programmers_network_app/view/widget/Home/goal_chip.dart';
import 'package:programmers_network_app/view/widget/Home/onBoarding_widget.dart';
import 'package:programmers_network_app/view/widget/logo.dart';

class GoalsPage extends StatefulWidget {
  final List<int> selectedSources;

  const GoalsPage({super.key, required this.selectedSources});

  @override
  State<GoalsPage> createState() => _GoalsPageState();
}

class _GoalsPageState extends State<GoalsPage> {
  late final OnboardingController _ctrl;
  final Set<int> _selectedIds = {};

  @override
  void initState() {
    super.initState();
    _ctrl = Get.find<OnboardingController>();
  }

  void _toggle(int id) {
    setState(() {
      _selectedIds.contains(id)
          ? _selectedIds.remove(id)
          : _selectedIds.add(id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnboardingController>(
      init: _ctrl,
      builder: (ctrl) {
        return Scaffold(
          backgroundColor: ColorConst.colorBackGroung,
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const BuildLogo(),
                        const SizedBox(height: 28),

                        Center(child: const OnboardingWidget(currentStep: 1)),
                        const SizedBox(height: 24),

                        Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(24),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.06),
                                blurRadius: 24,
                                offset: const Offset(0, 8),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(24),
                          child: Column(
                            children: [
                              Container(
                                width: 56,
                                height: 56,
                                decoration: BoxDecoration(
                                  color: const Color(0xFFF0FDF4),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: const Color(0xFFBBF7D0),
                                    width: 1.5,
                                  ),
                                ),
                                child: const Icon(
                                  Icons.flag_rounded,
                                  color: Color(0xFF16A34A),
                                  size: 26,
                                ),
                              ),
                              const SizedBox(height: 16),

                              const Text(
                                'What brings you to Avelon?',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w800,
                                  color: Color(0xFF111827),
                                  height: 1.25,
                                ),
                              ),
                              const SizedBox(height: 6),

                              const Text(
                                'Choose all that apply.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: Color(0xFF6B7280),
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(height: 20),

                              if (ctrl.isLoading)
                                const Padding(
                                  padding: EdgeInsets.symmetric(vertical: 32),
                                  child: Center(
                                    child: CircularProgressIndicator(
                                      color: ColorConst.colorButton,
                                    ),
                                  ),
                                )
                              else if (ctrl.errorMessage != null)
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 24,
                                  ),
                                  child: Text(
                                    ctrl.errorMessage!,
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      color: Colors.redAccent,
                                    ),
                                  ),
                                )
                              else
                                Builder(
                                  builder: (_) {
                                    final goals =
                                        ctrl.onboardingModel?.data.goals ?? [];
                                    if (goals.isEmpty)
                                      return const SizedBox.shrink();
                                    return ListView.separated(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: goals.length,
                                      separatorBuilder: (_, __) =>
                                          const SizedBox(height: 10),
                                      itemBuilder: (context, index) {
                                        final goal = goals[index];
                                        return GoalChip(
                                          goal: goal,
                                          isSelected: _selectedIds.contains(
                                            goal.id,
                                          ),
                                          onTap: () => _toggle(goal.id),
                                        );
                                      },
                                    );
                                  },
                                ),
                            ],
                          ),
                        ),

                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ),

                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 16,
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: _selectedIds.isEmpty
                          ? null
                          : () {
                              Get.to(
                                () => InspirationPage(
                                  selectedSources: widget.selectedSources,
                                  selectedGoals: _selectedIds.toList(),
                                ),
                                arguments: Get.arguments,
                              );
                            },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFF84CC16),
                        disabledBackgroundColor: const Color(
                          0xFF84CC16,
                        ).withValues(alpha: 0.4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14),
                        ),
                        elevation: 0,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Text(
                            'Continue',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: Colors.white,
                              letterSpacing: 0.3,
                            ),
                          ),
                          SizedBox(width: 8),
                          Icon(
                            Icons.arrow_forward,
                            size: 18,
                            color: Colors.white,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
