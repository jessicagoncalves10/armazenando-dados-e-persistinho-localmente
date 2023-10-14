import 'package:flutter/material.dart';

class Imc {
  static double calculaImc(double peso, double altura) {
    double imc = peso / (altura * altura);
    return double.parse(imc.roundToDouble().toStringAsFixed(2));
  }

  static String classificacaoImc(double peso, double altura) {
    double imc = calculaImc(peso, altura);

    switch (imc) {
      case < 16:
        return "Magreza severa";
      case >= 16 && < 17:
        return "Magreza moderada";
      case >= 17 && < 18.5:
        return "Magreza leve";
      case >= 18.5 && < 25:
        return "Saudável";
      case >= 25 && < 30:
        return "Sobrepeso";
      case >= 30 && < 35:
        return "Obesidade grau I";
      case >= 35 && < 40:
        return "Obesidade grau II (severa)";
      case >= 40:
        return "Obesidade grau III (morbida)";
      default:
        return "Valor IMC inválido";
    }
  }

  static Color classificacaoImcPorCor(double peso, double altura) {
    double imc = calculaImc(peso, altura);

    switch (imc) {
      case < 16:
        return Colors.red;
      case >= 16 && < 17:
        return Colors.yellow;
      case >= 17 && < 18.5:
        return Colors.grey;
      case >= 18.5 && < 25:
        return Colors.green;
      case >= 25 && < 30:
        return Colors.grey;
      case >= 30 && < 35:
        return Colors.yellow;
      case >= 35 && < 40:
        return Colors.orange;
      case >= 40:
        return Colors.red;
      default:
        return Colors.blueGrey;
    }
  }
}
