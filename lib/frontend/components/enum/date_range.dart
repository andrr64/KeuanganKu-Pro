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
}
