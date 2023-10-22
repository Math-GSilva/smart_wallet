class Saldo {
  int id;
  double saldoAtual;
  String ultimaAtualizacao;

  Saldo({
    required this.id,
    required this.saldoAtual,
    required this.ultimaAtualizacao,
  });

  factory Saldo.fromMap(Map<String, dynamic> map) {
    return Saldo(
      id: map['id'],
      saldoAtual: map['saldoAtual'],
      ultimaAtualizacao: map['ultimaAtualizacao'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'saldoAtual': saldoAtual,
      'ultimaAtualizacao': ultimaAtualizacao,
    };
  }

  factory Saldo.fromJson(Map<String, dynamic> json) {
    return Saldo(
      id: json['id'],
      saldoAtual: json['saldoAtual'],
      ultimaAtualizacao: json['ultimaAtualizacao'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'saldoAtual': saldoAtual,
      'ultimaAtualizacao': ultimaAtualizacao,
    };
  }
}