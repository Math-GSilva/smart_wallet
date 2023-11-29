import 'package:flutter/material.dart';
import 'package:smart_wallet/Services/categoria_service.dart';
import 'package:smart_wallet/Services/movimentacao_service.dart';
import 'package:smart_wallet/persistance/movimentacao_repository_impl.dart';
import 'package:smart_wallet/presentation/pages/transacoes_page/transacoes_screen.dart';

import '../../../../domain/model/categoria_model.dart';
import '../../../../domain/model/movimentacao_model.dart';
import 'card_movimentacao.dart';

class MovimentacaoListView extends StatefulWidget {
  final bool showLabels;
  const MovimentacaoListView({this.showLabels = false, super.key});

  @override
  State<MovimentacaoListView> createState() => _MovimentacaoListViewState();
}

class _MovimentacaoListViewState extends State<MovimentacaoListView> {


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
            child: StreamBuilder<List<Movimentacao>>(
              stream: MovimentacaoService().getMovimentacoes(),
              builder: (context, snapshotMovimentacoes) {
                if (snapshotMovimentacoes.hasError) {
                  return Text('Erro: ${snapshotMovimentacoes.error}');
                }

                if (!snapshotMovimentacoes.hasData) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                final List<Movimentacao> listaMovimentacoes = snapshotMovimentacoes.data!;

                return StreamBuilder<List<Categoria>>(
                  stream: CategoriaService().getCategorias(),
                  builder: (context, snapshotCategorias) {
                    if (snapshotCategorias.hasError) {
                      return Text('Erro: ${snapshotCategorias.error}');
                    }

                    if (!snapshotCategorias.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }

                    final List<Categoria> listaCategorias = snapshotCategorias.data!;

                    return ListView.builder(
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemCount: listaMovimentacoes.length,
                      itemBuilder: (context, index) {
                        return CardMovimentacao(
                          movimentacao: listaMovimentacoes[index],
                          categorias: listaCategorias,
                          cor: Color(0xff14142b),
                        );
                      },
                    );
                  },
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
