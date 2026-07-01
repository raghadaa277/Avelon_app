import 'package:flutter/material.dart';
import 'package:programmers_network_app/core/const/color_const.dart';

Color statusColor(String s) {
  switch (s.toLowerCase()) {
    case 'active':
      return green;
    case 'inactive':
      return orange;
    case 'suspended':
      return deepOrange;
    case 'banned':
      return red;
    default:
      return Colors.grey;
  }
}

IconData statusIcon(String s) {
  switch (s.toLowerCase()) {
    case 'active':
      return Icons.check_circle;
    case 'inactive':
      return Icons.error;
    case 'suspended':
      return Icons.pause_circle_filled;
    case 'banned':
      return Icons.cancel;
    default:
      return Icons.help_outline;
  }
}

DateTime? parseRaw(String? value) {
  if (value == null || value.isEmpty) return null;
  return DateTime.tryParse(value);
}

String formatDateTime(String? raw) {
  final dt = parseRaw(raw);
  if (dt == null) return '-';

  const months = [
    'Jan',
    'Feb',
    'Mar',
    'Apr',
    'May',
    'Jun',
    'Jul',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec',
  ];

  final hour = dt.hour == 0 ? 12 : (dt.hour > 12 ? dt.hour - 12 : dt.hour);

  final amPm = dt.hour >= 12 ? 'PM' : 'AM';

  return '${months[dt.month - 1]} ${dt.day}, ${dt.year}  $hour:${dt.minute.toString().padLeft(2, '0')} $amPm';
}

String timeAgo(String? raw) {
  final dt = parseRaw(raw);
  if (dt == null) return '';

  final diff = DateTime.now().difference(dt);

  if (diff.inDays >= 365) {
    return '${(diff.inDays / 365).floor()} year(s) ago';
  }

  if (diff.inDays >= 30) {
    return '${(diff.inDays / 30).floor()} month(s) ago';
  }

  if (diff.inDays >= 1) {
    return '${diff.inDays} day(s) ago';
  }

  if (diff.inHours >= 1) {
    return '${diff.inHours} hour(s) ago';
  }

  return '${diff.inMinutes} minute(s) ago';
}

String durationBetween(String? startRaw, String? endRaw) {
  final start = parseRaw(startRaw);

  if (start == null) return '-';

  final end = endRaw != null ? parseRaw(endRaw) : DateTime.now();

  if (end == null) return '-';

  final diff = end.difference(start).abs();

  final d = diff.inDays;
  final h = diff.inHours % 24;
  final m = diff.inMinutes % 60;
  final s = diff.inSeconds % 60;

  final parts = <String>[];

  if (d > 0) parts.add('${d}d');
  if (h > 0) parts.add('${h}h');
  if (m > 0) parts.add('${m}m');

  parts.add('${s}s');

  return parts.join(' ');
}
