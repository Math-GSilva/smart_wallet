class Usuario {
  String? id;
  String email;
  String? telefone;
  String nomeUsuario;

  Usuario({
    this.id,
    required this.email,
    this.telefone,
    required this.nomeUsuario,
  });

  factory Usuario.fromMap(Map<String, dynamic> map, String idDoc) {
    return Usuario(
      id: idDoc,
      email: map['email'],
      telefone: map['telefone'],
      nomeUsuario: map['nomeUsuario'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'telefone': telefone,
      'nomeUsuario': nomeUsuario,
    };
  }

  factory Usuario.fromJson(Map<String, dynamic> json) {
    return Usuario(
      id: json['id'],
      email: json['email'],
      telefone: json['telefone'],
      nomeUsuario: json['nomeUsuario'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'telefone': telefone,
      'nomeUsuario': nomeUsuario,
    };
  }
}
