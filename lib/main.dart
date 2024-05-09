import 'package:flutter/material.dart';
import 'package:kanban/app_tabbar_view.dart';
import 'package:kanban/storage/app_local_storage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppLocalStorage.initializeLocalStorage();
  AppLocalStorage.loadAllTasks();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(home: AppTabbarView());
  }
}
