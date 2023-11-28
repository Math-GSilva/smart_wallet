import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../domain/model/categoria_model.dart';

class CategoriaService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CollectionReference get _categoriasCollection =>
      FirebaseFirestore.instance.collection('Categoria');

  String getUserId() {
    final User? user = _auth.currentUser;
    return user?.uid ?? "";
  }

  Future<void> addCategoria(Categoria categoria) async {
    await _categoriasCollection.add({
      ...categoria.toMap(),
      'idUsuario': getUserId(),
    });
  }

  Stream<List<Categoria>> getCategorias() {
    return _categoriasCollection
        .where('idUsuario', isEqualTo: getUserId())
        .snapshots()
        .map((snapshot) {
      List<Categoria> categorias = snapshot.docs
          .map((doc) {
        String idDoDocumento = doc.id;

        return Categoria.fromMap(doc.data() as Map<String, dynamic>, idDoDocumento);
      })
          .toList();

      return categorias;
    });
  }

  Future<void> updateCategoria(Categoria categoria) async {
    await _categoriasCollection
        .doc(categoria.id.toString())
        .update(categoria.toMap());
  }

  Future<void> deleteCategoria(int categoriaId) async {
    await _categoriasCollection.doc(categoriaId.toString()).delete();
  }
}
