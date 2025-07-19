import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:statemanager/models/carrinho.dart';
import 'package:statemanager/screens/telaprincipal';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => Carrinho(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  TelaPrincipal ? screen = TelaPrincipal();
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Carrinho com Provider',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: screen,
    );
  }
}