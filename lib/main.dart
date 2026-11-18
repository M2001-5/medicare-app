import 'package:flutter/material.dart';
import 'app_state.dart';
import 'login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // On crée l'état global de l'application ici
  final AppState appState = AppState();

  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MediCare',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF087F8C),
        scaffoldBackgroundColor: const Color(0xFFF4F8FA),
      ),
      // On passe l'appState au LoginScreen
      home: LoginScreen(appState: appState), 
    );
  }
}