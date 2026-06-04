import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mobileprogramming/main.dart'; // Agar bisa diarahkan ke PageMain (Navbar)
import 'register.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();
  
  // Tambahan state untuk menyembunyikan/menampilkan password
  bool _isObscure = true;
  bool _isLoading = false; // Untuk animasi loading di tombol

  Future<void> _login() async {
    if (username.text.isNotEmpty && password.text.isNotEmpty) {
      setState(() {
        _isLoading = true;
      });

      try {
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
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                title: const Text("Success"),
                content: const Text("Login berhasil!"),
                actions: <Widget>[
                  TextButton(
                    child: const Text("OK", style: TextStyle(color: Colors.blue)),
                    onPressed: () {
                      Navigator.of(context).pop(); 
                      
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const PageMain()), 
                        (route) => false, 
                      );
                    },
                  ),
                ],
              );
            },
          );
        } else {
          String errorMessage = "Email atau password tidak sesuai";
          try {
             var responseData = jsonDecode(response.body);
             if(responseData['message'] != null) errorMessage = responseData['message'];
             else if (responseData['Message'] != null) errorMessage = responseData['Message'];
          } catch(e) {}

          _showErrorDialog(errorMessage);
        }
      } catch (e) {
         print("Error koneksi: $e");
         _showErrorDialog("Terjadi kesalahan koneksi jaringan.");
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else {
      _showErrorDialog("Email dan Password tidak boleh kosong");
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          title: const Text("Error", style: TextStyle(color: Colors.red)),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text("OK", style: TextStyle(color: Colors.blue)),
              onPressed: () {
                Navigator.of(context).pop(); 
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Background putih agar lebih clean
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
          onPressed: () {
            Navigator.pop(context); 
          },
        ),
      ),
      // Gunakan SingleChildScrollView agar tidak overflow saat keyboard muncul
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _headerWidget(),
                const SizedBox(height: 40),
                _formWidget(),
                const SizedBox(height: 30),
                _bottomWidget(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _headerWidget() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(4), // Memberi sedikit jarak untuk border putih
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: ClipOval(
            child: Image.asset(
              "images/pp.jpeg",
              height: 120,
              width: 120,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 24),
        const Text(
          "Welcome Back!",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Sign in to continue",
          style: TextStyle(
            fontSize: 16,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _formWidget() {
    return Column(
      children: [
        // Input Email
        TextFormField(
          controller: username,
          keyboardType: TextInputType.emailAddress,
          decoration: InputDecoration(
            hintText: "Email",
            hintStyle: TextStyle(color: Colors.grey[500]),
            prefixIcon: const Icon(Icons.email_outlined, color: Colors.blue),
            filled: true,
            fillColor: Colors.blueGrey[50], // Warna background input lembut
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none, // Menghilangkan garis tepi
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
        const SizedBox(height: 20),
        
        // Input Password
        TextFormField(
          controller: password,
          obscureText: _isObscure, // Menggunakan state _isObscure
          decoration: InputDecoration(
            hintText: "Password",
            hintStyle: TextStyle(color: Colors.grey[500]),
            prefixIcon: const Icon(Icons.lock_outline, color: Colors.blue),
            // Tombol untuk hide/show password
            suffixIcon: IconButton(
              icon: Icon(
                _isObscure ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey[600],
              ),
              onPressed: () {
                setState(() {
                  _isObscure = !_isObscure; // Toggle state
                });
              },
            ),
            filled: true,
            fillColor: Colors.blueGrey[50],
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            contentPadding: const EdgeInsets.symmetric(vertical: 16),
          ),
        ),
        const SizedBox(height: 30),
        
        // Tombol Login
        SizedBox(
          height: 55,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _isLoading ? null : _login,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
            ),
            child: _isLoading 
                ? const SizedBox(
                    height: 24,
                    width: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 3,
                    ),
                  )
                : const Text(
                    "Log in",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  Widget _bottomWidget(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account?",
          style: TextStyle(color: Colors.grey[700], fontSize: 15),
        ),
        const SizedBox(width: 4),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const Register()),
            );
          },
          child: const Text(
            "Sign up",
            style: TextStyle(
              color: Colors.blue, 
              fontWeight: FontWeight.bold, 
              fontSize: 15
            ),
          ),
        ),
      ],
    );
  }
}