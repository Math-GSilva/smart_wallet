import 'package:flutter/material.dart';

import '../../utils/tipo_movimentacao.dart';
import '../common_widgets/custom_bottom_navigation.dart';
import '../home_page/widgets/circle_icon.dart';
import '../home_page/widgets/movimentacao_list_view.dart';
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
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Color(0xFF121e3c),
            primaryColor: Color(0xFF121e3c),
            splashColor: Color(0xff10172c),
          ),
          child: const CustomBottomNavigation(),
        ),
        backgroundColor: Color(0xff10172c),
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
                      Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.more_horiz,
                                        color: Colors.white,
                                      )),
                                  IconButton(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.notifications,
                                        color: Colors.white,
                                      )),
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Column(
                                        children: [
                                          Text(
                                            "R\$ ${100000.toStringAsFixed(2).replaceAll(".", ",")}",
                                            style: TextStyle(color: Colors.white, fontSize: 46),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
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
            Expanded(
                flex: 6,
                child: MovimentacaoListView())
          ],
        ),
      ),
    );;
  }
}
