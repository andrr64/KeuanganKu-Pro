import 'package:flutter/material.dart';
import 'package:keuanganku/backend/database/database_services.dart';
import 'package:keuanganku/frontend/app/home/home.dart';
import 'package:keuanganku/frontend/themes/light_theme.dart';

DatabaseServices db = DatabaseServices();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await db.openDb(); // open database, and wait..
  runApp(const MyApp()); // if the database successfully opened, run the App
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