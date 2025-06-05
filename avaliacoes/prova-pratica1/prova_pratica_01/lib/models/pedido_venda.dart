// Arquivo: lib/models/pedido_venda.dart
import 'package:prova_pratica_01/models/cliente.dart';
import 'package:prova_pratica_01/models/item_pedido.dart';
import 'package:prova_pratica_01/models/vendedor.dart';

class PedidoVenda {
  String codigo;
  DateTime data;
  double valorPedido;
  Cliente cliente;
  Vendedor vendedor;
  Veiculo veiculo;
  List<ItemPedido> itens;

  PedidoVenda({
    required this.codigo,
    required this.data,
    required this.valorPedido,
    required this.cliente,
    required this.vendedor,
    required this.veiculo,
    required this.itens,
  });

  double calcularPedido() {
    // Cálculo do valor total do pedido baseado nos itens
    double total = 0;
    for (var item in itens) {
      total += item.valor * item.quantidade;
    }
    return total;
  }

  Map<String, dynamic> toJson() {
    return {
      'codigo': codigo,
      'data': data.toIso8601String(),
      'valorPedido': valorPedido,
      'cliente': cliente.toJson(),
      'vendedor': vendedor.toJson(),
      'veiculo': veiculo.toJson(),
      'itens': itens.map((item) => item.toJson()).toList(),
    };
  }
}