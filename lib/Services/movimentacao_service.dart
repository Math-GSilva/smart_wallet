import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../domain/model/movimentacao_model.dart';

class MovimentacaoService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CollectionReference get _movimentacoesCollection =>
      FirebaseFirestore.instance.collection('Transacao');

  String getUserId() {
    final User? user = _auth.currentUser;
    return user?.uid ?? "";
  }

  Future<void> addMovimentacao(Movimentacao movimentacao) async {
    await _movimentacoesCollection.add({
      ...movimentacao.toMap(),
      'idUsuario': getUserId(),
    });
  }

  Stream<List<Movimentacao>> getMovimentacoes() {
    return _movimentacoesCollection
        .where('idUsuario', isEqualTo: getUserId())
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) =>
        Movimentacao.fromMap(doc.data() as Map<String, dynamic>))
        .toList());
  }

  Future<void> updateMovimentacao(Movimentacao movimentacao) async {
    await _movimentacoesCollection
        .doc(movimentacao.id.toString())
        .update(movimentacao.toMap());
  }

  Future<void> deleteMovimentacao(int movimentacaoId) async {
    await _movimentacoesCollection.doc(movimentacaoId.toString()).delete();
  }

}
