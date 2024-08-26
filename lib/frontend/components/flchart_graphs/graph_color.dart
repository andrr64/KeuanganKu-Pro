import 'dart:ui';

enum KGraphColor {
  red(Color(0xFFFF2C2C)),
  pastel_green(Color(0xFF79AC78)),
  pastel_red(Color(0xFFC84361));
  const KGraphColor(this.color);
  final Color color;
}