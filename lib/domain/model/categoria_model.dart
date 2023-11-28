class Categoria {
  String id;
  String descricao;

  Categoria({this.id = "", required this.descricao});

  factory Categoria.fromMap(Map<String, dynamic> map, String id) {
    return Categoria(
      id: id,
      descricao: map['descricao'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'descricao': descricao,
    };
  }

  factory Categoria.fromJson(Map<String, dynamic> json) {
    return Categoria(
      id: json['id'],
      descricao: json['descricao'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'descricao': descricao,
    };
  }

  @override
  String toString() => descricao;
}

