import 'package:flutter/material.dart';
import 'package:smart_wallet/persistance/movimentacao_repository_impl.dart';

import 'card_plano.dart';

class PlanosListView extends StatefulWidget {
  const PlanosListView({super.key});

  @override
  State<PlanosListView> createState() => _PlanosListViewState();
}

class _PlanosListViewState extends State<PlanosListView> {
  List<CardPlanoWidget> lista = [];

  @override
  void initState() {

    MovimentacaoRepository().getAll().then((value) {
      var listaFesta = value.where((element) => element.categoriaId == 3);
      var listaComida = value.where((element) => element.categoriaId == 1);
      var listaJogos = value.where((element) => element.categoriaId == 2);
      if (value.isNotEmpty) {
        lista.add(CardPlanoWidget(
            categoria: "FESTAS",
            descricao: "Fins de semana",
            cor: Colors.green,
            estimado: 150,
            atual: listaFesta.isEmpty ? 0 : listaFesta.map((e) => e.valor).reduce((a, b) => a + b) ?? 0
        ));
        lista.add(
            CardPlanoWidget(
                categoria: "COMIDA",
                descricao: "Lanches no mês",
                cor: Colors.blue,
                estimado: 200,
                atual: listaComida.isEmpty ? 0 : listaComida.map((e) => e.valor).reduce((a, b) => a + b)
            )
        );
        lista.add(
            CardPlanoWidget(
                categoria: "JOGOS",
                descricao: "Máximo para skins",
                cor: Colors.purple,
                estimado: 100,
                atual: listaJogos.isEmpty ? 0 : listaJogos.map((e) => e.valor).reduce((a, b) => a + b))
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Meus Planos",
                    style: TextStyle(color: Colors.white, fontSize: 18)),
                Text("Ver tudo",
                    style: TextStyle(color: Colors.white, fontSize: 18))
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: Container(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: lista.length,
                      itemBuilder: (context, index) {
                        return lista[index];
                      },
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
