enum DateRange {
  weekly('Weekly', 'weekly'),
  monthly('Monthly', 'monthly'),
  yearly('Yearly', 'yearly');

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
