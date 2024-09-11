enum DateRange {
  week('Weekly', 'This Week', 'week', 1),
  month('Monthly', 'This Month', 'month', 2),
  year('Yearly', 'This Year', 'year', 3);

  const DateRange(this.dropdownString, this.label, this.value, this.intVal);
  final String dropdownString;
  final String label;
  final String value;
  final int intVal;
}

extension Ex1 on DateRange {
  Map<String, DateRange> getDateRangeMap() {
    return Map.fromEntries(DateRange.values.map((DateRange data) {
      return MapEntry(data.label, data);
    }));
  }
  
  List<String> get labels {
    return List.generate(DateRange.values.length, (i) => DateRange.values[i].label);
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
        final endOfWeek = now.subtract(Duration(days: now.weekday - 1)).add(const Duration(days: 6));
        return DateTime(endOfWeek.year, endOfWeek.month, endOfWeek.day, 23, 59, 59).toIso8601String();
      case DateRange.year:
        final endOfYear = DateTime(now.year, 12, 31);
        return DateTime(endOfYear.year, endOfYear.month, endOfYear.day, 23, 59, 59).toIso8601String();
    }
  }

  DateTime get startDate {
    final now = DateTime.now();
    switch (this) {
      case DateRange.month:
        return DateTime(now.year, now.month, 1);
      case DateRange.week:
        return now.subtract(Duration(days: now.weekday - 1));
      case DateRange.year:
        return DateTime(now.year, 1, 1);
    }
  }

  DateTime get endDate {
    final now = DateTime.now();
    switch (this) {
      case DateRange.month:
        return DateTime(now.year, now.month + 1, 1).subtract(const Duration(days: 1)).add(const Duration(hours: 23, minutes: 59, seconds: 59));
      case DateRange.week:
        return now.subtract(Duration(days: now.weekday - 1)).add(const Duration(days: 6, hours: 23, minutes: 59, seconds: 59));
      case DateRange.year:
        return DateTime(now.year, 12, 31, 23, 59, 59);
    }
  }
}