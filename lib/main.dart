import 'package:desafiocoimbra/Model/Status.dart';
import 'package:desafiocoimbra/components/AppBar.dart';
import 'package:desafiocoimbra/components/Buttons.dart';
import 'package:desafiocoimbra/components/NaviBar.dart';
import 'package:desafiocoimbra/config/DatabaseConfig.dart';
import 'package:desafiocoimbra/config/FillTables.dart';
import 'package:desafiocoimbra/config/Routes.dart';
import 'package:desafiocoimbra/config/Tables.dart';
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
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _inicializeDB();
  }

  _inicializeDB() async {
    DatabaseConfig config = DatabaseConfig();
    config.inicializaDB();
    db = await config.database;
    config.createTables(db: db, sql: STATUS, verson: 1);
    config.createTables(db: db, sql: CONDICOES, verson: 1);
    config.createTables(db: db, sql: TIPO, verson: 1);
    config.createTables(db: db, sql: ENDERECO, verson: 1);
    config.createTables(db: db, sql: CONTRATANTE, verson: 1);
    config.createTables(db: db, sql: CONTRATADO, verson: 1);
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
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[],
          ),
        ));
  }
}
