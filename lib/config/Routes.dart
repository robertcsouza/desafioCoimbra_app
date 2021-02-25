import 'package:desafiocoimbra/views/Contratado/AddContratado.dart';
import 'package:desafiocoimbra/views/Contratado/Contratado.dart';
import 'package:desafiocoimbra/views/Contratado/UpdateContratado.dart';
import 'package:desafiocoimbra/views/Contratante/Contratante.dart';
import 'package:desafiocoimbra/views/Contratante/AddContratante.dart';
import 'package:desafiocoimbra/views/Contratante/UpdateContratante.dart';
import 'package:desafiocoimbra/views/Contrato/AddContrato.dart';

route() {
  return {
    //rotas contratante
    '/contratante': (context) => Contratante(),
    '/contratante/add': (context) => AddContratante(),
    '/contratante/update': (context) => UpdateContratante(),
    //rotas contratado
    '/contratado': (context) => Contratado(),
    '/contratado/add': (context) => AddContratado(),
    '/contratado/update': (context) => UpdateContratado(),

    // rotas contrato
    '/contrato/add': (context) => AddContrato(),
  };
}
