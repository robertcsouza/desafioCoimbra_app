import 'package:desafiocoimbra/Model/Contrato.dart';
import 'package:desafiocoimbra/config/DatabaseConfig.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:sqflite/sqflite.dart';

class ContratoDAO {
  DatabaseConfig config;
  Database db;

  ContratoDAO() {
    config = DatabaseConfig();
  }

  insert({Contrato contrato}) async {
    db = await config.database;
    return await db.insert('contrato', contrato.toMap()).catchError((error) {
      EasyLoading.showError('nao foi possivel inserir o status');
      print(error.toString());
      return null;
    });
  }

  drop() async {
    db = await config.database;
    db.execute("DROP TABLE contrato").then((value) {
      EasyLoading.showSuccess('executado com sucesso');
    });
  }

  describe() async {
    db = await config.database;
    return await db.rawQuery("PRAGMA table_info(contrato)");
  }

  getContratosFilter({String column, int id}) async {
    db = await config.database;

    return db.rawQuery(
        "SELECT * FROM contrato JOIN contratado ON contratado.idContratado = contrato.contratado_idContratado JOIN condicoesFinanceiras ON condicoesFinanceiras.idCondicoesFinanceiras = contrato.condicoesFinanceiras_idCondicoesFinanceiras JOIN contratante ON contratante.idContratante = contrato.contratante_idContratante JOIN status ON status.idStatus = contrato.status_idStatus JOIN tipoContrato on tipoContrato.idTipoContrato = contrato.tipoContrato_idTipoContrato WHERE $column = $id");
  }

  getContratos() async {
    db = await config.database;

    return db.rawQuery("SELECT * FROM contrato ");
  }
}
