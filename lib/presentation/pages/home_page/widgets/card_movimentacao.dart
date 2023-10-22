import 'package:flutter/material.dart';

class CardMovimentacao extends StatelessWidget {
  const CardMovimentacao({super.key});

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
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.red,
              ),
              child: Icon(
                Icons.arrow_downward_outlined,
                color: Colors.white,
                size: 20,
              ),
            ),
            const Expanded(
                flex: 4,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("Delivery", textAlign: TextAlign.left ,style: TextStyle(color: Colors.white, fontSize: 14)),
                          Text("Comida", textAlign: TextAlign.left ,style: TextStyle(color: Colors.grey, fontSize: 12)),
                        ],
                      )
                    ],
                  ),
                )),
            Expanded(
                flex: 2,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(349.toStringAsFixed(2), textAlign: TextAlign.right ,style: const TextStyle(color: Colors.red, fontSize: 14)),
                        const Text("Hoje", textAlign: TextAlign.right ,style: TextStyle(color: Colors.grey, fontSize: 12)),
                      ],
                    )
                  ],
                ))
          ],
        ));
  }
}
