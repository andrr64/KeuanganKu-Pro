import 'package:flutter/material.dart';

class KBottomNavigationBar extends StatelessWidget {
  const KBottomNavigationBar(
      {super.key, required this.index, required this.callback});
  final void Function(int) callback;
  final int index;
  @override
  Widget build(BuildContext context) {
    return NavigationBar(
        height: 70,
        shadowColor: Colors.grey,
        backgroundColor: Colors.white,
        onDestinationSelected: callback,
        selectedIndex: index,
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.home), label: 'Money'),
        ]);
  }
}
