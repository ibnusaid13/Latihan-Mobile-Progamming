import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MenuUtama1(),
    ); // MaterialApp
  }
}

class MenuUtama1 extends StatelessWidget {
  const MenuUtama1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu Utama"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            
            // Tombol 1: Ke Halaman Stateless
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContohStateless()),
                );
              },
              child: Text("Halaman Stateless"),
            ),

            SizedBox(height: 10), // Jarak antar tombol

            // Tombol 2: Ke Halaman Stateful
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ContohStateful()),
                );
              },
              child: Text("Halaman Stateful"),
            ),

            SizedBox(height: 10),

            // Tombol 3: Ke Halaman Toast & Alert
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ToastAlert()),
                );
              },
              child: Text("Halaman Contoh Toast & Alert"),
            ),
          ],
        ),
      ),
    );
  }
}

//  Stateless Widget
class ContohStateless extends StatelessWidget {
  const ContohStateless({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stateless Widget"),
      ), // AppBar
      body: Center(
        child: Text("Selamat datang di Stateless"),
      ), // Center
    ); // Scaffold
  }
}

//  Stateful Widget (Counter)
class ContohStateful extends StatefulWidget {
  const ContohStateful({super.key});

  @override
  State<ContohStateful> createState() => _ContohStatefulState();
}

class _ContohStatefulState extends State<ContohStateful> {
  int counter = 0;

  void tambah() {
    setState(() {
      counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Stateful Widget"),
      ), // AppBar
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Counter: $counter",
              style: TextStyle(fontSize: 20),
            ), // Text
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: tambah,
              child: Text("Tambah"),
            ), // ElevatedButton
          ],
        ), // Column
      ), // Center
    ); // Scaffold
  }
}

class ToastAlert extends StatefulWidget {
  const ToastAlert({super.key});

  @override
  State<ToastAlert> createState() => _ToastAlertState();
}

class _ToastAlertState extends State<ToastAlert> {

  // Fungsi Alert Dialog
  void tampilAlert() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Peringatan"),
          content: Text("Ini adalah contoh Alert Dialog"),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text("OK"),
            ), // TextButton
          ],
        ); // AlertDialog
      },
    );
  }

  // Fungsi Toast (SnackBar)
  void tampilToast() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Ini adalah contoh Toast (SnackBar)"),
        duration: Duration(seconds: 2),
      ), // SnackBar
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Toast & Alert"),
      ), // AppBar
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // Tombol Alert
            ElevatedButton(
              onPressed: tampilAlert,
              child: Text("Tampilkan Alert"),
            ), // ElevatedButton

            SizedBox(height: 20),

            // Tombol Toast
            ElevatedButton(
              onPressed: tampilToast,
              child: Text("Tampilkan Toast"),
            ), // ElevatedButton
          ],
        ), // Column
      ), // Center
    ); // Scaffold
  }
}
