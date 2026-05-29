import 'package:flutter/material.dart';
import 'package:pertemuan_6/pertemuan/pertemuan1.dart';
import 'package:pertemuan_6/pertemuan/pertemuan2.dart';
import 'package:pertemuan_6/pertemuan/pertemuan3.dart';
import 'package:pertemuan_6/pertemuan/pertemuan4.dart';
import 'package:pertemuan_6/pertemuan/pertemuan5.dart';
import 'package:pertemuan_6/pertemuan/pertemuan6.dart';
import 'package:pertemuan_6/pertemuan/pertemuan7.dart';
import 'package:pertemuan_6/pertemuan/pertemuan8.dart';
import 'package:pertemuan_6/pertemuan/pertemuan9.dart';
import 'package:pertemuan_6/pertemuan/pertemuan10.dart';

class DashboardPage extends StatelessWidget {
  DashboardPage({super.key});

  final List<Map<String, dynamic>> menuItems = [
    {
      "title": "Pertemuan 1",
      "icon": Icons.looks_one,
      "color": Colors.red,
      "page": Pertemuan1Page(),
    },
    {
      "title": "Pertemuan 2",
      "icon": Icons.looks_two,
      "color": Colors.orange,
      "page": Pertemuan2Page(),
    },
    {
      "title": "Pertemuan 3",
      "icon": Icons.looks_3,
      "color": Colors.amber,
      "page": Pertemuan3Page(),
    },
    {
      "title": "Pertemuan 4",
      "icon": Icons.looks_4,
      "color": Colors.teal,
      "page": Pertemuan4Page(),
    },
    {
      "title": "Pertemuan 5",
      "icon": Icons.looks_5,
      "color": Colors.blue,
      "page": ListviewPage(),
    },
    {
      "title": "Pertemuan 6",
      "icon": Icons.looks_6,
      "color": Colors.green,
      "page": CheckboxPage(),
    },
    {
      "title": "Pertemuan 7",
      "icon": Icons.filter_7,
      "color": Colors.orange,
      "page": RadiobuttonPage(),
    },
    {
      "title": "Pertemuan 8",
      "icon": Icons.filter_8,
      "color": Colors.purple,
      "page": AutocompletespinPage(),
    },
    {
      "title": "Pertemuan 9",
      "icon": Icons.filter_9,
      "color": Colors.deepPurple,
      "page": Pertemuan9Page(),
    },
       {
      "title": "Pertemuan 10",
    "icon": Icons.star,
      "color": Colors.deepPurple,
      "page": Pertemuan10Page(),
    },
    
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FB),

      appBar: AppBar(
        title: const Text(
          "Dashboard",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        elevation: 0,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0xFF5B50E8),
                Color(0xFF7B74FF),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(24),
          ),
        ),
      ),

      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: menuItems.length,
        itemBuilder: (context, index) {
          final item = menuItems[index];

          return Padding(
            padding: const EdgeInsets.only(bottom: 14),
            child: _buildMenuCard(
              context,
              title: item["title"],
              icon: item["icon"],
              color: item["color"],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => item["page"],
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildMenuCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(22),
        splashColor: color.withOpacity(0.15),
        highlightColor: Colors.transparent,
        onTap: onTap,
        child: Ink(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(22),
            gradient: LinearGradient(
              colors: [
                color.withOpacity(0.15),
                Colors.white,
              ],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
            border: Border.all(
              color: color.withOpacity(0.15),
            ),
            boxShadow: [
              BoxShadow(
                color: color.withOpacity(0.12),
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 18,
              vertical: 18,
            ),
            child: Row(
              children: [

                // ICON
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.18),
                    borderRadius: BorderRadius.circular(18),
                  ),
                  child: Icon(
                    icon,
                    size: 30,
                    color: color,
                  ),
                ),

                const SizedBox(width: 18),

                // TITLE
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.bold,
                          color: Colors.grey[800],
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        "Buka halaman $title",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey[500],
                        ),
                      ),
                    ],
                  ),
                ),

                // ARROW
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.12),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios,
                    size: 15,
                    color: color,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
