import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

enum IndicatorKind { closeFriend, muted, reported, mutual, connection }

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

  List<List> get _hugeIcon {
    switch (kind) {
      case IndicatorKind.closeFriend:
        return HugeIcons.strokeRoundedStar;

      case IndicatorKind.muted:
        return HugeIcons.strokeRoundedVolumeMute02;

      case IndicatorKind.reported:
        return HugeIcons.strokeRoundedFlag01;

      case IndicatorKind.mutual:
        return HugeIcons.strokeRoundedUserGroup;

      case IndicatorKind.connection:
        return HugeIcons.strokeRoundedAnalytics01;
    }
  }

  Color get _color {
    switch (kind) {
      case IndicatorKind.closeFriend:
        return Colors.pinkAccent;

      case IndicatorKind.muted:
        return Colors.deepPurple;

      case IndicatorKind.reported:
        return Colors.red;

      case IndicatorKind.mutual:
        return Colors.lightBlueAccent;

      case IndicatorKind.connection:
        return Colors.orangeAccent;
    }
  }

  String get _label {
    switch (kind) {
      case IndicatorKind.closeFriend:
        return actionTakenByMe ? 'Close Friend' : 'Added You Close Friend';

      case IndicatorKind.muted:
        return actionTakenByMe ? 'Muted' : 'Muted You';

      case IndicatorKind.reported:
        return actionTakenByMe ? 'Reported' : 'Reported You';

      case IndicatorKind.mutual:
        return 'Mutual Followers';

      case IndicatorKind.connection:
        return 'Connection Analysis';
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!showLabel) {
      return HugeIcon(icon: _hugeIcon, size: 16, color: _color);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),

      decoration: BoxDecoration(
        color: _color.withOpacity(0.1),

        borderRadius: BorderRadius.circular(20),

        border: Border.all(color: _color.withOpacity(0.4)),
      ),

      child: Row(
        mainAxisSize: MainAxisSize.min,

        children: [
          HugeIcon(icon: _hugeIcon, size: 13, color: _color),

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

  final bool isMutual;
  final bool isConnection;

  final bool isCloseFriendOf;
  final bool isMutedBy;
  final bool isFlaggedBy;

  const StatusIndicatorRow({
    super.key,

    this.isCloseFriend = false,
    this.isMuted = false,
    this.isFlagged = false,

    this.isMutual = false,
    this.isConnection = false,

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

    if (isMutual) {
      badges.add(const StatusIndicatorBadgeWidget(kind: IndicatorKind.mutual));
    }

    if (isConnection) {
      badges.add(
        const StatusIndicatorBadgeWidget(kind: IndicatorKind.connection),
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

    if (badges.isEmpty) {
      return const SizedBox.shrink();
    }

    return Wrap(spacing: 4, runSpacing: 4, children: badges);
  }
}
