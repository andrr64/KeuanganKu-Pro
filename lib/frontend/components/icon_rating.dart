import 'package:flutter/material.dart';

class IconRatingBar5 extends StatelessWidget {
  const IconRatingBar5(
      {super.key,
      required this.icon,
      required this.rating,
      required this.callback,
      this.colors = const [
        Colors.green,
        Colors.green,
        Colors.green,
        Colors.green,
        Colors.green
      ]});
  final IconData icon;
  final int rating;
  final void Function(int) callback;
  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (int i = 1; i <= 5; i++)
          GestureDetector(
            child: Icon(
              icon,
              color: i <= rating ? colors[i - 1] : Colors.grey,
            ),
            onTap: () => callback(i),
          )
      ],
    );
  }
}
