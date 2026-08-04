import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

import 'package:programmers_network_app/data/models/Home/search_model.dart';
import 'package:programmers_network_app/view/widget/Home/search/search_status_badge_widget.dart';

class SearchUserTileWidget extends StatelessWidget {
  final SearchUserModel user;
  final VoidCallback? onTap;

  const SearchUserTileWidget({super.key, required this.user, this.onTap});

  @override
  Widget build(BuildContext context) {
    final String? avatarUrl = user.userProfile?.avatarFullUrl;

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black,
                blurRadius: 10,
                offset: const Offset(7, 7),
              ),
            ],
          ),
          child: Row(
            children: [
              Stack(
                children: [
                  CircleAvatar(
                    radius: 28,
                    backgroundColor: Colors.grey.shade200,
                    backgroundImage: (avatarUrl != null && avatarUrl.isNotEmpty)
                        ? NetworkImage(avatarUrl)
                        : null,
                    child: (avatarUrl == null || avatarUrl.isEmpty)
                        ? HugeIcon(
                            icon: HugeIcons.strokeRoundedUser,
                            color: Colors.grey.shade400,
                            size: 28,
                          )
                        : null,
                  ),
                ],
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user.fullName,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      user.email,
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 13,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              SearchStatusBadgeWidget(followStatus: user.followStatus),
            ],
          ),
        ),
      ),
    );
  }
}
