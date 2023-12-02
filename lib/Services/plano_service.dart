import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../domain/model/plano_model.dart';

class PlanoService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CollectionReference get _planosCollection =>
      FirebaseFirestore.instance.collection('Plano');

  String getUserId() {
    final User? user = _auth.currentUser;
    return user?.uid ?? "";
  }

  Future<void> addPlano(Plano plano) async {
    await _planosCollection.add({
      ...plano.toMap(),
      'idUsuario': getUserId(),
    });
  }

  Stream<List<Plano>> getPlanos() {
    return _planosCollection
        .where('idUsuario', isEqualTo: getUserId())
        .snapshots()
        .map((snapshot) {
      List<Plano> planos = snapshot.docs
          .map((doc) {
        String idDoDocumento = doc.id;

        return Plano.fromMap(doc.data() as Map<String, dynamic>, idDoDocumento);
      })
          .toList();

      return planos;
    });
  }



  Stream<List<Plano>> getPlanosByCategoriaAndData(DateTime data, String categoriaId) {
    return _planosCollection
        .where('idUsuario', isEqualTo: getUserId())
        .where('idCategoria', isEqualTo: categoriaId)
        .where('dataInicio', isLessThanOrEqualTo: data)
        .snapshots()
        .map((snapshot) {
      List<Plano> planos = snapshot.docs
          .map((doc) {
        String idDoDocumento = doc.id;

        return Plano.fromMap(doc.data() as Map<String, dynamic>, idDoDocumento);
      })
          .toList();

      planos = planos.where((plano) => plano.dataFim.isAfter(data)).toList();

      return planos;
    });
  }




  Future<void> updatePlano(Plano plano) async {
    await _planosCollection
        .doc(plano.id.toString())
        .update(plano.toMap());
  }

  Future<void> deletePlano(String planoId) async {
    await _planosCollection.doc(planoId).delete();
  }
}
