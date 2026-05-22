import 'package:flutter/material.dart';
import 'pages/dashboard_page.dart';
import 'pages/form_page.dart';

void main() {
  runApp(const MyApp2());
}

class MyApp2 extends StatelessWidget {
  const MyApp2({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App Mahasiswa',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ), // ThemeData
      home: const MainPages(),
      debugShowCheckedModeBanner: false,
    ); // MaterialApp
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
        title: Text(_titles[_selectedIndex]),
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