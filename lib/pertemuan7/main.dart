import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:mobileprogramming/pertemuan7/page/radiobutton_page.dart';
import 'package:mobileprogramming/pertemuan7/page/profile_page.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyApp1(),
  ));
}

class MyApp1 extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp1> {
  final List<Widget> _page = [ProfilePage(), RadiobuttonPage()];

  var currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // PERBAIKAN: AppBar dibuat kondisional
      // Hanya muncul jika index 0 (Profile). Jika index 1 (Radio Button), maka null (tidak ada AppBar)
      appBar: currentPage == 0
          ? AppBar(
              title: const Text(
                'Profile',
                style: TextStyle(color: Colors.white),
              ),
              backgroundColor: Colors.blue,
              leading: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () {
                  Navigator.pop(context); // Fungsi kembali ke menu
                },
              ),
            )
          : null, // Mengosongkan AppBar saat berada di Radio Button
          
      body: _page[currentPage],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: currentPage,
        onTap: (i) => setState(() => currentPage = i),
        items: [
          /// Profile
          SalomonBottomBarItem(
            icon: Icon(Icons.person),
            title: Text("Profile"),
            selectedColor: Colors.blue,
          ),

          /// Radio Button
          SalomonBottomBarItem(
            icon: Icon(Icons.radio_button_checked),
            title: Text("Radio Button"),
            selectedColor: Colors.blue,
          ),
        ],
      ),
    );
  }
}