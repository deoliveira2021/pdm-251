import 'dart:io';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server.dart';

void main() async {
  print('=== Enviador de E-mails via Gmail ===');

  // Solicitar credenciais do Gmail
  stdout.write('Seu e-mail do Gmail (ex: seuemail@gmail.com): ');
  final email = stdin.readLineSync();

  stdout.write('Sua senha do Gmail (ou senha de app): ');
  final password = stdin.readLineSync();

  stdout.write('Nome do remetente (ex: Seu Nome): ');
  final senderName = stdin.readLineSync();

  stdout.write('Destinatário (ex: destinatario@example.com): ');
  final recipient = stdin.readLineSync();

  stdout.write('Assunto do e-mail: ');
  final subject = stdin.readLineSync();

  stdout.write('Mensagem de texto: ');
  final textMessage = stdin.readLineSync();

  stdout.write('Mensagem HTML (opcional): ');
  final htmlMessage = stdin.readLineSync();

  // Configurar servidor SMTP do Gmail
  final smtpServer = gmail(email!, password!);
  
  // Para maior segurança, considere usar OAuth2 em vez de senha
  // final smtpServer = gmailRelaySaslXoauth2(email, accessToken);

  // Criar mensagem
  final message = Message()
    ..from = Address(email, senderName ?? '')
    ..recipients.add(recipient!)
    ..subject = subject!
    ..text = textMessage!;

  if (htmlMessage != null && htmlMessage.isNotEmpty) {
    message.html = htmlMessage;
  }

  // Enviar e-mail
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