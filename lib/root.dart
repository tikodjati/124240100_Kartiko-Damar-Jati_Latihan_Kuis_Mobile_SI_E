import 'package:latihan_kuis/home.dart';
import 'package:latihan_kuis/profil.dart';
import 'package:flutter/material.dart';

class Root extends StatefulWidget {
  final String nama;

  const Root({super.key, required this.nama});

  @override
  State<Root> createState() => _RootState();
}

class _RootState extends State<Root> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const HomePage(),
      ProfilePage(nama: widget.nama),
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepOrange,
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.restaurant_menu),
            label: 'Menu',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profil'),
        ],
      ),
    );
  }
}
