import 'package:flutter/material.dart';

class Pertemuan10Page extends StatelessWidget {
  const Pertemuan10Page({super.key});

  @override
  Widget build(BuildContext context) {
    // Membungkus Scaffold dengan DefaultTabController untuk mengatur navigasi Tab
    return DefaultTabController(
      length: 3, // Jumlah tab yang diinginkan
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Pertemuan 10: TabBar',
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
          backgroundColor: const Color(0xFF5B50E8),
          iconTheme: const IconThemeData(color: Colors.white),
          // Meletakkan TabBar di bagian bawah (bottom) AppBar
          bottom: const TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            indicatorColor: Colors.white,
            tabs: [
              Tab(icon: Icon(Icons.home), text: "Beranda"),
              Tab(icon: Icon(Icons.message), text: "Pesan"),
              Tab(icon: Icon(Icons.person), text: "Profil"),
            ],
          ),
        ),
        // TabBarView harus memiliki jumlah children yang sama dengan 'length' di atas
        body: const TabBarView(
          children: [
            Center(child: Text('Konten Halaman Beranda', style: TextStyle(fontSize: 18))),
            Center(child: Text('Konten Halaman Pesan', style: TextStyle(fontSize: 18))),
            Center(child: Text('Konten Halaman Profil', style: TextStyle(fontSize: 18))),
          ],
        ),
      ),
    );
  }
}
