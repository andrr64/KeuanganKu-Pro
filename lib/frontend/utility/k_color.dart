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

enum BaseColor {
  old_red(Color(0xffa64646)),
  old_green(Color(0xff379777));

  const BaseColor(this.color);
  final Color color;
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