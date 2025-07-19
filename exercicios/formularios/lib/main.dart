import 'package:flutter/material.dart';
import 'package:formularios/screens/details_screen.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Passagem de Argumentos',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
      // Registrar as rotas nomeadas
      routes: {
        '/details': (context) => const DetailsScreen(),
      },
    );
  }
}