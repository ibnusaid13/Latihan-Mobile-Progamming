import 'package:flutter/material.dart';

class PageEmpat extends StatelessWidget {
  const PageEmpat({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Mengenal List View"),
        backgroundColor: Colors.amberAccent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            // Handle back button press
            Navigator.of(context).pop();
          },
        ),
      ),
      body: ListView(
        children: <Widget>[
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text("Latihan List Satu"),
          ),
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text("Latihan List Dua"),
          ),
          const Padding(
            padding: EdgeInsets.all(12.0),
            child: Text("Latihan List Tiga"),
          ),
        ],
      ),
    );
  }
}