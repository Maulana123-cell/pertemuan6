import 'package:flutter/material.dart';

class Pertemuan1Page extends StatelessWidget {
  const Pertemuan1Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pertemuan 1")),
      body: const Center(
        child: Text(
          "Hello Flutter 👋\nPertemuan 1",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
