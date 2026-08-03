import 'package:flutter/material.dart';
import 'package:programmers_network_app/view/widget/Home/personalProfile/profile_theme_widget.dart';

enum IndicatorKind { closeFriend, muted, reported }

class StatusIndicatorBadgeWidget extends StatelessWidget {
  final IndicatorKind kind;

  final bool actionTakenByMe;

  final bool showLabel;

  const StatusIndicatorBadgeWidget({
    super.key,
    required this.kind,
    this.actionTakenByMe = true,
    this.showLabel = false,
  });

  IconData get _icon {
    switch (kind) {
      case IndicatorKind.closeFriend:
        return Icons.star;
      case IndicatorKind.muted:
        return Icons.volume_off;
      case IndicatorKind.reported:
        return Icons.flag;
    }
  }

  Color get _color {
    switch (kind) {
      case IndicatorKind.closeFriend:
        return ProfileTheme.closeFriendGold;
      case IndicatorKind.muted:
        return ProfileTheme.mutedOrange;
      case IndicatorKind.reported:
        return ProfileTheme.reportedRed;
    }
  }

  String get _label {
    switch (kind) {
      case IndicatorKind.closeFriend:
        return actionTakenByMe
            ? 'Close Friend (You added)'
            : 'Added You to Close Friends';
      case IndicatorKind.muted:
        return actionTakenByMe ? 'Muted (You muted)' : 'Muted You';
      case IndicatorKind.reported:
        return actionTakenByMe ? 'Reported (You reported)' : 'Reported You';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!showLabel) {
      return Icon(_icon, size: 16, color: _color);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: _color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        // ignore: deprecated_member_use
        border: Border.all(color: _color.withOpacity(0.4)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(_icon, size: 13, color: _color),
          const SizedBox(width: 4),
          Text(
            _label,
            style: TextStyle(
              fontSize: 11,
              fontWeight: FontWeight.w600,
              color: _color,
            ),
          ),
        ],
      ),
    );
  }
}

class StatusIndicatorRow extends StatelessWidget {
  final bool isCloseFriend;
  final bool isMuted;
  final bool isFlagged;
  final bool isCloseFriendOf;
  final bool isMutedBy;
  final bool isFlaggedBy;

  const StatusIndicatorRow({
    super.key,
    this.isCloseFriend = false,
    this.isMuted = false,
    this.isFlagged = false,
    this.isCloseFriendOf = false,
    this.isMutedBy = false,
    this.isFlaggedBy = false,
  });

  @override
  Widget build(BuildContext context) {
    final badges = <Widget>[];

    if (isCloseFriend) {
      badges.add(
        const StatusIndicatorBadgeWidget(kind: IndicatorKind.closeFriend),
      );
    }
    if (isMuted) {
      badges.add(const StatusIndicatorBadgeWidget(kind: IndicatorKind.muted));
    }
    if (isFlagged) {
      badges.add(
        const StatusIndicatorBadgeWidget(kind: IndicatorKind.reported),
      );
    }
    if (isCloseFriendOf) {
      badges.add(
        const StatusIndicatorBadgeWidget(
          kind: IndicatorKind.closeFriend,
          actionTakenByMe: false,
        ),
      );
    }
    if (isMutedBy) {
      badges.add(
        const StatusIndicatorBadgeWidget(
          kind: IndicatorKind.muted,
          actionTakenByMe: false,
        ),
      );
    }
    if (isFlaggedBy) {
      badges.add(
        const StatusIndicatorBadgeWidget(
          kind: IndicatorKind.reported,
          actionTakenByMe: false,
        ),
      );
    }

    if (badges.isEmpty) return const SizedBox.shrink();

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (int i = 0; i < badges.length; i++) ...[
          if (i > 0) const SizedBox(width: 4),
          badges[i],
        ],
      ],
    );
  }
}
