import 'package:flutter/material.dart';

import 'package:smart_wallet/presentation/pages/common_widgets/custom_bottom_navigation.dart';
import 'package:smart_wallet/presentation/pages/movimentacao_page/widgets/custom_date_picker.dart';
import 'package:smart_wallet/presentation/pages/movimentacao_page/widgets/custom_dropdown.dart';
import 'package:smart_wallet/presentation/pages/movimentacao_page/widgets/custom_text_field.dart';
import 'package:smart_wallet/presentation/utils/tipo_movimentacao.dart';

import '../../../domain/model/categoria_model.dart';
import 'controller_movimentacao_page.dart';

class MovimentacaoScreen extends StatefulWidget {
  final TipoMovimentacao tipo;
  const MovimentacaoScreen({super.key, required this.tipo});

  @override
  State<MovimentacaoScreen> createState() => _MovimentacaoScreenState();
}


class _MovimentacaoScreenState extends State<MovimentacaoScreen> {
  ControllerMovimentacao controller = ControllerMovimentacao();

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        key: controller.scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            widget.tipo == TipoMovimentacao.entrada ? "ADICIONAR ENTRADA" : "ADICIONAR SAÍDA",
            style: const TextStyle(
                color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),
          ),
          centerTitle: true,
        ),
        backgroundColor: const Color(0xff10172c),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CustomDropDown<Categoria>(
                  title: "Categoria",
                  hint: "...",
                  controller: controller,
              ),
              CustomTextField(
                  title: "Descrição",
                  hint: "...",
                  controller: controller.controllerDescricao),
              CustomDatePicker(
                  title: "Data", hint: "...", controller: controller.controllerData),
              CustomTextField(
                  title: "Valor",
                  hint: "R\$0,00",
                  corTexto: widget.tipo == TipoMovimentacao.entrada ? Colors.green : Colors.red,
                  controller: controller.controllerValor),
              Padding(
                padding:
                const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xff0249dd),
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () async {
                    controller.salvarMovimenacao(context, widget.tipo );
                  },
                  child: const Text(
                    'Salvar',
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

