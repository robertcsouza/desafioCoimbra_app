import 'package:desafiocoimbra/components/AppBar.dart';
import 'package:desafiocoimbra/components/Buttons.dart';
import 'package:desafiocoimbra/components/NaviBar.dart';
import 'package:flutter/material.dart';

class Contratado extends StatefulWidget {
  @override
  _ContratadoState createState() => _ContratadoState();
}

class _ContratadoState extends State<Contratado> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(title: 'Contratado'),
      bottomNavigationBar: navigation(context: context, index: 2),
      floatingActionButton: btFloatAction(
          call: () {
            Navigator.pushNamed(context, '/contratado/add');
          },
          iconLable: Icon(Icons.add),
          context: context),
    );
  }
}
