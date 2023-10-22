import 'package:flutter/material.dart';
import 'package:smart_wallet/presentation/pages/home_page/widgets/card_movimentacao.dart';
import 'package:smart_wallet/presentation/pages/home_page/widgets/card_plano.dart';
import 'package:smart_wallet/presentation/pages/home_page/widgets/circle_icon.dart';
import 'package:smart_wallet/presentation/pages/home_page/widgets/header_icon.dart';
import 'package:smart_wallet/presentation/pages/home_page/widgets/movimentacao_list_view.dart';
import 'package:smart_wallet/presentation/pages/home_page/widgets/planos_list_view.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Color(0xFF121e3c),
            primaryColor: Color(0xFF121e3c),
            splashColor: Color(0xff10172c),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedItemColor: Colors.white,
            unselectedItemColor: Colors.grey.shade700,
            onTap: (_) {},
            currentIndex: 2,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.folder, size: 40), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(Icons.compare_arrows, size: 40), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(Icons.monetization_on, size: 40), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(Icons.bar_chart, size: 40), label: ""),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings, size: 40), label: "")
            ],
          ),
        ),
        backgroundColor: Color(0xff10172c),
        body: Column(
          children: [
            Expanded(flex: 7, child: HeaderIcon()),
            Expanded(flex: 4, child: PlanosListView()),
            Expanded(
                flex: 6,
                child: MovimentacaoListView())
          ],
        ),
      ),
    );
  }
}
