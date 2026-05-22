import 'package:flutter/material.dart';

class Pertemuan2Page extends StatefulWidget {
  const Pertemuan2Page({super.key});

  @override
  State<Pertemuan2Page> createState() => _Pertemuan2PageState();
}

class _Pertemuan2PageState extends State<Pertemuan2Page> {
  final TextEditingController _controller = TextEditingController();
  String hasil = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pertemuan 2")),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: "Masukkan Nama",
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  hasil = _controller.text;
                });
              },
              child: const Text("Tampilkan"),
            ),
            const SizedBox(height: 20),
            Text("Hasil: $hasil"),
          ],
        ),
      ),
    );
  }
}
