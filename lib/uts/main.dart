import 'package:flutter/material.dart';
import 'package:mobileprogramming/uts/screens/login_page.dart';

class GamingForgeHubApp extends StatelessWidget {
  const GamingForgeHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    // Tetap gunakan Theme agar warnanya tidak berubah
    return Theme(
      data: ThemeData(
        primaryColor: const Color(0xFF0A0A1F),
        scaffoldBackgroundColor: const Color(0xFFF0F2F5),
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
      
      // PERBAIKAN: Langsung panggil LoginPage() tanpa dibungkus Scaffold/AppBar lagi
      child: const LoginPage(), 
    );
  }
}