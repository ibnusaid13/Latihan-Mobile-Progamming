// lib/screens/success_page.dart
import 'package:flutter/material.dart';
import 'receipt_page.dart';
import 'dashboard_page.dart';

class SuccessPage extends StatelessWidget {
  final List<Map<String, dynamic>> purchasedItems;
  const SuccessPage({super.key, required this.purchasedItems});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1E),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(30),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: const LinearGradient(
                    colors: [Color(0xFF00D26A), Color(0xFF00A854)],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00D26A).withOpacity(0.4),
                      blurRadius: 30,
                      spreadRadius: 10,
                    ),
                  ],
                ),
                child: const Icon(Icons.check_circle_outline, size: 80, color: Colors.white),
              ),
              const SizedBox(height: 35),
              const Text(
                "Pesanan Berhasil!",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 15),
              Text(
                "Terima kasih telah berbelanja\ndi GamingForge Hub",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 15,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 50),
              Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF00F5FF), Color(0xFF0096FF)],
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00F5FF).withOpacity(0.4),
                      blurRadius: 20,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: ElevatedButton.icon(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ReceiptPage(purchasedItems: purchasedItems),
                      ),
                    );
                  },
                  icon: const Icon(Icons.receipt_long, color: Colors.white),
                  label: const Text(
                    "LIHAT STRUK",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 15,
                      letterSpacing: 1,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 18),
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              TextButton(
                onPressed: () {
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (context) => const DashboardPage()),
                    (route) => false,
                  );
                },
                child: const Text(
                  "Kembali ke Dashboard",
                  style: TextStyle(
                    fontSize: 15,
                    color: Color(0xFF00F5FF),
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}