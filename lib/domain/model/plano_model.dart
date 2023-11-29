import 'package:cloud_firestore/cloud_firestore.dart';

class Plano {
  String? id;
  DateTime dataInicio;
  DateTime dataFim;
  String descricao;
  double gastoMax;
  double valorAtual;
  String idCategoria;

  Plano({
    this.id,
    required this.dataInicio,
    required this.dataFim,
    required this.descricao,
    required this.gastoMax,
    required this.valorAtual,
    required this.idCategoria,
  });

  factory Plano.fromMap(Map<String, dynamic> map, String docID) {
    return Plano(
      id: docID,
      dataInicio: (map['dataInicio'] as Timestamp).toDate(),
      dataFim: (map['dataFim'] as Timestamp).toDate(),
      descricao: map['descricao'],
      gastoMax: map['gastoMax'],
      valorAtual: map['valorAtual'],
      idCategoria: map['idCategoria'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dataInicio': dataInicio,
      'dataFim': dataFim,
      'descricao': descricao,
      'gastoMax': gastoMax,
      'valorAtual': valorAtual,
      'idCategoria': idCategoria,
    };
  }

  factory Plano.fromJson(Map<String, dynamic> json) {
    return Plano(
      id: json['id'],
      dataInicio: json['dataInicio'],
      dataFim: json['dataFim'],
      descricao: json['descricao'],
      gastoMax: json['gastoMax'],
      valorAtual: json['valorAtual'],
      idCategoria: json['idCategoria'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'dataInicio': dataInicio,
      'dataFim': dataFim,
      'descricao': descricao,
      'gastoMax': gastoMax,
      'valorAtual': valorAtual,
      'idCategoria': idCategoria,
    };
  }
}
