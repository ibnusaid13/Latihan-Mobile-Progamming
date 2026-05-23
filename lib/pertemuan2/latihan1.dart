import 'package:flutter/material.dart';
import 'pages/dashboard_page.dart';
import 'pages/form_page.dart';

// Jika file ini dipanggil dari main.dart utama, fungsi main() di sini bisa diabaikan/dihapus
void main() {
  runApp(const MaterialApp(home: MyApp2()));
}

class MyApp2 extends StatelessWidget {
  const MyApp2({super.key});

  @override
  Widget build(BuildContext context) {
    // PERBAIKAN: Hapus MaterialApp, langsung return MainPages()
    return const MainPages(); 
  }
}

class MainPages extends StatefulWidget {
  const MainPages({super.key});
  @override
  State<MainPages> createState() => _MainPageState();
}

class _MainPageState extends State<MainPages> {
  int _selectedIndex = 0;
  final List<Widget> _pages = [
    const DashboardPage(),
    const FormPage(),
  ];

  final List<String> _titles = [
    'Dashboard',
    'Form Mahasiswa',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // PERBAIKAN: Tambahkan tombol back (leading) di sini
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Fungsi untuk kembali ke halaman sebelumnya
          },
        ),
        title: Text(
          _titles[_selectedIndex],
          style: const TextStyle(color: Colors.white), // Ubah teks jadi putih agar kontras
        ),
        backgroundColor: Colors.lightBlueAccent,
      ), // AppBar
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ), // BottomNavigationBarItem
          BottomNavigationBarItem(
            icon: Icon(Icons.edit),
            label: 'Form',
          ), // BottomNavigationBarItem
        ],
      ), // BottomNavigationBar
    ); // Scaffold
  }
}