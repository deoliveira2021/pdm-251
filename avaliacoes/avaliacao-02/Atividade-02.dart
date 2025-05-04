// Agregação e Composição
import 'dart:convert';
// import 'dart:js_interop';

class Dependente {
  late String _nome;

  Dependente(String nome) {
    this._nome = nome;
  }

  // Adicionando getter para acesso ao nome
  String get nome => _nome;

  // Método para converter para Map (útil para JSON)
  Map<String, dynamic> toMap() {
    return {
      'nome': _nome,
    };
  }
}

class Funcionario {
  late String _nome;
  late List<Dependente> _dependentes;

  Funcionario(String nome, List<Dependente> dependentes) {
    this._nome = nome;
    this._dependentes = dependentes;
  }
  

  // Adicionando getters
  String get nome => _nome;
  List<Dependente> get dependentes => _dependentes;

  // Método para converter para Map
  Map<String, dynamic> toMap() {
    return {
      'nome': _nome,
      'dependentes': _dependentes.map((d) => d.toMap()).toList(),
    };
  }
}

class EquipeProjeto {
  late String _nomeProjeto;
  late List<Funcionario> _funcionarios;

  EquipeProjeto(String nomeprojeto, List<Funcionario> funcionarios) {
    _nomeProjeto = nomeprojeto;
    _funcionarios = funcionarios;
  }

  // Método para converter para Map
  Map<String, dynamic> toMap() {
    return {
      'nomeProjeto': _nomeProjeto,
      'funcionarios': _funcionarios.map((f) => f.toMap()).toList(),
    };
  }

  // Método para converter para JSON
  String toJson() {
    return jsonEncode(toMap());
  }
}

void main() {
  // 1. Criar vários objetos Dependentes
  var dep1 = Dependente("Maria Silva");
  var dep2 = Dependente("João Silva");
  var dep3 = Dependente("Ana Souza");
  var dep4 = Dependente("Carlos Souza");
  var dep5 = Dependente("Pedro Oliveira");

  // 2. Criar vários objetos Funcionario
  // 3. Associar os Dependentes criados aos respectivos funcionarios
  var func1 = Funcionario("José Silva", [dep1, dep2]);
  var func2 = Funcionario("Mariana Souza", [dep3, dep4]);
  var func3 = Funcionario("Paulo Oliveira", [dep5]);
  var func4 = Funcionario("Fernanda Costa", []);

  // 4. Criar uma lista de Funcionarios
  var funcionarios = [func1, func2, func3, func4];

  // 5. Criar um objeto Equipe Projeto
  var equipe = EquipeProjeto("Sistema de Gestão", funcionarios);

  // 6. Printar no formato JSON o objeto Equipe Projeto
  print(equipe.toJson());
}