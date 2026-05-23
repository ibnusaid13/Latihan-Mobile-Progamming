import 'package:flutter/material.dart';

// main() dibungkus MaterialApp agar tetap bisa di-run mandiri jika dites
void main() {
  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: MyHomePage(),
  ));
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // PERBAIKAN 1: Hapus MaterialApp berlapis, langsung return MyLayout
    return const MyLayout();
  }
}

class MyLayout extends StatelessWidget {
  const MyLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'List Produk',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
        // PERBAIKAN 2: Tambahkan tombol back
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
        children: const <Widget>[
          ProductBox(
            name: "Iphone 13 128GB Midnight",
            // PERBAIKAN 3A: Kalimat deskripsi diperpendek
            description: "Varian warna hitam pekat elegan dengan bodi alumunium tahan air IP68.",
            price: 467,
            image: "ip13.png",
          ),
          ProductBox(
            name: "Lenovo LOQ 15IRX9",
            // PERBAIKAN 3A: Kalimat deskripsi diperpendek
            description: "Laptop gaming entry-level bertenaga dengan Intel Core HX Gen-13 dan GPU RTX.",
            price: 867,
            image: "loq.png",
          ),
        ],
      ),
    );
  }
}

class ProductBox extends StatelessWidget {
  const ProductBox({
    super.key,
    required this.name,
    required this.description,
    required this.price,
    required this.image,
  });

  final String name;
  final String description;
  final int price;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(2),
      height: 120, // Tinggi container (rawan overflow jika teks terlalu panjang)
      child: Card(
        child: Row(
          children: <Widget>[
            // Beri batas ukuran gambar agar proporsional dan tidak error
            Image.asset(
              "images/$image", 
              width: 100, 
              height: 100, 
              fit: BoxFit.cover,
            ), 
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start, // Agar teks rata kiri
                  children: <Widget>[
                    Text(
                      name,
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                    ),
                    // PERBAIKAN 3B: Batasi jumlah baris agar tidak overflow/melebihi kotak
                    Text(
                      description,
                      maxLines: 2, // Maksimal 2 baris
                      overflow: TextOverflow.ellipsis, // Beri titik-titik (...) jika kepanjangan
                      style: const TextStyle(fontSize: 12, color: Colors.grey),
                    ),
                    Text(
                      "Price: \$$price",
                      style: const TextStyle(
                        color: Colors.red, 
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}