// lib/uts/screens/favorite_page.dart
import 'package:flutter/material.dart';
import 'package:mobileprogramming/uts/database_helper.dart'; // Import Database Helper
import 'detail_product_page.dart';

class FavoritePage extends StatefulWidget {
  const FavoritePage({super.key});

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  // Variabel untuk menampung data dari SQLite
  late Future<List<Map<String, dynamic>>> _favoriteList;

  @override
  void initState() {
    super.initState();
    _refreshFavorites(); // Muat data saat halaman pertama kali dibuka
  }

  // Fungsi untuk mengambil data terbaru dari database
  void _refreshFavorites() {
    setState(() {
      _favoriteList = DatabaseHelper.instance.getFavorites();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A2E),
        elevation: 0,
        title: const Text("Laptop Favorit"),
      ),
      // Menggunakan FutureBuilder untuk menunggu dan menampilkan data dari SQLite
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _favoriteList,
        builder: (context, snapshot) {
          // Tampilkan loading saat sedang mengambil data
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(color: Color(0xFFFF2E63)),
            );
          }

          // Ambil data jika ada, jika null maka list kosong
          final favorites = snapshot.data ?? [];

          // Cek apakah list favorit kosong atau tidak
          if (favorites.isEmpty) {
            return _buildEmptyState();
          }

          // Jika ada isinya, tampilkan grid
          return _buildFavoriteGrid(favorites);
        },
      ),
    );
  }

  // Tampilan ketika belum ada produk favorit (Tidak ada perubahan UI)
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: const Color(0xFF1A1A2E),
              border: Border.all(
                color: const Color(0xFFFF2E63).withOpacity(0.3),
                width: 2,
              ),
            ),
            child: const Icon(
              Icons.favorite_border,
              size: 80,
              color: Color(0xFFFF2E63),
            ),
          ),
          const SizedBox(height: 25),
          const Text(
            "Belum Ada Favorit",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Tambahkan laptop impianmu ke sini!",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }

  // Tampilan Grid untuk produk-produk favorit (Menerima parameter data SQLite)
  Widget _buildFavoriteGrid(List<Map<String, dynamic>> favoritesData) {
    return GridView.builder(
      padding: const EdgeInsets.all(20),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.65, // Disesuaikan agar muat dengan ikon delete
        crossAxisSpacing: 15,
        mainAxisSpacing: 15,
      ),
      itemCount: favoritesData.length,
      itemBuilder: (context, index) {
        final product = favoritesData[index];
        return GestureDetector(
          onTap: () {
            // Navigasi ke detail produk
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DetailProductPage(product: product)),
            ).then((_) {
              // Refresh state dari database saat kembali dari halaman detail
              _refreshFavorites(); 
            });
          },
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1A1A2E),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: const Color(0xFFFF2E63).withOpacity(0.3), // Aksen Magenta
                width: 1,
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF2E63).withOpacity(0.15),
                  blurRadius: 15,
                  spreadRadius: -3,
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      // Area Gambar Produk
                      Container(
                        padding: const EdgeInsets.all(15),
                        decoration: BoxDecoration(
                          gradient: RadialGradient(
                            colors: [
                              const Color(0xFFFF2E63).withOpacity(0.1),
                              Colors.transparent,
                            ],
                          ),
                          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                        ),
                        child: Center(
                          child: Image.asset(
                            "images/${product['image']}",
                            fit: BoxFit.contain,
                            errorBuilder: (context, error, stackTrace) => const Icon(
                                Icons.laptop_mac, color: Color(0xFFFF2E63), size: 50),
                          ),
                        ),
                      ),
                      // Tombol Hapus Favorit
                      Positioned(
                        top: 5,
                        right: 5,
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color(0xFF0F0F1E).withOpacity(0.6),
                            shape: BoxShape.circle,
                          ),
                          child: IconButton(
                            icon: const Icon(Icons.favorite, color: Color(0xFFFF2E63), size: 20),
                            onPressed: () async {
                              // HAPUS DARI DATABASE SQLITE
                              await DatabaseHelper.instance.removeFavorite(product['model']);
                              
                              // Refresh tampilan UI agar item hilang
                              _refreshFavorites();

                              // Menambahkan ScaffoldMessenger
                              if (!mounted) return;
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: const Text("Dihapus dari Favorit"),
                                  backgroundColor: Colors.grey[800],
                                  duration: const Duration(seconds: 1),
                                ),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                // Informasi Teks Produk
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        product['brand'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 10,
                          color: Color(0xFFFF2E63),
                          letterSpacing: 1,
                        ),
                      ),
                      const SizedBox(height: 5),
                      Text(
                        product['model'],
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Colors.white,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        product['price'],
                        style: const TextStyle(
                          color: Color(0xFF00F5FF), // Aksen harga cyan
                          fontWeight: FontWeight.bold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}