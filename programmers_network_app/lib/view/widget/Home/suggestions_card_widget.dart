import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:programmers_network_app/controller/Home/personalPage/profile_view_controller.dart';
import 'package:programmers_network_app/controller/Home/posts/edit_post_controller.dart';
import 'package:programmers_network_app/controller/Home/reactions_controller.dart';

import 'package:programmers_network_app/controller/Home/suggestions/suggestions_controller.dart';
import 'package:programmers_network_app/data/models/Home/suggestions/get_suggestions_model.dart';
import 'package:programmers_network_app/view/screen/Home/personalPage/other_user_profile_page.dart';

class SuggestionUserCard extends StatelessWidget {
  final SuggestionModel suggestion;
  final ProfileViewController profileViewController;

  const SuggestionUserCard({
    super.key,
    required this.suggestion,
    required this.profileViewController,
  });

  Future<void> openProfile(BuildContext context) async {
    await profileViewController.suggestionsView(suggestion.id);

    if (!Get.isRegistered<ReactionsController>()) {
      Get.put(ReactionsController());
    }
    if (!Get.isRegistered<EditPostController>()) {
      Get.put(EditPostController());
    }

    Get.to(
      () => OtherUserProfilePage(targetUserId: suggestion.suggestedUser.id),
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = suggestion.suggestedUser;
    final profile = user.userProfile;

    final SuggestionsController controller = Get.find<SuggestionsController>();

    return VisibilityDetector(
      key: ValueKey('suggestion-view-${suggestion.id}'),
      onVisibilityChanged: (info) {
        if (info.visibleFraction >= 0.6) {
          profileViewController.suggestionsView(suggestion.id);
        }
      },
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () => openProfile(context),
        child: Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(14),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                CircleAvatar(
                  radius: 25,
                  backgroundColor: const Color(0xFFF1F2F3),
                  backgroundImage: profile.avatarFullUrl != null
                      ? NetworkImage(profile.avatarFullUrl!)
                      : null,
                  child: profile.avatarFullUrl == null
                      ? const Icon(Icons.person_outline, color: Colors.grey)
                      : null,
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        user.fullName,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                        ),
                      ),

                      const SizedBox(height: 3),

                      Text(
                        "@${profile.username}",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 8),

                Obx(() {
                  final isIgnoring = controller.isIgnoring(suggestion.id);

                  return SizedBox(
                    height: 36,
                    child: OutlinedButton(
                      onPressed: isIgnoring
                          ? null
                          : () async {
                              await controller.ignoreSuggestion(
                                id: suggestion.id,
                              );
                            },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.grey.shade700,
                        disabledForegroundColor: Colors.grey.shade400,
                        side: BorderSide(
                          color: isIgnoring
                              ? Colors.grey.shade200
                              : Colors.grey.shade300,
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: isIgnoring
                          ? const SizedBox(
                              width: 15,
                              height: 15,
                              child: CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Color(0xffB8FF1A),
                              ),
                            )
                          : const Text(
                              'Ignore',
                              style: TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                    ),
                  );
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
