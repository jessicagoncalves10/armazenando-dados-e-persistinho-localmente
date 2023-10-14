import 'package:calculadora_imc/model/imc.dart';
import 'package:calculadora_imc/repositories/pessoa_repository.dart';
import 'package:flutter/material.dart';

import '../model/pessoa.dart';
import '../services/app_storage_service.dart';
import '../shared/widgets/custom_drawer.dart';

class CalculadoraImcPage extends StatefulWidget {
  const CalculadoraImcPage({super.key});

  @override
  State<CalculadoraImcPage> createState() => _CalculadoraImcPageState();
}

class _CalculadoraImcPageState extends State<CalculadoraImcPage> {
  AppStorageService storage = AppStorageService();

  PessoaRepository pessoaRepository = PessoaRepository();
  var _pessoas = const <Pessoa>[];
  TextEditingController nomeController = TextEditingController();
  TextEditingController pesoController = TextEditingController();
  TextEditingController alturaController = TextEditingController();

  void obterPessoas() async {
    _pessoas = await pessoaRepository.listarPessoas();
    setState(() {});
  }

  void carregarStorage() async {
    nomeController.text = await storage.getDadosCadastraisNome();
    pesoController.text = (await storage.getDadosCadastraisPeso()).toString();
    alturaController.text =
        (await storage.getDadosCadastraisAltura()).toString();
    setState(() {});
  }

  @override
  void initState() {
    obterPessoas();
    carregarStorage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Calculadora IMC")),
        drawer: const CustomDrawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            carregarStorage();
            showDialog(
                context: context,
                builder: (BuildContext bc) {
                  return Scaffold(
                    appBar: AppBar(
                      leading: const Icon(Icons.monitor_heart_outlined),
                      title: const Text(
                        'Faça um novo cálculo',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    body: SingleChildScrollView(
                      child: Center(
                        child: Container(
                          height: 650,
                          width: 360,
                          decoration: BoxDecoration(
                              color:const Color.fromARGB(255, 31, 120, 161),
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(width: 2)),
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: nomeController,
                                  textAlign: TextAlign.center,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Nome',
                                      fillColor: Colors.white70,
                                      filled: true),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: pesoController,
                                  textAlign: TextAlign.center,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Peso (kg)',
                                      fillColor: Colors.white70,
                                      filled: true),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: TextFormField(
                                  controller: alturaController,
                                  textAlign: TextAlign.center,
                                  decoration: const InputDecoration(
                                      border: OutlineInputBorder(),
                                      hintText: 'Altura (metros)',
                                      fillColor: Colors.white70,
                                      filled: true),
                                ),
                              ),
                              Container(
                                height: 100,
                                width: 72,
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  setState(() {
                                    nomeController.text = '';
                                    pesoController.text = '';
                                    alturaController.text = '';
                                  });
                                },
                                child: const Text('Limpar'),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  if (nomeController.text == '') {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text("Nome inválido!")));
                                  } else if (pesoController.text == '' ||
                                      double.tryParse(pesoController.text) ==
                                          null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text("Peso inválido!")));
                                  } else if (alturaController.text == '' ||
                                      double.tryParse(alturaController.text) ==
                                          null) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        const SnackBar(
                                            content: Text("Altura inválida!")));
                                  } else {
                                    Pessoa pessoa = Pessoa(
                                        0,
                                        nomeController.text,
                                        double.parse(pesoController.text),
                                        double.parse(alturaController.text));
                                    await pessoaRepository
                                        .adicionarPessoa(pessoa);
                                    Navigator.pop(context);
                                    obterPessoas();
                                    setState(() {});
                                  }
                                },
                                child: const Text('Adicionar'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                });
          },
          child: const Icon(Icons.add),
        ),
        body: Container(
          margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 4),
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                    itemCount: _pessoas.length,
                    itemBuilder: (BuildContext bc, int index) {
                      var pessoa = _pessoas[index];
                      return Padding(
                        padding: const EdgeInsets.all(1.0),
                        child: Dismissible(
                          key: Key(pessoa.id.toString()),
                          onDismissed:
                              (DismissDirection dismissDirection) async {
                            await pessoaRepository.removerPessoa(pessoa.id);
                            obterPessoas();
                          },
                          child: Container(
                            color: const Color.fromARGB(113, 158, 158, 158),
                            child: ListTile(
                              title: Text(pessoa.nome.toUpperCase().length > 25
                                  ? '${pessoa.nome.toUpperCase().substring(0, 25)}...'
                                  : pessoa.nome.toUpperCase()),
                              leading: Column(
                                children: [
                                  CircleAvatar(
                                    backgroundColor: Imc.classificacaoImcPorCor(
                                        pessoa.peso, pessoa.altura),
                                    child: Text(
                                      Imc.calculaImc(pessoa.peso, pessoa.altura)
                                          .round()
                                          .toString(),
                                      style: const TextStyle(
                                          fontSize: 20,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  const Text(
                                    "IMC",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                ],
                              ),
                              trailing: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  const Text(
                                    textAlign: TextAlign.left,
                                    "Classificação",
                                    style: TextStyle(fontSize: 10),
                                  ),
                                  Text(Imc.classificacaoImc(
                                      pessoa.peso, pessoa.altura)),
                                ],
                              ),
                              subtitle: Text(
                                '${pessoa.peso.round().toString()} Kg | ${pessoa.altura} m',
                                style: const TextStyle(fontSize: 12),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            ],
          ),
        ));
  }
}
