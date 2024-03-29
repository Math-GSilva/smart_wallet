import 'package:flutter/material.dart';
import 'package:smart_wallet/presentation/pages/common_widgets/default_drawer.dart';

import '../../../Services/movimentacao_service.dart';
import '../../../domain/model/movimentacao_model.dart';
import '../../../persistance/movimentacao_repository_impl.dart';
import '../../utils/tipo_movimentacao.dart';
import '../cadastro_categoria_page/cadastro_categoria_screen.dart';
import '../common_widgets/custom_bottom_navigation.dart';
import '../home_page/widgets/circle_icon.dart';
import '../home_page/widgets/movimentacao_list_view.dart';
import '../login_page/main_screen.dart';
import '../movimentacao_page/movimentacao_screen.dart';

class TransacoesScreen extends StatefulWidget {
  const TransacoesScreen({super.key});

  @override
  State<TransacoesScreen> createState() => _TransacoesScreenState();
}



class _TransacoesScreenState extends State<TransacoesScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: DefaultDrawer(),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: const Color(0xFF121e3c),
            primaryColor: const Color(0xFF121e3c),
            splashColor: const Color(0xff10172c),
          ),
          child: const CustomBottomNavigation(index: 0),
        ),
        backgroundColor: const Color(0xff10172c),
        body: Column(
          children: [
            Expanded(
                flex: 3,
                child: Container(
                  decoration: const BoxDecoration(
                    color: Color(0xFF121e3c),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(75.0),
                      bottomRight: Radius.circular(75.0),
                    ),
                  ),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Builder(
                            builder: (context) => IconButton(
                              onPressed: () {
                                Scaffold.of(context).openDrawer();
                              },
                              icon: const Icon(
                                Icons.settings,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          StreamBuilder<List<Movimentacao>>(
                                            stream: MovimentacaoService().getMovimentacoes(),
                                            builder: (context, snapshotMovimentacoes) {
                                              if (snapshotMovimentacoes.hasError) {
                                                return Text('Erro: ${snapshotMovimentacoes.error}');
                                              }

                                              if (!snapshotMovimentacoes.hasData) {
                                                return CircularProgressIndicator();
                                              }

                                              final List<Movimentacao> listaMovimentacoes = snapshotMovimentacoes.data!;
                                              double valorTotal = listaMovimentacoes
                                                  .map((movimentacao) => movimentacao.valor)
                                                  .fold(0, (previousValue, element) => previousValue + element);

                                              return Text(
                                                "R\$ ${valorTotal.toStringAsFixed(2).replaceAll(".", ",")}",
                                                style: TextStyle(color: Colors.white, fontSize: 46),
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                              );
                                            },
                                          ),
                                          Text(
                                            "Balanço",
                                            style: TextStyle(color: Colors.grey, fontSize: 18),
                                          ),
                                        ],
                                      )
                                    ],
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Padding(
                                        padding: const EdgeInsets.only(bottom: 8.0),
                                        child: CircleIcon(
                                            color: Colors.green,
                                            icon: Icons.arrow_upward_outlined,
                                            size: 50,
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                // ignore: prefer_const_constructors
                                                MaterialPageRoute(builder: (context) => MovimentacaoScreen(tipo: TipoMovimentacao.entrada,)),
                                              );
                                            }),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.only(top: 8.0),
                                        child: CircleIcon(
                                            color: Colors.red,
                                            icon: Icons.arrow_downward_outlined,
                                            size: 50,
                                            onPressed: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(builder: (context) => const MovimentacaoScreen(tipo: TipoMovimentacao.saida,)),
                                              );
                                            }),
                                      )
                                    ],
                                  )
                                ],
                              )
                            ],
                          )),
                    ],
                  ),
                )
            ),
            const Expanded(
                flex: 6,
                child: MovimentacaoListView())
          ],
        ),
      ),
    );
  }
}
