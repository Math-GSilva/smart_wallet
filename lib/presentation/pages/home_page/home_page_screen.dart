import 'package:flutter/material.dart';
import 'package:smart_wallet/presentation/pages/common_widgets/custom_bottom_navigation.dart';
import 'package:smart_wallet/presentation/pages/home_page/widgets/header_icon.dart';
import 'package:smart_wallet/presentation/pages/home_page/widgets/movimentacao_list_view.dart';
import 'package:smart_wallet/presentation/pages/home_page/widgets/planos_list_view.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
          child: const CustomBottomNavigation(),
        ),
        backgroundColor: Color(0xff10172c),
        body: const Column(
          children: [
            Expanded(flex: 7, child: HeaderIcon()),
            Expanded(flex: 4, child: PlanosListView()),
            Expanded(flex: 6, child: MovimentacaoListView())
          ],
        ),
      ),
    );
  }
}
