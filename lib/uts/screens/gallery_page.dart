// lib/screens/gallery_page.dart
import 'package:flutter/material.dart';

class GalleryPage extends StatelessWidget {
  const GalleryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> images = ["loq.png", "legion.png", "tuf.png", "predator.png", "rog.png", "msi.png"];

    return Scaffold(
      backgroundColor: const Color(0xFF0F0F1E),
      appBar: AppBar(
        backgroundColor: const Color(0xFF1A1A2E),
        elevation: 0,
        title: const Text("Gallery Gaming"),
      ),
      body: GridView.builder(
        padding: const EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 15,
          mainAxisSpacing: 15,
        ),
        itemCount: images.length,
        itemBuilder: (context, index) {
          return Container(
            padding: const EdgeInsets.all(15),
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
            child: Image.asset(
              "images/${images[index]}",
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => const Icon(
                Icons.image,
                size: 50,
                color: Color(0xFF00F5FF),
              ),
            ),
          );
        },
      ),
    );
  }
}