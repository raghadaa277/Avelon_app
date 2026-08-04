import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';

enum SettingAction { closeFriend, mute, report }

class SettingButtonWidget extends StatefulWidget {
  final bool isCloseFriend;
  final bool isMuted;

  final ValueChanged<SettingAction> onSelected;

  const SettingButtonWidget({
    super.key,
    required this.isCloseFriend,
    required this.isMuted,
    required this.onSelected,
  });

  @override
  State<SettingButtonWidget> createState() => _SettingButtonWidgetState();
}

class _SettingButtonWidgetState extends State<SettingButtonWidget> {
  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SettingAction>(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      onSelected: widget.onSelected,
      itemBuilder: (_) => [
        PopupMenuItem(
          value: SettingAction.closeFriend,
          child: Row(
            children: [
              HugeIcon(
                icon: widget.isCloseFriend
                    ? HugeIcons.strokeRoundedStarOff
                    : HugeIcons.strokeRoundedStar,
                size: 20,
                color: widget.isCloseFriend ? Colors.pinkAccent : Colors.grey,
              ),
              const SizedBox(width: 10),
              Text(
                widget.isCloseFriend
                    ? "Remove Close Friend"
                    : "Add Close Friend",
              ),
            ],
          ),
        ),
        PopupMenuItem(
          value: SettingAction.mute,
          child: Row(
            children: [
              HugeIcon(
                icon: widget.isMuted
                    ? HugeIcons.strokeRoundedVolumeHigh
                    : HugeIcons.strokeRoundedVolumeMute02,
                size: 20,
                color: widget.isMuted ? Colors.deepPurple : Colors.blueGrey,
              ),
              const SizedBox(width: 10),
              Text(widget.isMuted ? "Unmute User" : "Mute User"),
            ],
          ),
        ),
        const PopupMenuDivider(),
        PopupMenuItem(
          value: SettingAction.report,
          child: Row(
            children: const [
              HugeIcon(
                icon: HugeIcons.strokeRoundedFlag01,
                size: 20,
                color: Colors.red,
              ),
              SizedBox(width: 10),
              Text("Report User", style: TextStyle(color: Colors.red)),
            ],
          ),
        ),
      ],
      child: Container(
        width: 46,
        height: 46,
        alignment: Alignment.center,
        child: const HugeIcon(
          icon: HugeIcons.strokeRoundedMoreHorizontalCircle01,
          size: 22,
          color: Colors.black87,
        ),
      ),
    );
  }
}
