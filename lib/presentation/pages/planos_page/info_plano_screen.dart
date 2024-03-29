import 'package:flutter/material.dart';
import 'package:smart_wallet/domain/model/movimentacao_model.dart';
import 'package:smart_wallet/presentation/pages/common_widgets/default_drawer.dart';
import 'package:smart_wallet/presentation/pages/home_page/widgets/movimentacao_list_view.dart';
import 'package:smart_wallet/presentation/pages/planos_page/cadastro_plano_screen.dart';

import '../../../Services/categoria_service.dart';
import '../../../Services/movimentacao_service.dart';
import '../../../Services/plano_service.dart';
import '../../../domain/model/categoria_model.dart';
import '../../../domain/model/plano_model.dart';
import '../cadastro_categoria_page/cadastro_categoria_screen.dart';
import '../common_widgets/custom_bottom_navigation.dart';
import '../home_page/widgets/card_movimentacao.dart';
import '../home_page/widgets/card_plano.dart';
import '../login_page/main_screen.dart';

class InfoPlano extends StatefulWidget {
  final Plano plano;
  final String descricao;
  const InfoPlano({required this.plano, required this.descricao, super.key});

  @override
  State<InfoPlano> createState() => _InfoPlanoState();
}

class _InfoPlanoState extends State<InfoPlano> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff10172c),
      appBar: AppBar(
        backgroundColor: const Color(0xff10172c),
        title: Text("MEUS PLANOS", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),),
        centerTitle: true,
      ),
      drawer: DefaultDrawer(),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: const Color(0xFF121e3c),
          primaryColor: const Color(0xFF121e3c),
          splashColor: const Color(0xff10172c),
        ),
        child: const CustomBottomNavigation(index: 2),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          StreamBuilder<List<Movimentacao>>(
            stream: MovimentacaoService().getMovimentacoesByIntervaloDataECategoria(widget.plano.dataInicio, widget.plano.dataFim, widget.plano.idCategoria),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasError) {
                return Text("Erro: ${snapshot.error}");
              } else {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Container(
                    height: MediaQuery.of(context).size.height * 0.7,
                    decoration: BoxDecoration(
                      color: Color(0xff121e3c),
                      borderRadius: BorderRadius.circular(25),
                    ),
                    child: Column(
                      children: [
                        CardPlanoWidget(
                          categoria: widget.descricao,
                          plano: widget.plano,
                          width: MediaQuery.of(context).size.width,
                          height: MediaQuery.of(context).size.height * 0.15,
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: ListView(
                              children: [
                                for(Movimentacao m in snapshot.data!)
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 10),
                                    child: CardMovimentacao(
                                      movimentacao: m,
                                      categorias: [Categoria(descricao: widget.descricao, id: m.categoriaId)],
                                      cor: Color(0xff121e3c),
                                    ),
                                  )
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              }
            },
          )
        ],
      ),
    );
  }
}
