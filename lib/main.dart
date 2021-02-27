import 'package:desafiocoimbra/DAO/ContratadoDAO.dart';
import 'package:desafiocoimbra/DAO/ContratoDAO.dart';
import 'package:desafiocoimbra/DAO/StatusDAO.dart';
import 'package:desafiocoimbra/Model/Contratado.dart';
import 'package:desafiocoimbra/Model/Contrato.dart';
import 'package:desafiocoimbra/Model/Status.dart';
import 'package:desafiocoimbra/components/AppBar.dart';
import 'package:desafiocoimbra/components/Buttons.dart';
import 'package:desafiocoimbra/components/EasyLoading.dart';
import 'package:desafiocoimbra/components/NaviBar.dart';
import 'package:desafiocoimbra/config/DatabaseConfig.dart';
import 'package:desafiocoimbra/config/Routes.dart';
import 'package:desafiocoimbra/config/Tables.dart';
import 'package:desafiocoimbra/helper/ConvertDate.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sqflite/sqflite.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: EasyLoading.init(),
      initialRoute: '/',
      routes: route(),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Contrato'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Database db;
  ContratoDAO contratoDAO = ContratoDAO();
  ContratadoDAO contratadoDAO = ContratadoDAO();
  StatusDAO statusDAO = StatusDAO();
  Widget _content = SizedBox();
  List<Contratado> contratados = List();
  List<Status> status = List();
  List<Contrato> contratos = List();
  Future futureContratos;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _inicializeDB();
    _getContratados();
    _getStatus();
    futureContratos = contratoDAO.getContratos();
  }

  _getContratados() async {
    var cont = await contratadoDAO.getContratados();
    contratados.clear();
    for (var item in cont) {
      Contratado contratado = Contratado(
          idContratado: item['idContratado'],
          cnpj: int.parse(item['cnpj']),
          razaoSocial: item['razaoSocial'],
          telefone: item['telefone'],
          enderecoFK: item['endereco_idendereco']);
      contratados.add(contratado);
    }
  }

  _getStatus() async {
    var stat = await statusDAO.getStatus();
    status.clear();
    for (var item in stat) {
      Status s = Status(id: item['idStatus'], status: item['status']);

      status.add(s);
    }
  }

  _inicializeDB() async {
    DatabaseConfig config = DatabaseConfig();
    config.inicializaDB();
    db = await config.database;
    //config.createTables(db: db, sql: STATUS, verson: 1);
    //config.createTables(db: db, sql: CONDICOES, verson: 1);
    //config.createTables(db: db, sql: TIPO, verson: 1);
    //config.createTables(db: db, sql: ENDERECO, verson: 1);
    //config.createTables(db: db, sql: CONTRATANTE, verson: 1);
    // config.createTables(db: db, sql: CONTRATADO, verson: 1);

    config.createTables(db: db, sql: CONTRATO, verson: 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: appbar(title: 'Contrato'),
        bottomNavigationBar: navigation(context: context, index: 1),
        floatingActionButton: btFloatAction(
            call: () {
              Navigator.pushNamed(context, '/contrato/add');
            },
            iconLable: Icon(Icons.add),
            context: context),
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: filter(),
              ),
              listContrato()
            ],
          ),
        ));
  }

  Widget listContrato() {
    return FutureBuilder(
      future: futureContratos,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          easyLoading();
          return SizedBox();
        } else {
          contratos.clear();
          for (var item in snapshot.data) {
            Contrato contrato = Contrato(
                idContrato: item['idContrato'],
                condicoesFK:
                    item['condicoesFinanceiras_idCondicoesFinanceiras'],
                contratadoFK: item['contratado_idContratado'],
                contratanteFK: item['contratante_idContratante'],
                dataCriacao: item['data_criacao'],
                tipoContratoFK: item['tipoContrato_idTipoContrato'],
                statusFK: item['status_idStatus']);

            contratos.add(contrato);
          }

          EasyLoading.dismiss();

          return Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.65,
              child: ListView.builder(
                itemCount: contratos.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      onTap: () {
                        print(snapshot.data[index]);
                        Navigator.pushNamed(context, '/contrato/detail',
                            arguments: snapshot.data[index]);
                      },
                      title: Text(
                          'Contrato numero : ${contratos[index].idContrato}'),
                      subtitle: Text(
                          'criado: ${dateConvert(DateTime.fromMillisecondsSinceEpoch(contratos[index].dataCriacao), '-')}'),
                    ),
                  );
                },
              ));
        }
      },
    );
  }

  Widget filter() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _content,
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Container(
              width: MediaQuery.of(context).size.width * 0.40,
              height: 50,
              child: DropdownSearch<String>(
                items: ['contratado', 'vigência', 'inserção', 'status'],
                label: "Filtrar por",
                onChanged: (data) {
                  contentFilter(filter: data);
                },
              ),
            ),
          )
        ],
      ),
    );
  }

  contentFilter({String filter}) {
    switch (filter) {
      case 'contratado':
        setState(() {
          _content = Container(
            width: MediaQuery.of(context).size.width * 0.40,
            height: 50,
            child: DropdownSearch<Contratado>(
              items: contratados,
              itemAsString: (Contratado u) => u.asString(),
              label: "Contratado",
              onChanged: (data) async {
                setState(() {
                  futureContratos = contratoDAO.getContratosFilter(
                      column: 'idContratado', id: data.idContratado);
                });
              },
            ),
          );
        });
        break;
      case 'status':
        setState(() {
          _content = Container(
            width: MediaQuery.of(context).size.width * 0.40,
            height: 50,
            child: DropdownSearch<Status>(
              items: status,
              label: "Status",
              itemAsString: (Status item) => item.asString(),
              onChanged: (data) async {
                setState(() {
                  futureContratos = contratoDAO.getContratosFilter(
                      column: 'idStatus', id: data.id);
                });
              },
            ),
          );
        });
        break;
      default:
    }
  }
}
