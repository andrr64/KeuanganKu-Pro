import 'dart:ui';

enum BackgroundColor {
  white(0xffffffff),
  black(0xff14192b);
  const BackgroundColor(this.color);
  final int color;
}
enum FontColor {
  black(0xff14192b);
  const FontColor(this.color);
  final int color;
}

extension BackgroundColorExt on BackgroundColor{
  int value(){
    return color;
  }

  Color getColor(){
    return Color(color);
  }
}

extension FontColorExt on FontColor {
int value(){
  return color;
}

Color getColor(){
  return Color(color);
}
}