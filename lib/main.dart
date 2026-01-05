import 'package:flutter/material.dart';
import 'screens/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'HyDE Series App',
      theme: ThemeData(
        primaryColor: const Color(0xFF3B2365),
        colorScheme: ColorScheme.fromSeed(seedColor: const Color(0xFF3B2365)),
      ),
      home: const SplashScreen(), // first screen
    );
  }
}
