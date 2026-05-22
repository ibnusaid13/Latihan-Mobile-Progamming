import 'package:flutter/material.dart';

void main() {
  runApp(const PageBasicList());
}

class PageBasicList extends StatelessWidget {
  const PageBasicList({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          
          title: const Text(
            'Page Basic List',
            style: TextStyle(color: Colors.white),
          ),
          backgroundColor: Colors.red,
          
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {},
          ),
        ),
        body: ListView(
          children: const [
            
            ListTile(
              leading: Icon(Icons.alarm, color: Colors.grey),
              title: Text('Alarm'),
            ),

            
            ListTile(
              leading: Icon(Icons.phone, color: Colors.grey),
              title: Text('Phone'),
            ),

            
            ListTile(
              leading: Icon(Icons.camera_alt, color: Colors.grey),
              title: Text('Camera'),
            ),

            
            ListTile(
              leading: Icon(Icons.message, color: Colors.grey),
              title: Text('Message'),
            ),
          ],
        ),
      ),
    );
  }
}