// Arquivo: lib/models/vendedor.dart
class Vendedor {
  int codigo;
  String nome;
  double comissao;

  Vendedor({
    required this.codigo,
    required this.nome,
    required this.comissao,
  });

  Map<String, dynamic> toJson() {
    return {
      'codigo': codigo,
      'nome': nome,
      'comissao': comissao,
    };
  }
}

// Arquivo: lib/models/veiculo.dart
class Veiculo {
  int codigo;
  String descricao;
  double valor;

  Veiculo({
    required this.codigo,
    required this.descricao,
    required this.valor,
  });

  Map<String, dynamic> toJson() {
    return {
      'codigo': codigo,
      'descricao': descricao,
      'valor': valor,
    };
  }
}