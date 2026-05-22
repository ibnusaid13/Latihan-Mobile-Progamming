import 'package:flutter/material.dart';
import 'pertemuan2/latihan1.dart';
import 'pertemuan3/latihan1.dart';
import 'pertemuan4/main.dart';
import 'pertemuan4/tugas.dart';
import 'pertemuan5/latihan1.dart';
import 'pertemuan5/tugas.dart';



void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Tugas Mobile Programming',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const MenuUtama(),
    );
  }
}

class MenuUtama extends StatelessWidget {
  const MenuUtama({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Daftar Latihan & Tugas Pertemuan"),
        centerTitle: true,
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildMenuButton(context, "Pertemuan 2", const MainPages()), 
              const SizedBox(height: 15),
              _buildMenuButton(context, "Pertemuan 3", const PageBasicList()), 
              const SizedBox(height: 15),
              _buildMenuButton(context, "Pertemuan 4", const PageMain()), 
              const SizedBox(height: 15),
              _buildMenuButton(context, "Tugas Pertemuan 4", const MenuUtama1()), 
              const SizedBox(height: 15),
               _buildMenuButton(context, "Pertemuan 5", const MyListView()), 
              const SizedBox(height: 15),
               _buildMenuButton(context, "Tugas Pertemuan 5", const MyLayout()), 
              const SizedBox(height: 15),
            ],
          ),
        ),
      ),
    );
  }

  // Fungsi Helper agar kode lebih rapi
  Widget _buildMenuButton(BuildContext context, String label, Widget targetPage) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.shade50,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        onPressed: () => _navigate(context, targetPage),
        child: Text(label, style: const TextStyle(fontSize: 18)),
      ),
    );
  }

  void _navigate(BuildContext context, Widget page) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => page));
  }
}