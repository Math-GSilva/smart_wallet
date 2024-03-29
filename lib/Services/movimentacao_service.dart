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
        .map((snapshot) {
      List<Movimentacao> movimentacoes = snapshot.docs
          .map((doc) {
        String idDoDocumento = doc.id;

        return Movimentacao.fromMap(doc.data() as Map<String, dynamic>, idDoDocumento);
      })
          .toList();

      return movimentacoes;
    });
  }

  Stream<List<Movimentacao>> getMovimentacoesByIntervaloDataECategoria(DateTime dataInicio, DateTime dataFim, String categoriaId) {
    return _movimentacoesCollection
        .where('idUsuario', isEqualTo: getUserId())
        .snapshots()
        .map((snapshot) {
      List<Movimentacao> movimentacoes = snapshot.docs
          .map((doc) {
        String idDoDocumento = doc.id;

        return Movimentacao.fromMap(doc.data() as Map<String, dynamic>, idDoDocumento);
      })
          .where((movimentacao) =>
        (movimentacao.data.isAtSameMomentAs(dataInicio) || (movimentacao.data.isAfter(dataInicio) &&
          movimentacao.data.isBefore(dataFim)) || movimentacao.data.isAtSameMomentAs(dataFim))
            && movimentacao.categoriaId == categoriaId &&
          movimentacao.valor < 0)
          .toList();

      return movimentacoes;
    });
  }


  Future<void> updateMovimentacao(Movimentacao movimentacao) async {
    await _movimentacoesCollection
        .doc(movimentacao.id.toString())
        .update(movimentacao.toMap());
  }

  Future<void> deleteMovimentacao(String movimentacaoId) async {
    await _movimentacoesCollection.doc(movimentacaoId).delete();
  }

}
