import 'package:flutter/material.dart';
import 'package:mobileprogramming/pertemuan9/pages/datetime_page.dart';
import 'package:mobileprogramming/pertemuan9/pages/profil_page.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp9(),
  ));
}

class MyApp9 extends StatefulWidget {
  const MyApp9({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp9> {
  final List<Widget> _page = [ProfilePage(), DatetimePage()];
  
  // PERBAIKAN 1: Buat list judul untuk masing-masing tab
  final List<String> _titles = ['Profile', 'Date & Time']; 

  var currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // PERBAIKAN 2: Gunakan 1 AppBar statis di sini, tapi judulnya dinamis
      appBar: AppBar(
        title: Text(
          _titles[currentPage], // Judul akan otomatis berubah sesuai tab
          style: const TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Kembali ke MateriPage
          },
        ),
      ),
      body: _page[currentPage],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: currentPage,
        onTap: (i) => setState(() => currentPage = i),
        items: [
          SalomonBottomBarItem(
            icon: const Icon(Icons.person),
            title: const Text("Profile"),
            selectedColor: Colors.blue,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.calendar_month),
            title: const Text("Date & Time"),
            selectedColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}