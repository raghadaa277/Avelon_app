String formatHoursToHms(double totalHours) {
  final totalSeconds = (totalHours * 3600).round();
  final h = totalSeconds ~/ 3600;
  final m = (totalSeconds % 3600) ~/ 60;
  final s = totalSeconds % 60;
  return '${h}h ${m}m ${s}s';
}
