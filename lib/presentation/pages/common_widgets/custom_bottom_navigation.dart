import 'package:flutter/material.dart';

class CustomBottomNavigation extends StatelessWidget {
  const CustomBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: const Color(0xFF121e3c),
        primaryColor: const Color(0xFF121e3c),
        splashColor: const Color(0xff10172c),
      ),
      child: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey.shade700,
        onTap: (_) {},
        currentIndex: 1,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.folder, size: 40), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.compare_arrows, size: 40), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.monetization_on, size: 40), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.bar_chart, size: 40), label: ""),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings, size: 40), label: "")
        ],
      ),
    );
  }
}
