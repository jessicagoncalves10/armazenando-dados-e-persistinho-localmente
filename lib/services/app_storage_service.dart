import 'package:shared_preferences/shared_preferences.dart';

enum STORAGE_CHAVES { CHAVE_CONF_NOME, CHAVE_CONF_PESO, CHAVE_CONF_ALTURA }

class AppStorageService {
  Future<void> setDadosCadastraisNome(String nome) async {
    await _setString(STORAGE_CHAVES.CHAVE_CONF_NOME.toString(), nome);
  }

  Future<String> getDadosCadastraisNome() async {
    return _getString(STORAGE_CHAVES.CHAVE_CONF_NOME.toString());
  }

  Future<void> setDadosCadastraisPeso(double peso) async {
    await _setDouble(STORAGE_CHAVES.CHAVE_CONF_PESO.toString(), peso);
  }

  Future<double> getDadosCadastraisPeso() async {
    return _getDouble(STORAGE_CHAVES.CHAVE_CONF_PESO.toString());
  }

  Future<void> setDadosCadastraisAltura(double altura) async {
    await _setDouble(STORAGE_CHAVES.CHAVE_CONF_ALTURA.toString(), altura);
  }

  Future<double> getDadosCadastraisAltura() async {
    return _getDouble(STORAGE_CHAVES.CHAVE_CONF_ALTURA.toString());
  }

  _setString(String chave, String value) async {
    var storage = await SharedPreferences.getInstance();
    storage.setString(chave, value);
  }

  Future<String> _getString(String chave) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getString(chave) ?? "";
  }

  _setStringList(String chave, List<String> values) async {
    var storage = await SharedPreferences.getInstance();
    storage.setStringList(chave, values);
  }

  Future<List<String>> _getStringList(String chave) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getStringList(chave) ?? [];
  }

  _setInt(String chave, int value) async {
    var storage = await SharedPreferences.getInstance();
    storage.setInt(chave, value);
  }

  Future<int> _getInt(String chave) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getInt(chave) ?? 0;
  }

  _setDouble(String chave, double value) async {
    var storage = await SharedPreferences.getInstance();
    storage.setDouble(chave, value);
  }

  Future<double> _getDouble(String chave) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getDouble(chave) ?? 0;
  }

  _setBool(String chave, bool value) async {
    var storage = await SharedPreferences.getInstance();
    storage.setBool(chave, value);
  }

  Future<bool> _getBool(String chave) async {
    var storage = await SharedPreferences.getInstance();
    return storage.getBool(chave) ?? false;
  }
}
