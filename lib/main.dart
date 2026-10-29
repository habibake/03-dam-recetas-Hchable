import 'package:flutter/material.dart';
import 'package:recetas_app/screens/splash_screen.dart';

void main() {
  runApp(const RecetasApp());
}

class RecetasApp extends StatelessWidget {
  const RecetasApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recetas del Mayab',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 127, 1, 133),
        ),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    ); // MaterialApp
  }
}
