import 'package:desafiocoimbra/DAO/ContratanteDAO.dart';
import 'package:desafiocoimbra/components/AppBar.dart';
import 'package:desafiocoimbra/components/Buttons.dart';
import 'package:desafiocoimbra/components/EasyLoading.dart';
import 'package:desafiocoimbra/components/NaviBar.dart';
import 'package:desafiocoimbra/config/DatabaseConfig.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';

class Contratante extends StatefulWidget {
  @override
  _ContratanteState createState() => _ContratanteState();
}

class _ContratanteState extends State<Contratante> {
  ContratanteDAO contratanteDAO;
  Future contratantes;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    contratanteDAO = ContratanteDAO();
    contratantes = contratanteDAO.getContratantes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar(title: 'contratante'),
      bottomNavigationBar: navigation(context: context, index: 0),
      body: body(),
      floatingActionButton: btFloatAction(
          call: () {
            Navigator.pushNamed(context, '/contratante/add');
          },
          iconLable: Icon(Icons.add),
          context: context),
    );
  }

  Widget body() {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder(
          future: contratantes,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              easyLoading();
              Future.delayed(Duration(seconds: 2), () {
                EasyLoading.dismiss();
              });
              return SizedBox();
            } else {
              return ListView.builder(
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: ListTile(
                        onTap: () {
                          Navigator.pushNamed(context, '/contratante/update',
                              arguments: snapshot.data[index]);
                        },
                        title: Text(snapshot.data[index]['razaoSocial']),
                        subtitle:
                            Text(snapshot.data[index]['telefone'].toString()),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ));
  }
}
