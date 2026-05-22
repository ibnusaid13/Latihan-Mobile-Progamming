import 'package:flutter/material.dart';

class MyListView extends StatelessWidget {
  const MyListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Halaman list view"),
      ),
      body: ListView(
        children: <Widget>[
          Padding(padding: EdgeInsets.all(8.0),
          child: Text("Latihan Flutter P4"),),
          Padding(padding: EdgeInsets.all(8.0),
          child: Text("Latihan flutter P5"),)
        ],
      )
    );
  }
}