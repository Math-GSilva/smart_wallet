import 'package:flutter/material.dart';
import 'package:smart_wallet/presentation/pages/home_page/home_page_screen.dart';
import 'package:smart_wallet/presentation/utils/tipo_movimentacao.dart';

import '../../../domain/model/categoria_model.dart';
import '../../../domain/model/movimentacao_model.dart';
import '../../../persistance/movimentacao_repository_impl.dart';
import '../../utils/lista_categorias.dart';

class ControllerMovimentacao{
  TextEditingController controllerDescricao = TextEditingController(),
      controllerData = TextEditingController(),
      controllerValor = TextEditingController();
  Categoria categoriaSelecionada = categoriasTeste.first;

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
        controllerValor.text.replaceAll("R\$ ", "").replaceAll(".", "").replaceAll(",", ".").isEmpty
            ? "0"
            : controllerValor.text.replaceAll("R\$ ", "").replaceAll(".", "").replaceAll(",", ".")) ==
        0) {
      showInSnackBar("Informe um valor válido!", Colors.red, context);
      valid = false;
    }
    return valid;
  }

  Future<void> salvarMovimenacao(BuildContext context, TipoMovimentacao tipo) async {
    if (validaCampos(context)) {
      double valor = double.tryParse(
          controllerValor.text.replaceAll("R\$ ", "").replaceAll(".", "").replaceAll(",", ".")) ??
          0;
      if(tipo == TipoMovimentacao.saida){
        valor = -valor;
      }
      await MovimentacaoRepository().insert(
          Movimentacao(
              id: null,
              valor: valor,
              tipo: "1",
              descricao: controllerDescricao.text,
              data: controllerData.text,
              categoriaId: categoriaSelecionada.id));
      showInSnackBar("Movimentação salva com sucesso!", Colors.green, context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }
}