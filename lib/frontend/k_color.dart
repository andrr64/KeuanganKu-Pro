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
    return this.color;
  }

  Color getColor(){
    return Color(this.color);
  }
}

extension FontColorExt on FontColor {
int value(){
  return this.color;
}

Color getColor(){
  return Color(this.color);
}
}