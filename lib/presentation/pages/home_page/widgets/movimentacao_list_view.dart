import 'package:flutter/material.dart';
import 'package:smart_wallet/persistance/movimentacao_repository_impl.dart';

import '../../../../domain/model/movimentacao_model.dart';
import 'card_movimentacao.dart';

class MovimentacaoListView extends StatefulWidget {
  final bool showLabels;
  const MovimentacaoListView({this.showLabels = false, super.key});

  @override
  State<MovimentacaoListView> createState() => _MovimentacaoListViewState();
}

class _MovimentacaoListViewState extends State<MovimentacaoListView> {
  List<Movimentacao> lista = [];

  @override
  void initState() {
    MovimentacaoRepository().getAll().then((value){
      if(value.isNotEmpty){
        for(int i = 1; i< 150; i++){
          lista.addAll(value);
        }
        setState(() {
          lista = lista ?? [];
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16, right: 16),
      child: Column(
        children: [
          if(widget.showLabels)
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
              itemCount: lista.length,
              itemBuilder: (context, index) {
                return CardMovimentacao(movimentacao: lista[index]);
              },
            ),
          )
        ],
      ),
    );
  }
}
