// lib/main.dart
import 'package:flutter/material.dart';
import 'package:mobileprogramming/uts/screens/login_page.dart';
import 'package:device_preview/device_preview.dart';

void main() => runApp(
  DevicePreview(
    enabled: true,
    builder: (context) => const GamingForgeHubApp(), // Nama class app kamu
  ),
);

class GamingForgeHubApp extends StatelessWidget {
  const GamingForgeHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true, // Tambahkan ini
      locale: DevicePreview.locale(context), // Tambahkan ini
      builder: DevicePreview.appBuilder,
      title: 'GamingForge Hub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF0A0A1F),
        scaffoldBackgroundColor: const Color(0xFFF0F2F5),
        appBarTheme: const AppBarTheme(
          elevation: 0,
          centerTitle: true,
          backgroundColor: Color(0xFF0A0A1F),
          foregroundColor: Colors.white,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF112240),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            elevation: 5,
          ),
        ),
        useMaterial3: true,
      ),
      home: const LoginPage(),
    );
  }
}