import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

class Cliente {
  int codigo;
  String nome;
  int tipoCliente;

  Cliente({
    required this.codigo,
    required this.nome,
    required this.tipoCliente,
  });

  Map<String, dynamic> toJson() {
    return {
      'codigo': codigo,
      'nome': nome,
      'tipoCliente': tipoCliente,
    };
  }
}

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

class ItemPedido {
  int sequencial;
  String descricao;
  int quantidade;
  double valor;

  ItemPedido({
    required this.sequencial,
    required this.descricao,
    required this.quantidade,
    required this.valor,
  });

  Map<String, dynamic> toJson() {
    return {
      'sequencial': sequencial,
      'descricao': descricao,
      'quantidade': quantidade,
      'valor': valor,
    };
  }
}

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

class PedidoVenda {
  String codigo;
  DateTime data;
  double valorPedido;
  Cliente cliente;
  Vendedor vendedor;
  List<ItemPedido> itens;

  PedidoVenda({
    required this.codigo,
    required this.data,
    required this.valorPedido,
    required this.cliente,
    required this.vendedor,
    required this.itens,
  });

  double calcularPedido() {
    return itens.fold(0, (total, item) => total + (item.valor * item.quantidade));
  }

  Map<String, dynamic> toJson() {
    return {
      'codigo': codigo,
      'data': data.toIso8601String(),
      'valorPedido': valorPedido,
      'cliente': cliente.toJson(),
      'vendedor': vendedor.toJson(),
      'itens': itens.map((item) => item.toJson()).toList(),
    };
  }
}

void main() {
  // Criando objetos de exemplo
  final cliente = Cliente(
    codigo: 1,
    nome: "João Silva",
    tipoCliente: 1,
  );

  final vendedor = Vendedor(
    codigo: 101,
    nome: "Maria Souza",
    comissao: 5.0,
  );

  final veiculo = Veiculo(
    codigo: 1001,
    descricao: "Carro Modelo X 2023",
    valor: 85000.00,
  );

  final itensPedido = [
    ItemPedido(
      sequencial: 1,
      descricao: veiculo.descricao,
      quantidade: 1,
      valor: veiculo.valor,
    ),
    ItemPedido(
      sequencial: 2,
      descricao: "Seguro Total",
      quantidade: 1,
      valor: 2500.00,
    ),
  ];

  final pedido = PedidoVenda(
    codigo: "PV${Random().nextInt(10000)}",
    data: DateTime.now(),
    valorPedido: 0, // Será calculado
    cliente: cliente,
    vendedor: vendedor,
    itens: itensPedido,
  );

  // Calculando o valor total do pedido
  pedido.valorPedido = pedido.calcularPedido();

  // Convertendo para JSON
  final jsonData = pedido.toJson();
  final jsonString = JsonEncoder.withIndent('  ').convert(jsonData);

  print("Dados do Pedido em JSON:");
  print(jsonString);

  // Enviando por email (simulado)
  enviarPorEmail(jsonString);
}

void enviarPorEmail(String jsonString) async {
// Configurar servidor SMTP do Gmail
  final email = '';
  final password = '';
  final smtpServer = gmail(email, password);
  
  // Criar mensagem
  final message = Message()
    ..from = Address(email, '')
    ..recipients.add('')
    ..subject = 'Dados de um pedido de venda'
    ..text = jsonString;

  try {
    print('Enviando e-mail via Gmail...');
    final sendReport = await send(message, smtpServer);
    print('✅ E-mail enviado com sucesso!');
    print('Detalhes: ${sendReport.toString()}');
  } on MailerException catch (e) {
    print('❌ Erro ao enviar e-mail:');
    print(e.message);
    print('\nPossíveis soluções:');
    print('1. Verifique se ativou "Acesso a app menos seguro" na sua conta Google');
    print('2. Ou crie uma "Senha de app" para aplicativos');
    print('3. Verifique se a autenticação de dois fatores está configurada corretamente');
  } catch (e) {
    print('❌ Erro desconhecido: $e');
  }  
}