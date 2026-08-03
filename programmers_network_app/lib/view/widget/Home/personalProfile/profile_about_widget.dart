import 'package:flutter/material.dart';
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
          const _SectionTitle(icon: Icons.person_outline, text: 'About'),
          const SizedBox(height: 8),
          _InfoRow(
            icon: Icons.school_outlined,
            label: 'Education',
            value: educationStatus,
          ),
          _InfoRow(
            icon: Icons.account_balance_outlined,
            label: 'University',
            value: university,
          ),
          _InfoRow(icon: Icons.edit_note, label: 'Major', value: major),
          _InfoRow(
            icon: Icons.calendar_today_outlined,
            label: 'Study Year',
            value: studyYear,
          ),
          const Divider(height: 24, color: ProfileTheme.divider),
          _InfoRow(icon: Icons.public, label: 'Country', value: country),
          _InfoRow(icon: Icons.location_city, label: 'City', value: city),
          const Divider(height: 24, color: ProfileTheme.divider),
          _InfoRow(
            icon: Icons.workspace_premium_outlined,
            label: 'Specialization',
            value: specialization,
          ),
          _InfoRow(
            icon: Icons.badge_outlined,
            label: 'Job Title',
            value: jobTitle,
          ),
          _InfoRow(
            icon: Icons.apartment_outlined,
            label: 'Company',
            value: company,
          ),
          _InfoRow(
            icon: Icons.timeline_outlined,
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
  final IconData icon;
  final String text;
  const _SectionTitle({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: ProfileTheme.textDark),
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
  final IconData icon;
  final String label;
  final String? value;
  const _InfoRow({
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    if (value == null || value!.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Icon(icon, size: 16, color: ProfileTheme.textGrey),
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
              Icon(Icons.link, size: 15, color: ProfileTheme.textDark),
              SizedBox(width: 6),
              Text('Links', style: TextStyle(fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 10),
          _LinkTile(
            icon: Icons.code,
            label: 'GitHub',
            url: githubUrl,
            onTap: onOpenLink,
          ),
          const SizedBox(height: 8),
          _LinkTile(
            icon: Icons.business_center,
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
  final IconData icon;
  final String label;
  final String? url;
  final ValueChanged<String>? onTap;
  const _LinkTile({
    required this.icon,
    required this.label,
    this.url,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final hasUrl = url != null && url!.isNotEmpty;
    return InkWell(
      onTap: hasUrl ? () => onTap?.call(url!) : null,
      child: Row(
        children: [
          CircleAvatar(
            radius: 12,
            backgroundColor: Colors.black87,
            child: Icon(icon, size: 13, color: Colors.white),
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
              Icon(
                Icons.shield_outlined,
                size: 15,
                color: ProfileTheme.textDark,
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
          Icon(
            value ? Icons.circle : Icons.circle_outlined,
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
