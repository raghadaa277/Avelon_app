import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:programmers_network_app/controller/Home/onBoarding_controller.dart';
import 'package:programmers_network_app/core/const/color_const.dart';
import 'package:programmers_network_app/view/widget/Home/onBoarding_widget.dart';

import 'package:programmers_network_app/view/widget/Home/tage_slider.dart';
import 'package:programmers_network_app/view/widget/logo.dart';

class TagsPage extends StatefulWidget {
  final List<int> selectedSources;
  final List<int> selectedGoals;
  final List<int> selectedInspirations;

  const TagsPage({
    super.key,
    required this.selectedSources,
    required this.selectedGoals,
    required this.selectedInspirations,
  });

  @override
  State<TagsPage> createState() => _TagsPageState();
}

class _TagsPageState extends State<TagsPage> {
  late final OnboardingController _ctrl;
  final Map<int, double> _tagValues = {};
  final Map<int, bool> _activatedTags = {};

  @override
  void initState() {
    super.initState();
    _ctrl = Get.find<OnboardingController>();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<OnboardingController>(
      init: _ctrl,
      builder: (ctrl) {
        final tags = ctrl.onboardingModel?.data.tags ?? [];

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

                        const Center(child: OnboardingWidget(currentStep: 3)),
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
                                  Icons.tag_rounded,
                                  color: Color(0xFF16A34A),
                                  size: 26,
                                ),
                              ),
                              const SizedBox(height: 16),

                              const Text(
                                'Choose Your Interests',
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
                                'Select topics and tell us how much you care about them.',
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontSize: 13.5,
                                  color: Color(0xFF6B7280),
                                  height: 1.5,
                                ),
                              ),
                              const SizedBox(height: 20),

                              if (ctrl.isLoading && tags.isEmpty)
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
                              else if (tags.isEmpty)
                                const SizedBox.shrink()
                              else
                                ListView.separated(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: tags.length,
                                  separatorBuilder: (_, __) =>
                                      const SizedBox(height: 14),
                                  itemBuilder: (context, index) {
                                    final tag = tags[index];
                                    final isActivated =
                                        _activatedTags[tag.id] ?? false;
                                    final value = _tagValues[tag.id] ?? 1;

                                    return TagSliderTile(
                                      tag: tag,
                                      value: value,
                                      isActivated: isActivated,
                                      onChanged: (newValue) {
                                        setState(() {
                                          _activatedTags[tag.id] = true;
                                          _tagValues[tag.id] = newValue;
                                        });
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
                      onPressed: (ctrl.isLoading || _tagValues.isEmpty)
                          ? null
                          : () async {
                              final sources = ctrl.onboardingModel!.data.sources
                                  .where(
                                    (e) =>
                                        widget.selectedSources.contains(e.id),
                                  )
                                  .map((e) => e.name)
                                  .toList();

                              final goals = ctrl.onboardingModel!.data.goals
                                  .where(
                                    (e) => widget.selectedGoals.contains(e.id),
                                  )
                                  .map((e) => e.name)
                                  .toList();

                              final inspirations = ctrl
                                  .onboardingModel!
                                  .data
                                  .inspir
                                  .where(
                                    (e) => widget.selectedInspirations.contains(
                                      e.id,
                                    ),
                                  )
                                  .map((e) => e.name)
                                  .toList();

                              final selectedTags = ctrl
                                  .onboardingModel!
                                  .data
                                  .tags
                                  .where((e) => _tagValues.containsKey(e.id))
                                  .map(
                                    (e) => {
                                      'name': e.name,
                                      'weight': _tagValues[e.id]!.round(),
                                    },
                                  )
                                  .toList();

                              await ctrl.completeOnboarding(
                                sources: sources,
                                goals: goals,
                                inspirations: inspirations,
                                tags: selectedTags,
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
                      child: ctrl.isLoading
                          ? const SizedBox(
                              width: 22,
                              height: 22,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.4,
                                color: Colors.white,
                              ),
                            )
                          : Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: const [
                                Text(
                                  'Finish',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    letterSpacing: 0.3,
                                  ),
                                ),
                                SizedBox(width: 8),
                                Icon(
                                  Icons.check_rounded,
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
