import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../domain/model/user_model.dart';

class UsuarioService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  CollectionReference get _usuariosCollection =>
      FirebaseFirestore.instance.collection('Usuario');

  String getUserId() {
    final User? user = _auth.currentUser;
    return user?.uid ?? "";
  }

  Future<void> addUsuario(Usuario usuario) async {
    await _usuariosCollection.add({
      ...usuario.toMap(),
      'idUsuario': getUserId(),
    });
  }

  Future<void> changeEmail(String email, String senha, Usuario usuario) async {

    AuthCredential credential = EmailAuthProvider.credential(
      email: usuario.email,
      password: senha,
    );

    await _auth.currentUser!.reauthenticateWithCredential(credential);

    await _auth.currentUser!.updateEmail(email);

    usuario.email = email;
    await _usuariosCollection
        .doc(usuario.id.toString())
        .update(usuario.toMap());
  }

  Future<void> changePass(String senhaAntiga, String senhaNova, Usuario usuario) async {

    AuthCredential credential = EmailAuthProvider.credential(
      email: usuario.email,
      password: senhaAntiga,
    );

    await _auth.currentUser!.reauthenticateWithCredential(credential);

    await _auth.currentUser!.updatePassword(senhaNova);
  }

  Future<void> updateUsuario(Usuario usuario) async {
    await _usuariosCollection
        .doc(usuario.id.toString())
        .update(usuario.toMap());
  }

  Future<void> deleteUsuario(String usuarioId) async {
    await _usuariosCollection.doc(usuarioId).delete();
  }

  Stream<List<Usuario>> getUserInfo() {
    return _usuariosCollection
        .where('idUsuario', isEqualTo: getUserId())
        .snapshots()
        .map((snapshot) {
      List<Usuario> usuarios = snapshot.docs
          .map((doc) {
        String idDoDocumento = doc.id;

        return Usuario.fromMap(doc.data() as Map<String, dynamic>, idDoDocumento);
      })
          .toList();

      return usuarios;
    });
  }
}
