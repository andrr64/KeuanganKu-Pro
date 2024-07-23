import 'package:flutter/material.dart';
import 'package:keuanganku/backend/database/database_services.dart';
import 'package:keuanganku/frontend/app/home/home.dart';
import 'package:keuanganku/frontend/app/pages/content_when_x.dart';
import 'package:keuanganku/frontend/themes/light_theme.dart';

DatabaseServices db = DatabaseServices();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await db.openDb();
  } catch(E){
    runApp(ErrPage(e: E));
    return;
  }
  runApp(const MyApp()); // if the database successfully opened, run the App
}

class ErrPage extends StatelessWidget {
  const ErrPage({super.key, required this.e});
  final Object e;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Error',
      home: contentWhenError(context, '$e'),
    );
  }
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