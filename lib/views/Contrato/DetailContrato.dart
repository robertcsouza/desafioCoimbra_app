import 'package:desafiocoimbra/Model/CondicoesFinanceiras.dart';
import 'package:desafiocoimbra/Model/Contratado.dart';
import 'package:desafiocoimbra/Model/Status.dart';
import 'package:desafiocoimbra/Model/TipoContrato.dart';
import 'package:desafiocoimbra/components/AppBar.dart';
import 'package:desafiocoimbra/components/Buttons.dart';
import 'package:desafiocoimbra/helper/ConvertDate.dart';
import 'package:flutter/material.dart';

class DetailContrato extends StatefulWidget {
  @override
  _DetailContratoState createState() => _DetailContratoState();
}

class _DetailContratoState extends State<DetailContrato> {
  Contratado contratado;
  CondicoesFinanceiras condicoesFinanceiras;
  Status status;
  TipoContrato tipoContrato;
  @override
  Widget build(BuildContext context) {
    var args = ModalRoute.of(context).settings.arguments;
    Map<String, dynamic> map = args;
    contratado = Contratado(
        idContratado: map['idContratado'],
        razaoSocial: map['razaoSocial'],
        cnpj: map['cnpj'],
        enderecoFK: map['endereco_idendereco'],
        telefone: map['telefone']);

    condicoesFinanceiras = CondicoesFinanceiras(
        id: map['idCondicoesFinanceiras'],
        carencia: map['carencia'],
        valor: map['valor'],
        vigencia: map['vigencia'],
        prazoFinal: map['prazo_final'],
        prazoInicial: map['prazo_inicial']);

    status = Status(id: map['idStatus'], status: map['status']);

    tipoContrato =
        TipoContrato(idTipoContrato: map['idTipoContrato'], tipo: map['tipo']);

    return Scaffold(
      appBar: appbar(title: 'Detalhes Do Contrato'),
      body: _body(),
    );
  }

  _body() {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Contratado',
                style: TextStyle(
                    fontWeight: FontWeight.bold, color: Colors.black54),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Razão Social: ${contratado.razaoSocial}'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('CNPJ: ${contratado.cnpj}'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Telefone: ${contratado.telefone}'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Condiçôes Financeiras',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black54),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    Text('Carência:  ${condicoesFinanceiras.carencia} Mêses'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child:
                    Text('Vigência:  ${condicoesFinanceiras.carencia} Mêses'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Valor: R\$ ${condicoesFinanceiras.valor}'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    'Data Inicial:  ${dateConvert(DateTime.fromMillisecondsSinceEpoch(condicoesFinanceiras.prazoInicial), '-')}'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                    'Data Final:  ${dateConvert(DateTime.fromMillisecondsSinceEpoch(condicoesFinanceiras.prazoFinal), '-')}'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Status do Contrato',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black54),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Status:  ${status.status}'),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Tipo do Contrato',
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.black54),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text('Tipo:  ${tipoContrato.tipo}'),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    btUpdate(
                        call: () {
                          Navigator.pushReplacementNamed(
                              context, '/contrato/update',
                              arguments: {
                                'contratado': contratado,
                                'condicoes': condicoesFinanceiras,
                                'status': status,
                                'tipo': tipoContrato
                              });
                        },
                        lable: 'Editar',
                        context: context),
                    btDelete(call: () {}, lable: 'Deletar', context: context),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
