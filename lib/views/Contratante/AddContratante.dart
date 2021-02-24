import 'package:desafiocoimbra/components/AppBar.dart';
import 'package:desafiocoimbra/components/Buttons.dart';
import 'package:desafiocoimbra/components/Inputs.dart';
import 'package:flutter/material.dart';

class AddContratante extends StatefulWidget {
  @override
  _AddContratanteState createState() => _AddContratanteState();
}

class _AddContratanteState extends State<AddContratante> {
  TextEditingController razaoSocial = TextEditingController();
  TextEditingController cnpj = TextEditingController();
  TextEditingController cidade = TextEditingController();
  TextEditingController bairro = TextEditingController();
  TextEditingController rua = TextEditingController();
  TextEditingController numero = TextEditingController();
  TextEditingController telefone = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(title: 'Adicionar Contratante'),
      body: body(),
    );
  }

  Widget body() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 32.0),
              child: inputText(
                  controller: razaoSocial,
                  hint: 'Razão Social',
                  obscure: false),
            ),
            inputText(controller: cnpj, hint: 'CNPJ', obscure: false),
            inputText(controller: cidade, hint: 'Cidade', obscure: false),
            inputText(controller: bairro, hint: 'Bairro', obscure: false),
            inputText(controller: rua, hint: 'Rua', obscure: false),
            inputText(controller: numero, hint: 'Número', obscure: false),
            inputText(controller: telefone, hint: 'Número', obscure: false),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: btPrimary(call: () {}, lable: 'Salvar', context: context),
            )
          ],
        ),
      ),
    );
  }
}
