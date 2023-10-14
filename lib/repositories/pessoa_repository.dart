import 'package:calculadora_imc/repositories/sqlite/sqlitedatabase.dart';

import '../model/pessoa.dart';

class PessoaRepository {
  Future<List<Pessoa>> listarPessoas() async {
    List<Pessoa> pessoas = [];
    var db = await SQLiteDataBase().obterDataBase();

    var result =
        await db.rawQuery('SELECT id, nome, peso, altura FROM pessoas');

    for (var element in result) {
      print(element['peso']);
      print(element['altura']);
      pessoas.add(Pessoa(
          int.parse(element["id"].toString()),
          element["nome"].toString(),
          double.parse(element["peso"].toString()),
          double.parse(element["altura"].toString())));
    }
    return pessoas;
  }

  Future<void> adicionarPessoa(Pessoa pessoa) async {
    var db = await SQLiteDataBase().obterDataBase();

    db.rawInsert('INSERT INTO pessoas (nome, peso, altura) values (?, ?, ?)',
        [pessoa.nome, pessoa.peso, pessoa.altura]);
  }

  Future<void> atualizar(Pessoa pessoa) async {
    var db = await SQLiteDataBase().obterDataBase();

    await db.rawInsert(
        'UPDATE pessoas SET nome = ?, altura = ?, peso = ? WHERE id = ?',
        [pessoa.nome, pessoa.altura, pessoa.peso, pessoa.id]);
  }

  Future<void> removerPessoa(int id) async {
    var db = await SQLiteDataBase().obterDataBase();

    db.rawDelete('DELETE FROM pessoas WHERE id = ?', [id]);
  }
}
