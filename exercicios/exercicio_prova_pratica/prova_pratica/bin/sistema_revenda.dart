// lib/sistema_revenda.dart

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
    return {'codigo': codigo, 'nome': nome, 'tipoCliente': tipoCliente};
  }
}

class Veiculo {
  int codigo;
  String descricao;
  double valor;

  Veiculo({required this.codigo, required this.descricao, required this.valor});

  Map<String, dynamic> toJson() {
    return {'codigo': codigo, 'descricao': descricao, 'valor': valor};
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

  Vendedor({required this.codigo, required this.nome, required this.comissao});

  Map<String, dynamic> toJson() {
    return {'codigo': codigo, 'nome': nome, 'comissao': comissao};
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
    return itens.fold(
      0,
      (total, item) => total + (item.valor * item.quantidade),
    );
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
  final cliente = Cliente(codigo: 1, nome: "João Silva", tipoCliente: 1);

  final vendedor = Vendedor(codigo: 101, nome: "Maria Souza", comissao: 5.0);

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

Future<void> enviarPorEmail(String jsonString) async {
  const caminho = '.dart_tool/dados_email.json';

  try {
    final conta = await lerContaEmail(caminho);

    print('Email: ${conta.email}');

    // Cuidado ao exibir a senha em produção!
    print('Senha: ${conta.senha}');

    final smtpServer = gmail(conta.email!, conta.senha!);

    final message =
        Message()
          ..from = Address(conta.email!)
          ..recipients.add('sousaedvaldo@gmail.com')
          ..subject = 'Dados do Sistema de Revenda'
          ..text = jsonString;
   
    // Enviar e-mail
    try {
      print("\nEnviando dados para taveira@ifce.edu.br...");
      final sendReport = await send(message, smtpServer);
      print('✅ E-mail enviado com sucesso!');
      print('Detalhes: ${sendReport.toString()}');
    } on MailerException catch (e) {
      print('❌ Erro ao enviar e-mail:');
      print(e.message);
      print('\nPossíveis soluções:');
      print(
        '1. Verifique se ativou "Acesso a app menos seguro" na sua conta Google',
      );
      print('2. Ou crie uma "Senha de app" para aplicativos');
      print(
        '3. Verifique se a autenticação de dois fatores está configurada corretamente',
      );
    } catch (e) {
      print('❌ Erro desconhecido: $e');
    }
  } catch (e) {
    print('Falha ao carregar a conta de email: $e');
  }
}

class ContaEmail {
  final String email;
  final String senha;
  final String provedor;
  final String nome_exibicao;

  ContaEmail({
    required this.email,
    required this.senha,
    required this.provedor,
    required this.nome_exibicao,
  });

  factory ContaEmail.fromJson(Map<String, dynamic> json) {
    return ContaEmail(
      email: json['email'],
      senha: json['senha'],
      provedor: json['provedor'],
      nome_exibicao: json['nome_exibicao'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'senha': senha, 'provedor': provedor, 'nome_exibicao': nome_exibicao};
  }
}

Future<ContaEmail> lerContaEmail(String caminhoArquivo) async {
  try {
    // Lê o arquivo como string
    final arquivo = File(caminhoArquivo);
    final conteudo = await arquivo.readAsString();

    // Decodifica o JSON para um Map
    final jsonMap = jsonDecode(conteudo);

    // Converte o Map para um objeto ContaEmail
    return ContaEmail.fromJson(jsonMap);
  } catch (e) {
    print('Erro ao ler o arquivo: $e');
    rethrow;
  }
}
