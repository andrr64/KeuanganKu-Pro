import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:keuanganku/backend/database/database_services.dart';
import 'package:keuanganku/frontend/app/app.dart';
import 'package:keuanganku/frontend/app/pages/content_when_x.dart';
import 'package:keuanganku/frontend/themes/light_theme.dart';

DatabaseServices db = DatabaseServices();

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await db.openDb();
  } catch (err){
    runApp(AppError(error: err));
    return;
  }
  runApp(const ProviderScope(child: App()));
}

class AppError extends StatelessWidget {
  const AppError({super.key, required this.error});
  final Object error;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: contentWhenError(context, error),
    );
  }
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'KeuanganKu Pro',
      home: const KeuangankuPro(),
      theme: light_theme,
    );
  }
}