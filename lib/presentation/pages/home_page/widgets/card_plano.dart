import 'package:flutter/material.dart';

class CardPlanoWidget extends StatelessWidget {
  final String categoria;
  final String descricao;
  final Color cor;
  final double estimado;
  final double atual;
  const CardPlanoWidget({super.key, required this.categoria, required this.descricao, required this.cor, required this.estimado, required this.atual});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10, right: 15 ),
      child: SizedBox(
        height: 100,
        width: 210,
        child: Card(
          color: const Color(0xFF121e3c),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          descricao,
                          style: const TextStyle(
                              color: Colors.grey
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          categoria,
                          style: const TextStyle(
                              color: Colors.white
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(atual.toStringAsFixed(2), style: const TextStyle(color: Colors.white),),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: LinearProgressIndicator(
                            color: cor,
                            value: atual / estimado,
                            minHeight: 10,
                            borderRadius: const BorderRadius.all(Radius.circular(10))
                        ),
                      ),
                    ),
                    Text(estimado.toStringAsFixed(2), style: const TextStyle(color: Colors.white)),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
