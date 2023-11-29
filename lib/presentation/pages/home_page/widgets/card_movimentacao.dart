import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../domain/model/categoria_model.dart';
import '../../../../domain/model/movimentacao_model.dart';

class CardMovimentacao extends StatelessWidget {
  final Movimentacao movimentacao;
  final List<Categoria> categorias;
  const CardMovimentacao({super.key, required this.movimentacao, required this.categorias});

  @override
  Widget build(BuildContext context) {
    return Card(
        color: const Color(0xff10172c),
        elevation: 0,
        child: Row(
          children: [
            Container(
              width: 35,
              height: 35,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: movimentacao.valor > 0 ? Colors.green : Colors.red,
              ),
              child: Icon(
                movimentacao.valor > 0 ? Icons.arrow_upward_outlined : Icons.arrow_downward_outlined,
                color: Colors.white,
                size: 20,
              ),
            ),
            Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(categorias.firstWhere((element) => element.id == movimentacao.categoriaId).descricao,maxLines: 1,overflow: TextOverflow.ellipsis, textAlign: TextAlign.left ,style: TextStyle(color: Colors.white, fontSize: 14)),
                            Text(movimentacao.descricao,maxLines: 2,overflow: TextOverflow.ellipsis, textAlign: TextAlign.left ,style: TextStyle(color: Colors.grey, fontSize: 12)),
                          ],
                        ),
                      )
                    ],
                  ),
                )),
            Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text("R\$ ${movimentacao.valor.toStringAsFixed(2)}", textAlign: TextAlign.right ,style: TextStyle(color: movimentacao.valor > 0 ? Colors.green : Colors.red, fontSize: 14)),
                          Text(DateFormat("dd/MM/yyyy").format(movimentacao.data), textAlign: TextAlign.right ,style: TextStyle(color: Colors.grey, fontSize: 12)),
                        ],
                      ),
                    )
                  ],
                ))
          ],
        ));
  }
}
