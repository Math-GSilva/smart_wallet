import 'package:flutter/material.dart';
import 'package:smart_wallet/persistance/movimentacao_repository_impl.dart';
import 'package:smart_wallet/presentation/pages/transacoes_page/transacoes_screen.dart';

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
        setState(() {
          lista = value;
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Column(
        children: [
          if(widget.showLabels)
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Transações Recentes",
                  style:
                  TextStyle(color: Colors.white, fontSize: 18)),
              GestureDetector(
                child: Text("Ver tudo",
                    style:
                    TextStyle(color: Colors.white, fontSize: 18)),
                onTap: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const TransacoesScreen()));
                },
              )
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
