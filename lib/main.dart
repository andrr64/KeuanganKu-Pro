import 'package:flutter/material.dart';
import 'package:keuanganku/frontend/home/home.dart';
import 'package:keuanganku/frontend/themes/light_theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KeuanganKu Pro',
      home: const Homepage(),
      theme: light_theme,
    );
  }
}