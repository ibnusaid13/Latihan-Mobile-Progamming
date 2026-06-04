import 'package:flutter/material.dart';
import 'package:mobileprogramming/navbar.dart';
import 'package:intl/date_symbol_data_local.dart';

// Import untuk Device Preview
import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';

// Import file Login kamu
import 'package:mobileprogramming/pertemuan10/login_api.dart'; 

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  await initializeDateFormatting('id_ID', null); 
  
  runApp(
    DevicePreview(
      enabled: !kReleaseMode, 
      builder: (context) => MainPage(),
    ),
  );
}

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      
      title: 'Mata Kuliah Mobile Programming',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // TAMPILAN AWAL SEKARANG ADALAH HALAMAN LOGIN
      home: const Login(), 
      debugShowCheckedModeBanner: false,
    );
  }
}

class PageMain extends StatefulWidget {
  const PageMain({Key? key}) : super(key: key);

  @override
  State<PageMain> createState() => _PageMainState();
}

class _PageMainState extends State<PageMain> {
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    const MateriPage(),
    const NavigasiPage(),
    const ProfilePage(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 10,
              offset: const Offset(0, -3),
            ),
          ],
        ),
        child: BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Materi',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.navigation),
              label: 'Navigasi',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile', 
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.blue,
          unselectedItemColor: Colors.grey,
          onTap: _onItemTapped,
        ),
      ),
    );
  }
}