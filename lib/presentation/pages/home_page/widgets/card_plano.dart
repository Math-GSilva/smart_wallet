import 'package:flutter/material.dart';

import '../../../../domain/model/plano_model.dart';

class CardPlanoWidget extends StatelessWidget {
  final Plano plano;
  final String categoria;
  final double width;
  final double height;
  const CardPlanoWidget({super.key, required this.plano, required this.categoria, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 10),
      child: SizedBox(
        height: height,
        width: width,
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
                          plano.descricao,
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
                    Text(plano.valorAtual.toStringAsFixed(2), style: const TextStyle(color: Colors.white),),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: LinearProgressIndicator(
                            color: Colors.blue,
                            value: plano.valorAtual/ plano.gastoMax,
                            minHeight: 10,
                            borderRadius: const BorderRadius.all(Radius.circular(10))
                        ),
                      ),
                    ),
                    Text(plano.gastoMax.toStringAsFixed(2), style: const TextStyle(color: Colors.white)),
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
