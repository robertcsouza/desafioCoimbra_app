import 'package:desafiocoimbra/components/AppBar.dart';
import 'package:desafiocoimbra/components/Buttons.dart';
import 'package:desafiocoimbra/components/NaviBar.dart';
import 'package:flutter/material.dart';

class Contratante extends StatefulWidget {
  @override
  _ContratanteState createState() => _ContratanteState();
}

class _ContratanteState extends State<Contratante> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(title: 'contratante'),
      bottomNavigationBar: navigation(context: context, index: 0),
      floatingActionButton: btFloatAction(
          call: () {
            Navigator.pushNamed(context, '/contratante/add');
          },
          iconLable: Icon(Icons.add),
          context: context),
    );
  }
}
