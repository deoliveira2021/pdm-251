import 'package:flutter/material.dart';
import 'details_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tela Principal'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                // Passando argumentos usando Navigator.push
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const DetailsScreen(
                      title: 'Argumento Passado',
                      description: 'Esta descrição veio da tela principal',
                      value: 42,
                    ),
                  ),
                );
              },
              child: const Text('Abrir Tela com Argumentos (push)'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Passando argumentos usando rotas nomeadas
                Navigator.pushNamed(
                  context,
                  '/details',
                  arguments: {
                    'title': 'Argumento via Rota Nomeada',
                    'description': 'Esta mensagem foi passada como argumento',
                    'value': 100,
                  },
                );
              },
              child: const Text('Abrir Tela com Argumentos (rota nomeada)'),
            ),
          ],
        ),
      ),
    );
  }
}