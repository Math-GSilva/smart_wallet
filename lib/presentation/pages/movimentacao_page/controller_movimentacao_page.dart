import 'package:flutter/material.dart';

import '../../../domain/model/categoria_model.dart';
import '../../../domain/model/movimentacao_model.dart';
import '../../../persistance/movimentacao_repository_impl.dart';

class ControllerMovimentacao{
  TextEditingController controllerDescricao = TextEditingController(),
      controllerData = TextEditingController(),
      controllerValor = TextEditingController();
  List<Categoria> listaCategorias = List.generate(10, (index) => Categoria(id: index, descricao: "Categoria ${index}"));
  Categoria? categoriaSelecionada;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  void showInSnackBar(String texto, Color cor, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(texto),
      backgroundColor: cor,
      elevation: 5,
    ));
  }

  bool validaCampos(BuildContext context) {
    bool valid = true;

    if ((categoriaSelecionada?.id ?? 0) == 0) {
      valid = false;
      showInSnackBar("Informe uma categoria!", Colors.red, context);
    } else if ((controllerDescricao.text).trim().isEmpty) {
      showInSnackBar("Informe uma descrição!", Colors.red, context);
      valid = false;
    } else if ((controllerData.text).trim().isEmpty) {
      showInSnackBar("Informe uma data!", Colors.red, context);
      valid = false;
    } else if (double.parse(
        controllerValor.text.replaceAll("R\$ ", "").replaceAll(",", ".")) ==
        0) {
      showInSnackBar("Informe um valor válido!", Colors.red, context);
      valid = false;
    }
    return valid;
  }

  Future<void> salvarMovimenacao(BuildContext context) async {
    if (validaCampos(context)) {
      await MovimentacaoRepository().insert(
          Movimentacao(
              id: null,
              valor: double.tryParse(
                  controllerValor.text.replaceAll("R\$ ", "").replaceAll(",", ".")) ??
                  0,
              tipo: "1",
              descricao: controllerDescricao.text,
              data: controllerData.text,
              categoriaId: 1));
      showInSnackBar("Movimentação salva com sucesso!", Colors.green, context);
      Navigator.pop(context);
    }
  }
}