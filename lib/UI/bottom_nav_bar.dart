import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:zaqapp/main/home.dart';


import 'package:zaqapp/main/settings.dart';
import 'package:zaqapp/main/history.dart';


class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int _page = 1;

  final List<Widget> _pages = const [       // index 0
    HistoryPage(),     // index 1 index 2      // index 3
    Homepage(), 
    SettingsPage(),    // index 4
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_page],

bottomNavigationBar: Container(
  margin: const EdgeInsets.only(
    left: 16,
    right: 16,
    bottom: 16,
  ),
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(40),
    boxShadow: [
      BoxShadow(
        color: Colors.black.withOpacity(0.15),
        blurRadius: 20,
        offset: const Offset(0, 8),
      ),
    ],
  ),
  child: ClipRRect(
    borderRadius: BorderRadius.circular(40),
    child: CurvedNavigationBar(
      index: _page,
      height: 60,
      backgroundColor: Colors.transparent, // IMPORTANT
      color: Colors.white,
      buttonBackgroundColor: Colors.white,
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 500),
      items: const [
        Icon(Icons.history, size: 30),
        Icon(Icons.home, size: 30),
        Icon(Icons.settings, size: 30),
      ],
      onTap: (index) {
        setState(() {
          _page = index;
        });
      },
    ),
  ),
),

    );
  }
}
