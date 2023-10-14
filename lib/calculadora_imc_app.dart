import 'package:calculadora_imc/pages/calculadora_imc_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CalculadoraImcApp extends StatelessWidget {
  const CalculadoraImcApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch:Colors.lightGreen,textTheme: GoogleFonts.robotoTextTheme(),
      ),
      home: const CalculadoraImcPage(),
    );
  }
}
