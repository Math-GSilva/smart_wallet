import 'package:flutter/material.dart';
import 'package:smart_wallet/Services/movimentacao_service.dart';
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
