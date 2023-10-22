import 'package:flutter/material.dart';

import 'card_plano.dart';

class PlanosListView extends StatelessWidget {
  static const List<CardPlanoWidget> lista = [
     CardPlanoWidget(
        categoria: "FESTAS",
        descricao: "Fim de semana",
        cor: Colors.green,
        estimado: 150,
        atual: 15),
    CardPlanoWidget(
        categoria: "JOGOS",
        descricao: "GTA V",
        cor: Colors.purple,
        estimado: 100,
        atual: 35),
    CardPlanoWidget(
        categoria: "COMIDA",
        descricao: "Arroz e feijao",
        cor: Colors.blue,
        estimado: 200,
        atual: 25)
  ];
  const PlanosListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
      child: Column(
        children: [
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Meus Planos",
                  style:
                  TextStyle(color: Colors.white, fontSize: 18)),
              Text("Ver tudo",
                  style:
                  TextStyle(color: Colors.white, fontSize: 18))
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
    );
  }
}
