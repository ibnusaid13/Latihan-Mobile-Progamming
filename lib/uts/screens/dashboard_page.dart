// lib/screens/dashboard_page.dart
import 'package:flutter/material.dart';
import 'package:mobileprogramming/uts/screens/favorite_page.dart';
import 'cart_page.dart';
import 'gallery_page.dart';
import 'about_page.dart';
import 'login_page.dart';
import 'detail_product_page.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  // --- 1. STATE UNTUK COUNTER DI DRAWER ---
  int _drawerCounter = 0;

  // --- 2. STATE UNTUK PENCARIAN (SEARCH) ---
  final TextEditingController _searchController = TextEditingController();
  List<Map<String, dynamic>> _filteredProducts = [];

  // Data master produk
  // Data master produk (Sudah ditambahkan Deskripsi)
  final List<Map<String, dynamic>> products = [
    {
      "brand": "Lenovo", 
      "model": "LOQ Gaming 15", 
      "price": "Rp 14.500.000", 
      "image": "loq.png", 
      "specs": "Intel Core i7-13700H, RTX 4060 8GB, 16GB DDR5, 512GB SSD, 15.6\" FHD 144Hz IPS.",
      "description": "Laptop gaming yang menawarkan performa solid dengan harga yang kompetitif. Dilengkapi sistem pendingin canggih dan desain minimalis yang cocok untuk gamer kasual maupun produktivitas sehari-hari."
    },
    {
      "brand": "Lenovo", 
      "model": "Legion Pro 5i", 
      "price": "Rp 26.000.000", 
      "image": "legion.png", 
      "specs": "Intel Core i9-13900HX, RTX 4070 8GB, 32GB DDR5, 1TB SSD, 16\" QHD 240Hz.",
      "description": "Seri profesional dari Lenovo yang dirancang untuk performa puncak. Layar resolusi QHD dengan refresh rate 240Hz memastikan pengalaman visual yang sangat imersif, tajam, dan tanpa delay saat bermain game kompetitif."
    },
    {
      "brand": "Asus", 
      "model": "TUF Gaming F15", 
      "price": "Rp 17.800.000", 
      "image": "tuf.png", 
      "specs": "Intel Core i7-12700H, RTX 3060 6GB, 16GB DDR4, 512GB SSD, 15.6\" FHD 144Hz.",
      "description": "Durabilitas standar militer berpadu dengan performa gaming. Asus TUF Gaming F15 siap menemani sesi gaming maraton Anda dengan ketahanan fisik ekstra dan sistem keyboard RGB yang nyaman."
    },
    {
      "brand": "Acer", 
      "model": "Predator Helios 16", 
      "price": "Rp 29.500.000", 
      "image": "predator.png", 
      "specs": "Intel Core i9-13900HX, RTX 4080 12GB, 32GB DDR5, 2TB SSD, 16\" WQXGA 240Hz.",
      "description": "Mesin buas dari Acer untuk hardcore gamer. Desain agresif dengan performa ekstrem dari RTX 4080, siap melibas game AAA modern dengan setting grafis rata kanan tanpa hambatan sedikitpun."
    },
    {
      "brand": "Asus", 
      "model": "ROG Strix SCAR 18", 
      "price": "Rp 45.000.000", 
      "image": "rog.png", 
      "specs": "Intel Core i9-13980HX, RTX 4090 16GB, 64GB DDR5, 2TB+2TB SSD, 18\" QHD 240Hz.",
      "description": "Laptop idaman para antusias esports sejati. Dibekali komponen kasta tertinggi di kelasnya dan sistem pendingin liquid metal eksklusif ROG untuk menjaga suhu dan frame-rate tetap stabil saat turnamen."
    },
    {
      "brand": "MSI", 
      "model": "Stealth GS66 12UHS", 
      "price": "Rp 38.900.000", 
      "image": "msi.png", 
      "specs": "Intel Core i9-12900H, RTX 3080Ti 16GB, 32GB DDR5, 1TB SSD, 15.6\" UHD 120Hz.",
      "description": "Desain tipis dan elegan layaknya laptop bisnis profesional, namun menyimpan tenaga monster di dalamnya. Sangat ideal untuk kreator konten dan gamer yang membutuhkan mobilitas tinggi."
    },
  ];

  @override
  void initState() {
    super.initState();
    // Saat pertama kali halaman dibuka, tampilkan semua produk
    _filteredProducts = List.from(products);
  }

  // Fungsi untuk memfilter list berdasarkan inputan di SearchBar
  void _runFilter(String enteredKeyword) {
    List<Map<String, dynamic>> results = [];
    if (enteredKeyword.isEmpty) {
      // Jika kosong, tampilkan semua
      results = List.from(products);
    } else {
      // Filter berdasarkan brand atau model laptop
      results = products.where((product) =>
          product["model"].toLowerCase().contains(enteredKeyword.toLowerCase()) ||
          product["brand"].toLowerCase().contains(enteredKeyword.toLowerCase())).toList();
    }

    // Refresh UI
    setState(() {
      _filteredProducts = results;
    });
  }

  Widget _buildDrawerItem(IconData icon, String title, VoidCallback onTap, bool isActive, {bool isLogout = false}) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        gradient: isActive
            ? LinearGradient(
                colors: [
                  const Color(0xFF00F5FF).withOpacity(0.2),
                  const Color(0xFF0096FF).withOpacity(0.1),
                ],
              )
            : null,
        borderRadius: BorderRadius.circular(12),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          color: isLogout ? const Color(0xFFFF2E63) : (isActive ? const Color(0xFF00F5FF) : Colors.white70),
        ),
        title: Text(
          title,
          style: TextStyle(
            fontWeight: isActive ? FontWeight.bold : FontWeight.w500,
            color: isLogout ? const Color(0xFFFF2E63) : (isActive ? const Color(0xFF00F5FF) : Colors.white70),
          ),
        ),
        onTap: onTap,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A2E),
        elevation: 0,
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF00F5FF), Color(0xFF0096FF)],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.sports_esports, color: Colors.white, size: 20),
            ),
            const SizedBox(width: 12),
             Text(
              "GamingForge",
              style: TextStyle(
                fontWeight: FontWeight.w900,
                fontSize: 22,
                letterSpacing: 0.5,
                foreground: Paint()
                  ..shader = const LinearGradient(
                    colors: [Color(0xFF00F5FF), Color(0xFF0096FF)],
                  ).createShader(const Rect.fromLTWH(0, 0, 200, 70)),
              ),
            ),
          ],
        ),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 16),
            decoration: BoxDecoration(
              color: const Color(0xFF00F5FF).withOpacity(0.2),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: const Color(0xFF00F5FF).withOpacity(0.3), width: 1),
            ),
            child: IconButton(
              onPressed: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const CartPage()));
              },
              icon: const Icon(Icons.shopping_bag_outlined, color: Color(0xFF00F5FF)),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        backgroundColor: const Color(0xFF1A1A2E),
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 30),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    const Color(0xFF00F5FF).withOpacity(0.3),
                    const Color(0xFF0096FF).withOpacity(0.1),
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(3),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [Color(0xFF00F5FF), Color(0xFF0096FF)],
                      ),
                    ),
                    child: Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: Color(0xFF1A1A2E),
                      ),
                      padding: const EdgeInsets.all(3),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.white,
                        child: ClipOval(
                          child: Image.asset(
                            "images/ibn2.jpeg",
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => const Icon(Icons.person, size: 40, color: Color(0xFF0F0F1E)),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Ibnu Said",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "ibnusaid500@gmail.com",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            _buildDrawerItem(Icons.home_rounded, "Dashboard", () => Navigator.pop(context), true),
            
            // --- MENU COUNTER SOAL ---
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: ListTile(
                leading: const Icon(Icons.ads_click, color: Colors.white70),
                title: const Text("Counter", style: TextStyle(color: Colors.white70, fontWeight: FontWeight.w500)),
                trailing: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Color(0xFF00F5FF),
                    shape: BoxShape.circle,
                  ),
                  child: Text(
                    _drawerCounter.toString(),
                    style: const TextStyle(
                      color: Color(0xFF0F0F1E),
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                    ),
                  ),
                ),
                onTap: () {
                  // Aksi untuk menambah counter
                  setState(() {
                    _drawerCounter++;
                  });
                },
              ),
            ),

            _buildDrawerItem(Icons.photo_library_rounded, "Gallery Laptop", () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const GalleryPage()));
            }, false),
            _buildDrawerItem(Icons.favorite_rounded, "Laptop Favorit", () {
              Navigator.pop(context);
              // Jangan lupa import 'favorite_page.dart' di bagian atas file!
              Navigator.push(context, MaterialPageRoute(builder: (context) => const FavoritePage()));
            }, false),
            _buildDrawerItem(Icons.person_rounded, "Profil Developer", () {
              Navigator.pop(context);
              Navigator.push(context, MaterialPageRoute(builder: (context) => const AboutPage()));
            }, false),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Divider(color: Color(0xFF2E2E4E), thickness: 1),
            ),
            _buildDrawerItem(Icons.logout_rounded, "Logout", () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage())), false, isLogout: true),
          ],
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- SEARCH BAR AREA ---
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
              child: Container(
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A2E),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: const Color(0xFF00F5FF).withOpacity(0.4), width: 1.5),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF00F5FF).withOpacity(0.1),
                      blurRadius: 15,
                      spreadRadius: 1,
                    ),
                  ],
                ),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) => _runFilter(value), // Panggil fungsi filter saat mengetik
                  style: const TextStyle(color: Colors.white, fontSize: 15),
                  decoration: InputDecoration(
                    hintText: "Cari laptop...",
                    hintStyle: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 15),
                    prefixIcon: const Icon(Icons.search_rounded, color: Color(0xFF00F5FF)),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                ),
              ),
            ),
            
           // --- BANNER PROMO (DIPERBAIKI & DICERAHKAN) ---
Container(
  width: double.infinity,
  height: 240,
  margin: const EdgeInsets.all(20),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(30),
    // 1. Mencerahkan Warna Banner: Mengganti warna gelap dengan gradasi Cyan/Biru terang yang transparan
    gradient: LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: [
        const Color(0xFF00F5FF).withOpacity(0.3), // Cyan terang transparan
        const Color(0xFF0096FF).withOpacity(0.15), // Biru terang transparan
      ],
    ),
    boxShadow: [
      BoxShadow(
        // Mencerahkan bayangan agar efek glow lebih terasa
        color: const Color(0xFF00F5FF).withOpacity(0.4),
        blurRadius: 30,
        spreadRadius: -2, // Sedikit kurangi spread agar glow lebih fokus
      ),
    ],
  ),
  child: Stack(
    children: [
      // Gambar Latar Belakang (Opacity ditingkatkan agar lebih cerah)
      ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Opacity(
          opacity: 0.8, // <-- Ditingkatkan dari 0.6 agar gambar lebih jelas/cerah
          child: Image.asset(
            "images/banner3.png",
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
            errorBuilder: (context, error, stackTrace) => Container(),
          ),
        ),
      ),

      // Lapisan Gradasi Subtle (Opsional, untuk kontras teks di tengah)
      Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          gradient: RadialGradient(
            colors: [
              Colors.white.withOpacity(0.0), // Tengah bening
              const Color(0xFF00F5FF).withOpacity(0.1), // Sedikit warna di pinggir
            ],
            stops: [0.5, 1.0],
          ),
        ),
      ),

      // Teks Konten (Dipindahkan ke Tengah)
      Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
          // 2. Memindahkan ke Tengah Vertikal & Horizontal
          mainAxisAlignment: MainAxisAlignment.center, // Tengah secara Vertikal
          crossAxisAlignment: CrossAxisAlignment.center, // Tengah secara Horizontal untuk anak Column
          children: [
            // Tag PROMO SPESIAL
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF00F5FF), Color(0xFF0096FF)],
                ),
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Text(
                "PROMO SPESIAL",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 15),

            // Judul LEVEL UP (Tambahkan TextAlign.center)
            const Text(
              "LEVEL UP\nYOUR GAME",
              textAlign: TextAlign.center, // <-- Ratakan tengah teks multiline
              style: TextStyle(
                color: Colors.white,
                fontSize: 32,
                fontWeight: FontWeight.w900,
                height: 1.1,
                letterSpacing: 1,
              ),
            ),
            const SizedBox(height: 20), // Sedikit tambah jarak

            // Baris Diskon (Ganti MainAxisAlignment ke Center)
            Row(
              mainAxisAlignment: MainAxisAlignment.center, // <-- Ratakan tengah isi Row
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF2E63),
                    borderRadius: BorderRadius.circular(8),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFFFF2E63).withOpacity(0.5),
                        blurRadius: 15,
                      ),
                    ],
                  ),
                  child: const Text(
                    "DISKON 15%",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                const Text(
                  "Untuk semua produk!",
                  style: TextStyle(
                    color: Colors.white, // Sudah putih terang sesuai kode asli
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    ],
  ),
),
            
            // KATEGORI DIHAPUS DARI SINI 
            
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Katalog Premium",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  letterSpacing: 0.5,
                ),
              ),
            ),
            
            // --- GRID PRODUK TERFILTER ---
            // Jika hasil pencarian kosong, tampilkan pesan
            _filteredProducts.isEmpty 
            ? Container(
                width: double.infinity,
                padding: const EdgeInsets.only(top: 50),
                child: Column(
                  children: [
                    Icon(Icons.search_off, size: 80, color: Colors.white.withOpacity(0.2)),
                    const SizedBox(height: 15),
                    Text(
                      "Laptop tidak ditemukan",
                      style: TextStyle(color: Colors.white.withOpacity(0.5), fontSize: 16),
                    ),
                  ],
                ),
              )
            : GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.68,
                  crossAxisSpacing: 15,
                  mainAxisSpacing: 15,
                ),
                itemCount: _filteredProducts.length, // Ubah menjadi _filteredProducts
                itemBuilder: (context, index) {
                  final product = _filteredProducts[index]; // Ubah menjadi _filteredProducts
                  return GestureDetector(
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => DetailProductPage(product: product)),
                    ),
                    child: Container(
                      decoration: BoxDecoration(
                        color: const Color(0xFF1A1A2E),
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: const Color(0xFF00F5FF).withOpacity(0.2),
                          width: 1,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF00F5FF).withOpacity(0.1),
                            blurRadius: 15,
                            spreadRadius: -3,
                          ),
                        ],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Container(
                              padding: const EdgeInsets.all(15),
                              decoration: BoxDecoration(
                                gradient: RadialGradient(
                                  colors: [
                                    const Color(0xFF00F5FF).withOpacity(0.1),
                                    Colors.transparent,
                                  ],
                                ),
                                borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
                              ),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(15),
                                child: Image.asset(
                                  "images/${product['image']}",
                                  fit: BoxFit.contain,
                                  errorBuilder: (context, error, stackTrace) => Container(
                                    color: Colors.transparent,
                                    child: const Center(
                                      child: Icon(Icons.laptop_mac, color: Color(0xFF00F5FF), size: 50),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(15),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: const Color(0xFF00F5FF).withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
                                  child: Text(
                                    product['brand'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 10,
                                      color: Color(0xFF00F5FF),
                                      letterSpacing: 1,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  product['model'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  product['price'],
                                  style: const TextStyle(
                                    color: Color(0xFFFF2E63),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
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
              ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}