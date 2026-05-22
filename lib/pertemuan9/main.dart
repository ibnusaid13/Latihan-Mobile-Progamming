import 'package:flutter/material.dart';
import 'package:mobileprogramming/pertemuan9/pages/datetime_page.dart';
import 'package:mobileprogramming/pertemuan9/pages/profil_page.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

void main() {
  runApp(MyApp9());
}

class MyApp9 extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp9> {
  final List<Widget> _page = [ProfilePage(), DatetimePage()];

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
            //Profile
            SalomonBottomBarItem(
              icon: Icon(Icons.person),
              title: Text("Profile"),
              selectedColor: Colors.blue,
            ),

            //Date & Time Picker
            SalomonBottomBarItem(
              icon: Icon(Icons.calendar_month),
              title: Text("Date & Time"),
              selectedColor: Colors.blue,
            ),
          ],
        ),
      ),
    );
  }
}