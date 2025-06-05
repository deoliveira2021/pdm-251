
import 'dart:convert';
import 'dart:io';

import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

Future<void> enviarEmail(String jsonString) async {

  const caminho = '.dart_tool/dados_email.json';

  try {
    final conta = await lerContaEmail(caminho);
    final smtpServer = gmail(conta.email!, conta.senha!);
    final message =
        Message()
          ..from = Address(conta.email!)
          ..recipients.add(conta.destinatario)
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
  final String destinatario;

  ContaEmail({
    required this.email,
    required this.senha,
    required this.destinatario,
  });

  factory ContaEmail.fromJson(Map<String, dynamic> json) {
    return ContaEmail(
      email: json['email'],
      senha: json['senha'],
      destinatario: json['destinatario'],
    );
  }

  Map<String, dynamic> toJson() {
    return {'email': email, 'senha': senha, 'destinatario': destinatario};
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