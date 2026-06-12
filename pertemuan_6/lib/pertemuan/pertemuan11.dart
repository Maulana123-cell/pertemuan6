import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Option Menu"),
        actions: [
          // Komponen Dropdown Menu di pojok kanan atas AppBar
          PopupMenuButton<String>(
            onSelected: (value) {
              // Aksi saat salah satu menu diklik (muncul di console log)
              print("Kamu memilih menu: $value");
              
              // Contoh penambahan interaksi SnackBar biar keren
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Memilih: $value')),
              );
            },
            itemBuilder: (BuildContext context) => [
              const PopupMenuItem<String>(
                value: 'edit',
                child: Text('Edit'),
              ),
              const PopupMenuItem<String>(
                value: 'delete',
                child: Text('Hapus'),
              ),
              const PopupMenuItem<String>(
                value: 'share',
                child: Text('Bagikan'),
              ),
            ],
          ),
        ],
      ),
      body: const Center(
        child: Text(
          "Klik ikon titik tiga di pojok kanan atas\nuntuk melihat Option Menu!",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, color: Colors.grey),
        ),
      ),
    );
  }
}
