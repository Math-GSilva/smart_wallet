import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_wallet/Services/categoria_service.dart';
import 'package:smart_wallet/Services/plano_service.dart';
import 'package:smart_wallet/domain/model/movimentacao_model.dart';
import 'package:smart_wallet/presentation/pages/movimentacao_page/controller_movimentacao_page.dart';
import 'package:smart_wallet/presentation/pages/movimentacao_page/widgets/custom_date_picker.dart';
import 'package:smart_wallet/presentation/pages/movimentacao_page/widgets/custom_dropdown.dart';
import 'package:smart_wallet/presentation/pages/movimentacao_page/widgets/custom_text_field.dart';

import '../../../Services/movimentacao_service.dart';
import '../../../domain/model/categoria_model.dart';
import '../../../domain/model/plano_model.dart';
import '../../utils/alerts.dart';

class CadastroPlano extends StatefulWidget {
  const CadastroPlano({super.key});

  @override
  State<CadastroPlano> createState() => _CadastroPlanoState();
}

class _CadastroPlanoState extends State<CadastroPlano> {
  @override
  Widget build(BuildContext context) {
    TextEditingController descController = TextEditingController();
    TextEditingController valorController = TextEditingController();
    TextEditingController dataController = TextEditingController();
    ControllerMovimentacao controller = ControllerMovimentacao();


    return SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xff10172c),
          appBar: AppBar(
            title: Text("MEUS PLANOS", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),),
            centerTitle: true,
            backgroundColor: const Color(0xff10172c),
            leading: IconButton(
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.pop(context);
              },
            ),
          ),
          body: Padding(
            padding: EdgeInsets.symmetric(horizontal: 30, vertical: 50),
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff121e3c),
                borderRadius: BorderRadius.circular(25),
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    StreamBuilder<List<Categoria>>(
                      stream: CategoriaService().getCategorias(),
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return CircularProgressIndicator();
                        } else if (snapshot.hasError) {
                          return Text('Erro: ${snapshot.error}');
                        } else {
                          return CustomDropDown(
                            controller: controller,
                            categorias: snapshot.data ?? [],
                            title: "Categoria",
                          );
                        }
                      },
                    ),
                    CustomTextField(controller: descController, title: "Descrição"),
                    CustomTextField(controller: valorController, title: "Valor", hint: "R\$ 0,00"),
                    CustomDatePicker(controller: dataController, title: "Periodo", inicialEFinal: true),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          backgroundColor: const Color(0xff0249dd),
                          foregroundColor: Colors.white,
                          minimumSize: const Size.fromHeight(45), // NEW
                        ),
                        onPressed: () async {

                          if ((controller.categoriaSelecionada?.id ?? "").isEmpty) {
                            Alerts().showInSnackBar("Informe uma categoria!", Colors.red, context);
                            return;
                          }

                          String descricao = descController.text.trim();
                          if (descricao.isEmpty) {
                            Alerts().showInSnackBar("Informe uma descrição!", Colors.red, context);
                            return;
                          }

                          if (dataController.text.isEmpty) {
                            Alerts().showInSnackBar("Informe uma data válida!", Colors.red, context);
                            return;
                          }

                          double gastoMax = double.tryParse(
                              valorController.text.replaceAll("R\$ ", "").replaceAll(".", "").replaceAll(",", ".")) ?? 0;
                          if (gastoMax == 0) {
                            Alerts().showInSnackBar("Informe um valor válido!", Colors.red, context);
                          }

                          List<Movimentacao> movimentacoes = [];

                          try{
                            movimentacoes = await MovimentacaoService().getMovimentacoesByIntervaloDataECategoria(
                                DateFormat('dd/MM/yyyy').parse(dataController.text.split(" - ")[0]),
                                DateFormat('dd/MM/yyyy').parse(dataController.text.split(" - ")[1]),
                                controller.categoriaSelecionada!.id).first;
                          }catch(e){}

                          await PlanoService().addPlano(
                              Plano(
                                descricao: descController.text,
                                gastoMax: double.tryParse(
                                    valorController.text.replaceAll("R\$ ", "").replaceAll(".", "").replaceAll(",", ".")) ??
                                    0,
                                dataInicio: DateFormat('dd/MM/yyyy').parse(dataController.text.split(" - ")[0]),
                                dataFim: DateFormat('dd/MM/yyyy').parse(dataController.text.split(" - ")[1]),
                                idCategoria: controller.categoriaSelecionada!.id,
                                valorAtual: movimentacoes.isEmpty ? 0.0 :movimentacoes.map((e) => e.valor < 0 ? (e.valor * -1) : e.valor).reduce((a, b) => a+b)
                              ));

                          Navigator.pop(context);
                        },
                        child: const Text(
                          'Salvar Novo Plano',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
    ));
  }
}
