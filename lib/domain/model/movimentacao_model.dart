import 'package:cloud_firestore/cloud_firestore.dart';

class Movimentacao {
  String? id;
  String categoriaId;
  DateTime data;
  String descricao;
  double valor;
  String tipo;

  Movimentacao({
    this.id,
    required this.categoriaId,
    required this.data,
    required this.descricao,
    required this.valor,
    required this.tipo,
  });

  factory Movimentacao.fromMap(Map<String, dynamic> map, String idDoc) {
    return Movimentacao(
      id: idDoc,
      categoriaId: map['categoriaId'],
      data: (map['data'] as Timestamp).toDate(),
      descricao: map['descricao'],
      valor: map['valor'],
      tipo: map['tipo'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'categoriaId': categoriaId,
      'data': data,
      'descricao': descricao,
      'valor': valor,
      'tipo': tipo,
    };
  }

  factory Movimentacao.fromJson(Map<String, dynamic> json) {
    return Movimentacao(
      id: json['id'],
      categoriaId: json['categoriaId'],
      data: json['data'],
      descricao: json['descricao'],
      valor: json['valor'],
      tipo: json['tipo'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'categoriaId': categoriaId,
      'data': data,
      'descricao': descricao,
      'valor': valor,
      'tipo': tipo,
    };
  }
}