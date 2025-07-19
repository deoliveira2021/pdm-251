import 'package:flutter/material.dart';

class DetailsScreen extends StatelessWidget {
  final String? title;
  final String? description;
  final int? value;

  // Construtor para receber argumentos diretamente
  const DetailsScreen({
    super.key,
    this.title,
    this.description,
    this.value,
  });

  // Método para extrair argumentos quando usando rotas nomeadas
  static Route<dynamic> route(RouteSettings settings) {
    // Verifica se há argumentos e faz o cast para Map
    final args = settings.arguments as Map<String, dynamic>?;

    return MaterialPageRoute(
      builder: (context) {
        return DetailsScreen(
          title: args?['title'],
          description: args?['description'],
          value: args?['value'],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    // Pode-se também extrair argumentos diretamente aqui se necessário
    // final args = ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    return Scaffold(
      appBar: AppBar(
        title: Text(title ?? 'Tela de Detalhes'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title ?? 'Título padrão',
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: 16),
            Text(
              description ?? 'Descrição padrão',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const SizedBox(height: 16),
            Text(
              'Valor: ${value ?? 'N/A'}',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('Voltar'),
            ),
          ],
        ),
      ),
    );
  }
}