// Arquivo bin/main.dart
import 'dart:convert';
import 'package:exercicio_poo_smtp/enviar_email.dart';
import '../lib/models.dart';

void main() async {
  // Criar objetos conforme o modelo
  var curso = Curso(
    id: 1,
    descricao: 'Sistemas de Informação',
  );

  var aluno1 = Aluno(
    id: 1,
    nome: 'Edvaldo Sousa',
    matricula: '20230001',
  );

  var aluno2 = Aluno(
    id: 2,
    nome: 'João Silva',
    matricula: '20230002',
  );

  var aluno3 = Aluno(
    id: 3,
    nome: 'Maria Souza',
    matricula: '20230003',
  );

  var professor1 = Professor(
    id: 1,
    codigo: 'PROF001',
    nome: 'Ricardo Taveira',
  );

  var professor2 = Professor(
    id: 2,
    codigo: 'PROF002',
    nome: 'Carlos Mauricio',
  );

  var disciplina1 = Disciplina(
    id: 1,
    descricao: 'Programação de Dispositivos Móveis',
    qtdAulas: 60,
  );

  var disciplina2 = Disciplina(
    id: 2,
    descricao: 'Banco de Dados',
    qtdAulas: 45,
  );

  var disciplina3 = Disciplina(
    id: 3,
    descricao: 'Programação Orientada a Objetos',
    qtdAulas: 60,
  );

  // Adicionar relacionamentos
  curso.adicionaAluno(aluno1);
  curso.adicionaAluno(aluno2);
  curso.adicionaAluno(aluno3);

  curso.adicionaProfessor(professor1);
  curso.adicionaProfessor(professor2);

  curso.adicionaDisciplina(disciplina1);
  curso.adicionaDisciplina(disciplina2);
  curso.adicionaDisciplina(disciplina3);
  
  professor1.adicionaDisciplina(disciplina1);
  professor2.adicionaDisciplina(disciplina2);

  // Converter para JSON
  var jsonData = jsonEncode(curso.toJson());
  print('JSON gerado:\n$jsonData');

  // Enviar por email
  await enviarEmail(jsonData);
}