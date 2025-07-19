import 'package:flutter/material.dart';
import 'package:statemanager/models/item.dart';

class Carrinho with ChangeNotifier {
  final List<Item> _itens = [];

  List<Item> get itens => _itens;

  double get total => _itens.fold(0, (sum, item) => sum + item.valor);

  void adicionar(Item item) {
    _itens.add(item);
    notifyListeners();
  }

  void remover(Item item) {
    _itens.remove(item);
    notifyListeners();
  }
}
