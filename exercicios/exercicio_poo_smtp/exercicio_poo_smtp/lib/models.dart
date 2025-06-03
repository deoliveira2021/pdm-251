// Arquivo lib/models.dart

class Curso {
  final int id;
  final String descricao;
  final List<Aluno> alunos;
  final List<Professor> professores;
  final List<Disciplina> disciplinas;

  Curso({
    required this.id,
    required this.descricao,
    List<Aluno>? alunos,
    List<Professor>? professores,
    List<Disciplina>? disciplinas,
  })  : alunos = alunos ?? [],
        professores = professores ?? [],
        disciplinas = disciplinas ?? [];

  void adicionaProfessor(Professor professor) {
    professores.add(professor);
  }

  void adicionaDisciplina(Disciplina disciplina) {
    disciplinas.add(disciplina);
  }

  void adicionaAluno(Aluno aluno) {
    alunos.add(aluno);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'descricao': descricao,
      'alunos': alunos.map((a) => a.toJson()).toList(),
      'professores': professores.map((p) => p.toJson()).toList(),
      'disciplinas': disciplinas.map((d) => d.toJson()).toList(),
    };
  }
}

class Aluno {
  final int id;
  final String nome;
  final String matricula;

  Aluno({
    required this.id,
    required this.nome,
    required this.matricula,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nome': nome,
      'matricula': matricula,
    };
  }
}

class Professor {
  final int id;
  final String codigo;
  final String nome;
  final List<Disciplina> disciplinas;

  Professor({
    required this.id,
    required this.codigo,
    required this.nome,
    List<Disciplina>? disciplinas,
  }) : disciplinas = disciplinas ?? [];

  void adicionaDisciplina(Disciplina disciplina) {
    disciplinas.add(disciplina);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'codigo': codigo,
      'nome': nome,
      'disciplinas': disciplinas.map((d) => d.toJson()).toList(),
    };
  }
}

class Disciplina {
  final int id;
  final String descricao;
  final int qtdAulas;

  Disciplina({
    required this.id,
    required this.descricao,
    required this.qtdAulas,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'descricao': descricao,
      'qtdAulas': qtdAulas,
    };
  }
}