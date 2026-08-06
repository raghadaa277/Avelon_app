import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:programmers_network_app/view/widget/Home/personalProfile/profile_theme_widget.dart';

class ProfileAboutSectionWidget extends StatelessWidget {
  final String? educationStatus;
  final String? university;
  final String? major;
  final String? studyYear;
  final String? country;
  final String? city;
  final String? specialization;
  final String? jobTitle;
  final String? company;
  final int? experienceYears;

  final String? githubUrl;
  final String? linkedinUrl;

  final bool isFlagged;
  final bool isMuted;
  final bool isCloseFriend;

  final ValueChanged<String>? onOpenLink;

  const ProfileAboutSectionWidget({
    super.key,
    this.educationStatus,
    this.university,
    this.major,
    this.studyYear,
    this.country,
    this.city,
    this.specialization,
    this.jobTitle,
    this.company,
    this.experienceYears,
    this.githubUrl,
    this.linkedinUrl,
    this.isFlagged = false,
    this.isMuted = false,
    this.isCloseFriend = false,
    this.onOpenLink,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: ProfileTheme.cardBg,
        borderRadius: BorderRadius.circular(ProfileTheme.radiusL),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _SectionTitle(
            icon: HugeIcons.strokeRoundedUserCircle,
            text: 'About',
            color: Color(0xff6366F1),
          ),
          const SizedBox(height: 8),
          _InfoRow(
            icon: HugeIcons.strokeRoundedSchool,
            iconColor: Color(0xff2563EB),
            label: 'Education',
            value: educationStatus,
          ),
          _InfoRow(
            icon: HugeIcons.strokeRoundedUniversity,
            iconColor: const Color(0xff7C3AED),
            label: 'University',
            value: university,
          ),
          _InfoRow(
            icon: HugeIcons.strokeRoundedBookOpen01,
            iconColor: const Color(0xff0891B2),
            label: 'Major',
            value: major,
          ),
          _InfoRow(
            icon: HugeIcons.strokeRoundedCalendar03,
            iconColor: const Color(0xffF59E0B),
            label: 'Study Year',
            value: studyYear,
          ),
          const Divider(height: 24, color: ProfileTheme.divider),
          _InfoRow(
            icon: HugeIcons.strokeRoundedGlobe02,
            iconColor: const Color(0xff16A34A),
            label: 'Country',
            value: country,
          ),
          _InfoRow(
            icon: HugeIcons.strokeRoundedLocation01,
            iconColor: const Color(0xffEF4444),
            label: 'City',
            value: city,
          ),
          const Divider(height: 24, color: ProfileTheme.divider),
          _InfoRow(
            icon: HugeIcons.strokeRoundedBrain02,
            iconColor: const Color(0xff9333EA),
            label: 'Specialization',
            value: specialization,
          ),
          _InfoRow(
            icon: HugeIcons.strokeRoundedBriefcase01,
            iconColor: const Color(0xffEA580C),
            label: 'Job Title',
            value: jobTitle,
          ),
          _InfoRow(
            icon: HugeIcons.strokeRoundedOffice,
            iconColor: const Color(0xff0F766E),
            label: 'Company',
            value: company,
          ),
          _InfoRow(
            icon: HugeIcons.strokeRoundedAnalytics01,
            iconColor: const Color(0xff0284C7),
            label: 'Experience',
            value: experienceYears != null ? '$experienceYears years' : null,
          ),
          const SizedBox(height: 20),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: _LinksCard(
                  githubUrl: githubUrl,
                  linkedinUrl: linkedinUrl,
                  onOpenLink: onOpenLink,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _StatusCard(
                  isFlagged: isFlagged,
                  isMuted: isMuted,
                  isCloseFriend: isCloseFriend,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final List<List> icon;
  final Color color;

  const _SectionTitle({
    required this.icon,
    required this.text,
    required this.color,
  });
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: color.withOpacity(.12),
            borderRadius: BorderRadius.circular(10),
          ),
          child: HugeIcon(icon: icon, size: 18, color: color),
        ),
        const SizedBox(width: 8),
        Text(
          text,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w700,
            color: ProfileTheme.textDark,
          ),
        ),
      ],
    );
  }
}

class _InfoRow extends StatelessWidget {
  final List<List> icon;
  final Color iconColor;
  final String label;
  final String? value;
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    if (value == null || value!.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(.12),
              borderRadius: BorderRadius.circular(8),
            ),
            child: HugeIcon(icon: icon, size: 16, color: iconColor),
          ),
          const SizedBox(width: 10),
          Expanded(
            flex: 4,
            child: Text(label, style: ProfileTheme.subtleStyle),
          ),
          Expanded(
            flex: 5,
            child: Text(
              value!,
              textAlign: TextAlign.right,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: ProfileTheme.textDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LinksCard extends StatelessWidget {
  final String? githubUrl;
  final String? linkedinUrl;
  final ValueChanged<String>? onOpenLink;
  const _LinksCard({this.githubUrl, this.linkedinUrl, this.onOpenLink});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ProfileTheme.pageBg,
        borderRadius: BorderRadius.circular(ProfileTheme.radiusM),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              HugeIcon(
                icon: HugeIcons.strokeRoundedLink01,
                size: 16,
                color: const Color(0xff3B82F6),
              ),
              SizedBox(width: 6),
              Text('Links', style: TextStyle(fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 10),
          _LinkTile(
            icon: HugeIcons.strokeRoundedGithub,
            iconColor: Colors.black87,
            label: 'GitHub',
            url: githubUrl,
            onTap: onOpenLink,
          ),
          const SizedBox(height: 8),
          _LinkTile(
            icon: HugeIcons.strokeRoundedLinkedin02,
            iconColor: const Color(0xff0A66C2),
            label: 'LinkedIn',
            url: linkedinUrl,
            onTap: onOpenLink,
          ),
        ],
      ),
    );
  }
}

class _LinkTile extends StatelessWidget {
  final List<List> icon;
  final String label;
  final String? url;
  final ValueChanged<String>? onTap;
  final Color iconColor;

  const _LinkTile({
    required this.icon,
    required this.label,
    this.url,
    this.onTap,
    required this.iconColor,
  });

  @override
  Widget build(BuildContext context) {
    final hasUrl = url != null && url!.isNotEmpty;
    return InkWell(
      onTap: hasUrl ? () => onTap?.call(url!) : null,
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: iconColor.withOpacity(.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: HugeIcon(icon: icon, color: iconColor, size: 18),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: const TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  hasUrl ? url! : 'Not provided',
                  style: ProfileTheme.subtleStyle.copyWith(fontSize: 11),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _StatusCard extends StatelessWidget {
  final bool isFlagged;
  final bool isMuted;
  final bool isCloseFriend;
  const _StatusCard({
    required this.isFlagged,
    required this.isMuted,
    required this.isCloseFriend,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: ProfileTheme.pageBg,
        borderRadius: BorderRadius.circular(ProfileTheme.radiusM),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              HugeIcon(
                icon: HugeIcons.strokeRoundedShield01,
                size: 15,
                color: const Color(0xff10B981),
              ),
              SizedBox(width: 6),
              Text('Status', style: TextStyle(fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 10),
          _StatusRow(label: 'Flagged', value: isFlagged),
          _StatusRow(label: 'Muted', value: isMuted),
          _StatusRow(label: 'Close Friend', value: isCloseFriend),
        ],
      ),
    );
  }
}

class _StatusRow extends StatelessWidget {
  final String label;
  final bool value;
  const _StatusRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: ProfileTheme.subtleStyle.copyWith(fontSize: 12),
            ),
          ),
          HugeIcon(
            icon: value
                ? HugeIcons.strokeRoundedCheckmarkCircle02
                : HugeIcons.strokeRoundedCancelCircle,
            size: 8,
            color: value ? ProfileTheme.primaryGreen : ProfileTheme.textGrey,
          ),
          const SizedBox(width: 4),
          Text(
            value ? 'Yes' : 'No',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              color: value
                  ? ProfileTheme.primaryGreenDark
                  : ProfileTheme.textGrey,
            ),
          ),
        ],
      ),
    );
  }
}
