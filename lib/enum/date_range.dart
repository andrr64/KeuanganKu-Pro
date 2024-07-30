enum DateRange {
  week('This Week', 'week'),
  month('This Month', 'month'),
  year('This Year', 'year');

  const DateRange(this.label, this.value);
  final String label;
  final String value;
}

extension DateRangeExtension on DateRange {
  Map<String, DateRange> getDateRangeMap() {
    return Map.fromEntries(DateRange.values.map((DateRange data) {
      return MapEntry(data.label, data);
    }));
  }

  String get startDateISO8601 {
    final now = DateTime.now();
    switch (this) {
      case DateRange.month:
        return DateTime(now.year, now.month, 1).toIso8601String();
      case DateRange.week:
        final startOfWeek = now.subtract(Duration(days: now.weekday - 1));
        return DateTime(startOfWeek.year, startOfWeek.month, startOfWeek.day).toIso8601String();
      case DateRange.year:
        return DateTime(now.year, 1, 1).toIso8601String();
    }
  }

  String get endDateISO8601 {
    final now = DateTime.now();
    switch (this) {
      case DateRange.month:
        final endOfMonth = DateTime(now.year, now.month + 1, 1).subtract(const Duration(days: 1));
        return DateTime(endOfMonth.year, endOfMonth.month, endOfMonth.day, 23, 59, 59).toIso8601String();
      case DateRange.week:
        final endOfWeek = now.subtract(Duration(days: now.weekday - 1)).add(Duration(days: 6));
        return DateTime(endOfWeek.year, endOfWeek.month, endOfWeek.day, 23, 59, 59).toIso8601String();
      case DateRange.year:
        final endOfYear = DateTime(now.year, 12, 31);
        return DateTime(endOfYear.year, endOfYear.month, endOfYear.day, 23, 59, 59).toIso8601String();
    }
  }
}
