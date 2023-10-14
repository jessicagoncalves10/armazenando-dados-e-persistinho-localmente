
class Pessoa {
  int _id = 0;
  String _nome = "";
  double _peso = 0.0;
  double _altura = 0.0;

  Pessoa(this._id, this._nome, this._peso, this._altura);

  int get id => _id;

  set id(int id) {
    _id = id;
  }

  String get nome => _nome;

  set nome(String nome) {
    _nome = nome;
  }

  double get peso => _peso;

  set peso(double peso) {
    _peso = peso;
  }

  double get altura => _altura;

  set altura(double altura) {
    _altura = altura;
  }
}
