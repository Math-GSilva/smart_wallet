import 'package:flutter/material.dart';

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
        drawer: Drawer(
          width: (MediaQuery.of(context).size.width / 2),
          child: Container(
            color: const Color(0xff10172c),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Image.asset("assets/logo_clara.png", width: MediaQuery.of(context).size.width / 3),
                      ),
                      TextButton(
                          onPressed: (){},
                          child: const Text(
                            "Minha conta",
                            style: TextStyle(color: Colors.white, fontSize: 18), textAlign: TextAlign.center,)),
                      TextButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CadastroCategoria()));
                          },
                          child: const Text(
                            "Nova categoria",
                            style: TextStyle(color: Colors.white, fontSize: 18), textAlign: TextAlign.center,))
                    ],
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: const Color(0xff121e3c),
                          foregroundColor: Colors.white,
                          minimumSize: const Size.fromHeight(40), // NEW
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const MainScreen()));
                        },
                        child: const Text(
                          'Sair',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300, color: Colors.white),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
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
