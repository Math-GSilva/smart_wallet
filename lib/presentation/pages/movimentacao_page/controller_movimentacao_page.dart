import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_wallet/Services/movimentacao_service.dart';
import 'package:smart_wallet/Services/plano_service.dart';
import 'package:smart_wallet/presentation/pages/home_page/home_page_screen.dart';
import 'package:smart_wallet/presentation/utils/tipo_movimentacao.dart';

import '../../../domain/model/categoria_model.dart';
import '../../../domain/model/movimentacao_model.dart';
import '../../../domain/model/plano_model.dart';
import '../../../persistance/movimentacao_repository_impl.dart';
import '../../utils/alerts.dart';

class ControllerMovimentacao{
  TextEditingController controllerDescricao = TextEditingController(),
      controllerData = TextEditingController(),
      controllerValor = TextEditingController();
  Categoria? categoriaSelecionada;

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();

  bool validaCampos(BuildContext context) {
    bool valid = true;

    if ((categoriaSelecionada?.id ?? 0) == 0) {
      valid = false;
      Alerts().showInSnackBar("Informe uma categoria!", Colors.red, context);
    } else if ((controllerDescricao.text).trim().isEmpty) {
      Alerts().showInSnackBar("Informe uma descrição!", Colors.red, context);
      valid = false;
    } else if ((controllerData.text).trim().isEmpty) {
      Alerts().showInSnackBar("Informe uma data!", Colors.red, context);
      valid = false;
    } else if (double.parse(
        controllerValor.text.replaceAll("R\$ ", "").replaceAll(".", "").replaceAll(",", ".").isEmpty
            ? "0"
            : controllerValor.text.replaceAll("R\$ ", "").replaceAll(".", "").replaceAll(",", ".")) ==
        0) {
      Alerts().showInSnackBar("Informe um valor válido!", Colors.red, context);
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
      await MovimentacaoService().addMovimentacao(
          Movimentacao(
          id: null,
          valor: valor,
          tipo: "1",
          descricao: controllerDescricao.text,
          data: DateFormat('dd/MM/yyyy').parse(controllerData.text),
          categoriaId: categoriaSelecionada!.id));

      if(tipo == TipoMovimentacao.saida){
        List<Plano> planos = [];

        try{
          planos = await PlanoService().getPlanosByCategoriaAndData(DateFormat('dd/MM/yyyy').parse(controllerData.text), categoriaSelecionada!.id).first;
        } catch(e){

        }

        planos.forEach((plano) async {
          plano.valorAtual += valor < 0 ? valor * -1 : valor;
          await PlanoService().updatePlano(plano);
        });
      }
      Alerts().showInSnackBar("Movimentação salva com sucesso!", Colors.green, context);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    }
  }
}