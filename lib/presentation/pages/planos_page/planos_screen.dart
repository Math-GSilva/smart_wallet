import 'package:flutter/material.dart';

import '../home_page/widgets/card_plano.dart';

class PlanosScreen extends StatefulWidget {
  const PlanosScreen({super.key});

  @override
  State<PlanosScreen> createState() => _PlanosScreenState();
}

class _PlanosScreenState extends State<PlanosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        centerTitle: true,
        title: Text("Meus planos"),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: Container(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 1,
                    itemBuilder: (context, index) {
                      return CardPlanoWidget(
                          categoria: "JOGOS",
                          descricao: "Máximo para skins",
                          cor: Colors.purple,
                          estimado: 100,
                          atual: 50);
                    },
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
