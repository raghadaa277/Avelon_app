enum GrowthPeriod {
  today('today', 'Today'),
  last7Days('7_days', 'Last 7 Days'),
  last30Days('30_days', 'Last 30 Days'),
  thisMonth('this_month', 'This Month'),
  thisYear('this_year', 'This Year');

  final String value;
  final String label;

  const GrowthPeriod(this.value, this.label);

  static GrowthPeriod fromValue(String value) {
    return GrowthPeriod.values.firstWhere(
      (e) => e.value == value,
      orElse: () => GrowthPeriod.thisYear,
    );
  }
}
