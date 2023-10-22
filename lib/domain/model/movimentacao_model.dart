class Movimentacao {
  int? id;
  int categoriaId;
  String data;
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

  factory Movimentacao.fromMap(Map<String, dynamic> map) {
    return Movimentacao(
      id: map['id'],
      categoriaId: map['categoriaId'],
      data: map['data'],
      descricao: map['descricao'],
      valor: map['valor'],
      tipo: map['tipo'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
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
      'id': id,
      'categoriaId': categoriaId,
      'data': data,
      'descricao': descricao,
      'valor': valor,
      'tipo': tipo,
    };
  }
}