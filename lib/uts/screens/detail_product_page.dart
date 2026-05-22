// lib/uts/screens/detail_product_page.dart
import 'package:flutter/material.dart'; 
import 'package:mobileprogramming/uts/database_helper.dart'; // Import Database Helper
import 'cart_page.dart';

class DetailProductPage extends StatefulWidget {
  final Map<String, dynamic> product;
  const DetailProductPage({super.key, required this.product});

  @override
  State<DetailProductPage> createState() => _DetailProductPageState();
}

class _DetailProductPageState extends State<DetailProductPage> {
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  // Membaca status favorit dari SQLite saat halaman dibuka
  Future<void> _checkFavoriteStatus() async {
    bool status = await DatabaseHelper.instance.isFavorite(widget.product['model']);
    setState(() {
      isFavorite = status;
    });
  }

  // Mengubah logika Toggle Favorit
  Future<void> _toggleFavorite() async {
    if (isFavorite) {
      // Hapus dari SQLite
      await DatabaseHelper.instance.removeFavorite(widget.product['model']);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Dihapus dari Favorit!"),
          backgroundColor: Colors.grey[800],
          duration: const Duration(seconds: 1),
        ),
      );
    } else {
      // Simpan ke SQLite
      await DatabaseHelper.instance.addFavorite(widget.product);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Ditambahkan ke Favorit ❤️"),
          backgroundColor: const Color(0xFFFF2E63),
          duration: const Duration(seconds: 1),
        ),
      );
    }
    
    // Perbarui UI
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A2E),
        elevation: 0,
        title: const Text("Detail Produk"),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: const Color(0xFFFF2E63).withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFFFF2E63).withOpacity(0.3), width: 1),
            ),
            child: IconButton(
              onPressed: _toggleFavorite, // Panggil fungsi toggle
              // Ikon berubah tergantung status isFavorite
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                color: const Color(0xFFFF2E63),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(40),
                    decoration: BoxDecoration(
                      gradient: RadialGradient(
                        colors: [
                          const Color(0xFF00F5FF).withOpacity(0.15),
                          Colors.transparent,
                        ],
                      ),
                    ),
                    child: Hero(
                      tag: widget.product['model'],
                      child: Image.asset(
                        "images/${widget.product['image']}",
                        fit: BoxFit.contain,
                        height: 280,
                        errorBuilder: (context, error, stackTrace) => const Icon(
                          Icons.laptop_mac,
                          size: 120,
                          color: Color(0xFF00F5FF),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(30),
                    decoration: const BoxDecoration(
                      color: Color(0xFF1A1A2E),
                      borderRadius: BorderRadius.vertical(top: Radius.circular(35)),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF00F5FF), Color(0xFF0096FF)],
                            ),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            widget.product['brand'],
                            style: const TextStyle(
                              fontSize: 12,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.5,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          widget.product['model'],
                          style: const TextStyle(
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFF2E63).withOpacity(0.2),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                  color: const Color(0xFFFF2E63).withOpacity(0.5),
                                  width: 1,
                                ),
                              ),
                              child: Text(
                                widget.product['price'],
                                style: const TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFF2E63),
                                ),
                              ),
                            ),
                          ],
                        ),
                        
                        const SizedBox(height: 30),
                        
                        // --- DESKRIPSI PRODUK ---
                        const Text(
                          "Deskripsi Produk",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Text(
                          widget.product['description'] ?? "Deskripsi tidak tersedia.",
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            height: 1.6,
                            fontSize: 14,
                          ),
                          textAlign: TextAlign.justify,
                        ),
                        
                        const SizedBox(height: 25),
                        
                        // --- SPESIFIKASI ---
                        const Text(
                          "Spesifikasi Utama",
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                        const SizedBox(height: 15),
                        Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: const Color(0xFF0F0F1E),
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(
                              color: const Color(0xFF00F5FF).withOpacity(0.2),
                              width: 1,
                            ),
                          ),
                          child: Text(
                            widget.product['specs'],
                            style: const TextStyle(
                              color: Colors.white70,
                              height: 1.8,
                              fontSize: 14,
                            ),
                            textAlign: TextAlign.justify,
                          ),
                        ),
                        const SizedBox(height: 25),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFF1A1A2E),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF00F5FF).withOpacity(0.1),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Container(
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
            // PERUBAHAN UTAMA DI SINI (Menjadi fungsi Async dan memanggil SQLite)
            onPressed: () async {
              // 1. Simpan ke database SQLite
              await DatabaseHelper.instance.addToCart(widget.product);
              
              if (!context.mounted) return; // Pastikan widget masih ada sebelum memanggil context
              
              // 2. Munculkan notifikasi
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text("Berhasil ditambahkan ke keranjang!"),
                  backgroundColor: const Color(0xFF00D26A), // Hijau
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                ),
              );
              
              // 3. Pindah ke halaman cart
              Navigator.push(context, MaterialPageRoute(builder: (context) => const CartPage()));
            },
            icon: const Icon(Icons.add_shopping_cart, color: Colors.white),
            label: const Text(
              "TAMBAH KE KERANJANG",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1,
                color: Colors.white,
              ),
            ),
            style: ElevatedButton.styleFrom(
              minimumSize: const Size(double.infinity, 60),
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
            ),
          ),
        ),
      ),
    );
  }
}