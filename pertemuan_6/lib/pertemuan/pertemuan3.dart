import 'package:flutter/material.dart';

class Pertemuan3Page extends StatelessWidget {
  const Pertemuan3Page({super.key});

  final List<String> data = const [
    "Item 1",
    "Item 2",
    "Item 3",
    "Item 4",
    "Item 5",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Pertemuan 3")),
      body: ListView.builder(
        itemCount: data.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.list),
            title: Text(data[index]),
          );
        },
      ),
    );
  }
}
