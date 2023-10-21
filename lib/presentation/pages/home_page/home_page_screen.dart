import 'package:flutter/material.dart';
import 'package:smart_wallet/presentation/pages/home_page/widgets/card_plano.dart';
import 'package:smart_wallet/presentation/pages/home_page/widgets/circle_icon.dart';
import 'package:smart_wallet/presentation/pages/home_page/widgets/header_icon.dart';
import 'package:smart_wallet/presentation/pages/home_page/widgets/planos_list_view.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {


    return const SafeArea(
      child: Scaffold(
        backgroundColor: Color(0xff10172c),
        body: Column(
          children: [
            Expanded(
                flex: 7,
                child: HeaderIcon()
            ),
            Expanded(
                flex: 4,
                child: PlanosListView()),
            Expanded(
                flex: 5,
                child: Padding(
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
                    ],
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
