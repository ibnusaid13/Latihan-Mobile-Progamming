import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
// PASTIKAN IMPORT MENGGUNAKAN NAMA PROJECT ANDA ('mobileprogramming')
import 'package:mobileprogramming/pertemuan11/dashboard_page.dart';
import 'package:mobileprogramming/pertemuan11/login_page.dart';
import 'package:mobileprogramming/pertemuan11/session_model.dart';

// Fungsi main ini hanya berjalan jika Anda me-run file ini secara mandiri untuk testing
void main() {
  runApp(
    const MaterialApp(
      home: MyApp11(),
    ),
  );
}

class MyApp11 extends StatelessWidget {
  const MyApp11({super.key});

  @override
  Widget build(BuildContext context) {
    // 1. Pindahkan ChangeNotifierProvider ke sini agar bisa dibaca saat dipanggil dari navbar
    return ChangeNotifierProvider(
      create: (context) => SessionModel()..loadSession(),
      child: Consumer<SessionModel>(
        builder: (context, sessionModel, child) {
          // 2. HAPUS MaterialApp di sini, langsung return halamannya
          if (sessionModel.isLoggedIn) {
            return  DashboardPage(); // Sesuaikan nama class Dashboard Pertemuan 11 Anda
          } else {
            return const LoginPage(); // Sesuaikan nama class Login Pertemuan 11 Anda
          }
        },
      ),
    );
  }
}