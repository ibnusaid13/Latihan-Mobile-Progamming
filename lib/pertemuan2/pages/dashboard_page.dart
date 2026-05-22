import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text(
        'Selamat datang di Dashboard!',
        style: TextStyle(fontSize: 20),
      ), // Text
    ); // Center
  }
}