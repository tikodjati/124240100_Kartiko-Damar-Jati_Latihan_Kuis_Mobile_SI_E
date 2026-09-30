import 'package:latihan_kuis/root.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Menu Resto',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
        scaffoldBackgroundColor: const Color(0xFFFFF5F0),
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.deepOrange,
          foregroundColor: Colors.white,
          centerTitle: true,
        ),
      ),
      // GANTI 'Nama Kamu' dengan nama kamu
      home: const Root(nama: 'Nama Kamu'),
    );
  }
}
