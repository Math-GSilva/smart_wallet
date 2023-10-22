import 'package:flutter/material.dart';

import 'card_movimentacao.dart';

class MovimentacaoListView extends StatelessWidget {
  const MovimentacaoListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Transações Recentes",
                  style:
                  TextStyle(color: Colors.white, fontSize: 18)),
              Text("Ver tudo",
                  style:
                  TextStyle(color: Colors.white, fontSize: 18))
            ],
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: 20,
              itemBuilder: (context, index) {
                return CardMovimentacao();
              },
            ),
          )
        ],
      ),
    );
  }
}
