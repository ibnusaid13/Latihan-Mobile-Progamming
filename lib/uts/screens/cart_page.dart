// lib/uts/screens/cart_page.dart
import 'package:flutter/material.dart';
import 'package:mobileprogramming/uts/database_helper.dart'; // Import Database Helper
import 'success_page.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  late Future<List<Map<String, dynamic>>> _cartList;

  @override
  void initState() {
    super.initState();
    _refreshCart();
  }

  void _refreshCart() {
    setState(() {
      _cartList = DatabaseHelper.instance.getCartItems();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A2E),
        elevation: 0,
        title: const Text("Keranjang Belanja"),
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _cartList,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFF00F5FF)));
          }

          final cartItems = snapshot.data ?? [];

          if (cartItems.isEmpty) {
            return _buildEmptyCart();
          }

          return _buildCartList(cartItems);
        },
      ),
    );
  }

  Widget _buildEmptyCart() {
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
                color: const Color(0xFF00F5FF).withOpacity(0.3),
                width: 2,
              ),
            ),
            child: const Icon(
              Icons.shopping_bag_outlined,
              size: 80,
              color: Color(0xFF00F5FF),
            ),
          ),
          const SizedBox(height: 25),
          const Text(
            "Keranjang Kosong",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "Mulai belanja sekarang!",
            style: TextStyle(
              fontSize: 14,
              color: Colors.white.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartList(List<Map<String, dynamic>> cartItems) {
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: cartItems.length,
            itemBuilder: (context, index) {
              final item = cartItems[index];
              return Container(
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  color: const Color(0xFF1A1A2E),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: const Color(0xFF00F5FF).withOpacity(0.2),
                    width: 1,
                  ),
                ),
                child: ListTile(
                  contentPadding: const EdgeInsets.all(15),
                  leading: Container(
                    width: 70,
                    height: 70,
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F0F1E),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Image.asset(
                      "images/${item['image']}",
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) => const Icon(
                        Icons.laptop,
                        color: Color(0xFF00F5FF),
                      ),
                    ),
                  ),
                  title: Text(
                    item['model'],
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  subtitle: Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      item['price'],
                      style: const TextStyle(
                        color: Color(0xFFFF2E63),
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                  trailing: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFFF2E63).withOpacity(0.2),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.delete_outline, color: Color(0xFFFF2E63)),
                      onPressed: () async {
                        // Menghapus item dari SQLite berdasarkan ID autoincrement
                        await DatabaseHelper.instance.removeFromCart(item['id']);
                        _refreshCart(); // Perbarui UI
                      },
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        Container(
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
                colors: [Color(0xFF00D26A), Color(0xFF00A854)],
              ),
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF00D26A).withOpacity(0.4),
                  blurRadius: 20,
                  spreadRadius: 2,
                ),
              ],
            ),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 60),
                backgroundColor: Colors.transparent,
                shadowColor: Colors.transparent,
              ),
              onPressed: () async {
                // Saat checkout, teruskan data ke SuccessPage lalu bersihkan tabel Cart
                List<Map<String, dynamic>> checkoutItems = List.from(cartItems);
                
                await DatabaseHelper.instance.clearCart(); // Hapus cart di database
                
                if (!context.mounted) return;
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SuccessPage(purchasedItems: checkoutItems),
                  ),
                );
              },
              child: const Text(
                "CHECKOUT SEKARANG",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}