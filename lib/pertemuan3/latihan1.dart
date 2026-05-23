import 'package:flutter/material.dart';

// main() dibiarkan di sini untuk testing, tapi ditambahkan MaterialApp agar bisa di-run mandiri
void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: PageBasicList(),
  ));
}

class PageBasicList extends StatelessWidget {
  const PageBasicList({super.key});

  @override
  Widget build(BuildContext context) {
    // PERBAIKAN 1: Hapus MaterialApp di dalam build, langsung kembalikan Scaffold
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Page Basic List',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.red,
        
        // PERBAIKAN 2: Isi fungsi onPressed dengan Navigator.pop
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context); // Ini yang membuat aplikasi kembali ke halaman sebelumnya
          },
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
    );
  }
}