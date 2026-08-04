import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:programmers_network_app/core/const/post_color.dart';

class PillInfo {
  final List<List> icon;
  final Color color;
  final String label;
  const PillInfo(this.icon, this.color, this.label);
}

PillInfo postTypeInfo(String type) {
  switch (type) {
    case 'article':
      return const PillInfo(
        HugeIcons.strokeRoundedFile02,
        PostColors.typeArticle,
        'Article',
      );
    case 'project':
      return const PillInfo(
        HugeIcons.strokeRoundedComputer,
        PostColors.typeProject,
        'Project',
      );
    case 'question':
      return const PillInfo(
        HugeIcons.strokeRoundedMessageQuestion,
        PostColors.typeQuestion,
        'Question',
      );
    case 'problem':
      return const PillInfo(
        HugeIcons.strokeRoundedAlert02,
        PostColors.typeProblem,
        'Problem',
      );
    default:
      return const PillInfo(
        HugeIcons.strokeRoundedPill,
        PostColors.typeArticle,
        '',
      );
  }
}

PillInfo postVisibilityInfo(String visibility) {
  switch (visibility) {
    case 'public':
      return const PillInfo(
        HugeIcons.strokeRoundedGlobe02,
        PostColors.visibilityPublic,
        'Public',
      );
    case 'followers':
      return const PillInfo(
        HugeIcons.strokeRoundedUserAdd01,
        PostColors.visibilityFollowers,
        'Followers',
      );
    case 'close_friends':
      return const PillInfo(
        HugeIcons.strokeRoundedStar,
        PostColors.visibilityCloseFriends,
        'Close friends',
      );
    case 'only_me':
      return const PillInfo(
        HugeIcons.strokeRoundedSquareLock02,
        PostColors.visibilityOnlyMe,
        'Only me',
      );
    default:
      return const PillInfo(
        HugeIcons.strokeRoundedUserAdd01,
        PostColors.visibilityFollowers,
        '',
      );
  }
}

PillInfo followStatusInfo(String? followStatus) {
  switch (followStatus) {
    case 'following':
      return const PillInfo(
        HugeIcons.strokeRoundedUserAdd02,
        PostColors.followFollowing,
        'Following',
      );
    case 'mutual':
      return const PillInfo(
        HugeIcons.strokeRoundedUserGroup,
        PostColors.followMutual,
        'Mutual',
      );
    default:
      return const PillInfo(
        HugeIcons.strokeRoundedUser,
        PostColors.followNone,
        'None',
      );
  }
}
