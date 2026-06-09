import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:mobileprogramming/pertemuan11/session_model.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final usernameController = TextEditingController();
    final passwordController = TextEditingController();

    void login(BuildContext context) async {
      String username = usernameController.text;
      String password = passwordController.text;

      // Validasi login sesuai modul
      if (username == 'admin' && password == 'admin123') {
        await Provider.of<SessionModel>(context, listen: false).saveSession(username);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Username atau password salah')),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        // Tombol back untuk kembali ke menu utama navbar.dart
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Kembali ke posisi navbar terakhir
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(labelText: 'Username'),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => login(context),
              child: const Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}