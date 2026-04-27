import 'package:flutter/material.dart';
import 'package:pertemuan_6/page/dashboard.dart';
import 'package:pertemuan_6/page/profile.dart';
import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

void main(){
 runApp(MyApp());
}

class MyApp extends StatefulWidget {
 @override
 _MyAppState createState()=>_MyAppState();
}

class _MyAppState extends State<MyApp>{

 final List<Widget> _pages = [
   DashboardPage(),
   ProfilePage()
 ];

 var currentPage = 0;

 @override
 Widget build(BuildContext context){
   return MaterialApp(
    debugShowCheckedModeBanner:false,
    home: Scaffold(
      body: _pages[currentPage],
      bottomNavigationBar: SalomonBottomBar(
        currentIndex: currentPage,
        onTap:(i){
          setState(() {
            currentPage=i;
          });
        },
        items:[
          SalomonBottomBarItem(
            icon: Icon(Icons.home),
            title: Text("Beranda"),
          ),
          SalomonBottomBarItem(
            icon: Icon(Icons.person),
            title: Text("Profile"),
          ),
        ],
      ),
    ),
   );
 }
}