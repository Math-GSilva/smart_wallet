import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SaldoService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CollectionReference get _movimentacoesCollection =>
      FirebaseFirestore.instance.collection('Transacao');

  String getUserId() {
    final User? user = _auth.currentUser;
    return user?.uid ?? "";
  }

  Future<double> getSaldoAtual() async {
    final QuerySnapshot<Object?> movimentacoesSnapshot =
    await _movimentacoesCollection
        .where('idUsuario', isEqualTo: getUserId())
        .get();

    double saldo = 0;

    for (QueryDocumentSnapshot<Object?> document
    in movimentacoesSnapshot.docs as List<QueryDocumentSnapshot<Object?>>) {
      final Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      final double valor = data['valor'] as double;

      saldo += valor;
    }

    return saldo;
  }
}
