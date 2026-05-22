import 'package:flutter/material.dart';

void main() {
  runApp(const MyHomePage());
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pertemuan 5',
      theme: ThemeData(
        primaryColor: Colors.blue,
      ),
      home: const MyLayout(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyLayout extends StatelessWidget {
  const MyLayout({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('List Produk')),
      body: ListView(
        shrinkWrap: true,
        padding: const EdgeInsets.fromLTRB(2.0, 10.0, 2.0, 10.0),
        children: const <Widget>[
          ProductBox(
            name: "Iphone 13 128GB Midngiht",
            description: "iPhone 13 Midnight adalah varian warna hitam pekat yang elegan dan premium, menampilkan desain dengan notch 20% lebih kecil dan bodi alumunium tahan air IP68.",
            price: 467 ,
            image: "ip13.png",
          ),
          ProductBox(
            name: "Lenovo LOQ 15IRX9",
            description: "laptop gaming entry-level bertenaga yang menggunakan prosesor Intel Core HX Generasi ke-13 dan GPU NVIDIA GeForce RTX.",
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
      height: 120,
      child: Card(
        child: Row(
          children: <Widget>[
            Image.asset("images/$image"),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: <Widget>[
                    Text(
                      name,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text(description),
                    Text("Price: \$$price"),
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