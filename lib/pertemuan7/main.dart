import 'package:flutter/material.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';
import 'package:mobileprogramming/pertemuan7/page/radiobutton_page.dart';
import 'package:mobileprogramming/pertemuan7/page/profile_page.dart';


void main() {
  runApp(MyApp1());
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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Scaffold(
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
      ),
    );
  }
}