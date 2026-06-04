import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mobileprogramming/navbar.dart'; 
import 'register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> _login() async {
    if (username.text.isNotEmpty && password.text.isNotEmpty) {
      
      try {
        // MENGIRIM DATA SEPERTI FORM-DATA POSTMAN (Tanpa jsonEncode dan Headers khusus)
        final response = await http.post(
          Uri.parse("https://mobileapp.e-budgeting.com/api/login"),
          body: {
            "email": username.text, 
            "password": password.text
          },
        );
        
        print("Status API: ${response.statusCode}");
        print("Balasan API: ${response.body}");

        if (response.statusCode == 200) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Success"),
                content: const Text("Login berhasil!"),
                actions: <Widget>[
                  TextButton(
                    child: const Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop(); // Tutup dialog
                      
                      // Mengarahkan ke MateriPage dan menghapus tumpukan halaman sebelumnya
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const MateriPage()), 
                        (route) => false, 
                      );
                    },
                  ),
                ],
              );
            },
          );
        } else {
          // Menangkap pesan error dari server jika format balasannya JSON
          String errorMessage = "Email atau password tidak sesuai";
          try {
             var responseData = jsonDecode(response.body);
             if(responseData['message'] != null) errorMessage = responseData['message'];
             else if (responseData['Message'] != null) errorMessage = responseData['Message'];
          } catch(e) {
             // Abaikan jika server membalas pakai HTML/Teks biasa
          }

          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text("Error"),
                content: Text(errorMessage),
                actions: <Widget>[
                  TextButton(
                    child: const Text("OK"),
                    onPressed: () {
                      Navigator.of(context).pop(); 
                    },
                  ),
                ],
              );
            },
          );
        }
      } catch (e) {
         print("Error koneksi: $e");
      }
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text("Error"),
            content: const Text("Username dan Password tidak boleh kosong"),
            actions: <Widget>[
              TextButton(
                child: const Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop(); 
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); 
          },
        ),
      ),
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Flexible(child: Container(), flex: 2),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _centerWidget(),
            ),
            Flexible(child: Container(), flex: 2),
            const Divider(thickness: 2),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: _bottomWidget(context),
            ),
          ],
        ),
      ),
    );
  }

  Widget _centerWidget() {
    return Column(
      children: [
        // FOTO DIUBAH MENJADI LINGKARAN MENGGUNAKAN ClipOval
        ClipOval(
          child: Image.asset(
            "images/pp.jpeg",
            height: 150,
            width: 150, // Lebar dibuat sama dengan tinggi agar bulat sempurna
            fit: BoxFit.cover, // Memastikan gambar mengisi lingkaran tanpa terlihat gepeng
          ),
        ),
        const SizedBox(height: 24),
        TextFormField(
          controller: username,
          decoration: InputDecoration(
            hintText: "Email",
            border: OutlineInputBorder(
              borderSide: Divider.createBorderSide(context),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: Divider.createBorderSide(context),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: Divider.createBorderSide(context),
            ),
            filled: true,
            contentPadding: const EdgeInsets.all(8),
          ),
        ),
        const SizedBox(height: 24),
        TextFormField(
          controller: password,
          decoration: InputDecoration(
            hintText: "Password",
            border: OutlineInputBorder(
              borderSide: Divider.createBorderSide(context),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: Divider.createBorderSide(context),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: Divider.createBorderSide(context),
            ),
            filled: true,
            suffixIcon: const Icon(Icons.remove_red_eye),
            contentPadding: const EdgeInsets.all(8),
          ),
          obscureText: true,
        ),
        const SizedBox(height: 24),
        SizedBox(
          height: 48,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _login,
            child: const Text("Log in"),
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }

  Widget _bottomWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account?"),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Register()),
            );
          },
          child: const Text(
            " Sign up",
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}