import 'dart:io';
import 'package:sqlite3/sqlite3.dart';

void main() {
  final db = sqlite3.open('alunos.db');

  // Criar tabela TB_ALUNO se não existir
  db.execute('''
    CREATE TABLE IF NOT EXISTS TB_ALUNO (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      nome TEXT NOT NULL CHECK(length(nome) <= 50)
    );
  ''');

  print('Banco aberto e tabela TB_ALUNO pronta.');

  bool running = true;

  while (running) {
    print('\\nEscolha uma opção:');
    print('1 - Inserir novo aluno');
    print('2 - Listar alunos');
    print('0 - Sair');

    stdout.write('Opção: ');
    String? input = stdin.readLineSync();

    switch (input) {
      case '1':
        inserirAluno(db);
        break;
      case '2':
        listarAlunos(db);
        break;
      case '0':
        running = false;
        break;
      default:
        print('Opção inválida. Tente novamente.');
        break;
    }
  }

  db.dispose();
  print('Programa finalizado.');
}

void inserirAluno(Database db) {
  stdout.write('Digite o nome do aluno (máx 50 caracteres): ');
  String? nome = stdin.readLineSync();
  if (nome == null || nome.trim().isEmpty) {
    print('Nome inválido. Operação cancelada.');
    return;
  }
  if (nome.length > 50) {
    print('Nome muito longo. Máximo 50 caracteres permitido.');
    return;
  }

  try {
    final stmt = db.prepare('INSERT INTO TB_ALUNO (nome) VALUES (?)');
    stmt.execute([nome.trim()]);
    stmt.dispose();
    print('Aluno "$nome" inserido com sucesso.');
  } catch (e) {
    print('Erro ao inserir aluno: $e');
  }
}

void listarAlunos(Database db) {
  try {
    final ResultSet result = db.select('SELECT id, nome FROM TB_ALUNO ORDER BY id ASC');
    if (result.isEmpty) {
      print('Nenhum aluno cadastrado.');
      return;
    }
    print('\\nLista de Alunos:');
    for (final row in result) {
      print('id: ${row['id']}, nome: ${row['nome']}');
    }
  } catch (e) {
    print('Erro ao listar alunos: $e');
  }
}
