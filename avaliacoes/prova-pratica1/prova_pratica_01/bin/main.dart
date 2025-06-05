// Arquivo: bin/main.dart
import 'dart:convert';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

import 'package:prova_pratica_01/models/cliente.dart';
import 'package:prova_pratica_01/models/item_pedido.dart';
import 'package:prova_pratica_01/models/pedido_venda.dart';
import 'package:prova_pratica_01/models/vendedor.dart';


void main() {
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
      descricao: "Veículo principal",
      quantidade: 1,
      valor: 85000.00,
    ),
    ItemPedido(
      sequencial: 2,
      descricao: "Seguro total",
      quantidade: 1,
      valor: 3500.00,
    ),
  ];

  final pedidoVenda = PedidoVenda(
    codigo: "PV-2023-001",
    data: DateTime.now(),
    valorPedido: 0, //será calculado abaixo
    cliente: cliente,
    vendedor: vendedor,
    veiculo: veiculo,
    itens: itensPedido,
  );

  // Calculando o valor do pedido
  pedidoVenda.valorPedido = pedidoVenda.calcularPedido();

  // Convertendo para JSON
  final jsonData = pedidoVenda.toJson();
  final jsonString = JsonEncoder.withIndent('  ').convert(jsonData);
  print("\nJSON gerado:\n$jsonString");

  // Enviando por email
  enviarPorEmail(jsonString);
}

void enviarPorEmail(String jsonString) async {
// Configurar servidor SMTP do Gmail
  final email = 'seuemail@seuprovedor.com.br';
  final password = 'suasenha';
  final smtpServer = gmail(email, password);
  
  // Criar mensagem
  final message = Message()
    ..from = Address(email, 'Nome para ser exibido no e-mail')
    ..recipients.add('destinatário@provedor.com.br')
    ..subject = 'Prova prática 01'
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