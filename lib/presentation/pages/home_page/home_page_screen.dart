import 'package:flutter/material.dart';
import 'package:smart_wallet/Services/movimentacao_service.dart';
import 'package:smart_wallet/presentation/pages/cadastro_categoria_page/cadastro_categoria_screen.dart';
import 'package:smart_wallet/presentation/pages/common_widgets/custom_bottom_navigation.dart';
import 'package:smart_wallet/presentation/pages/common_widgets/default_drawer.dart';
import 'package:smart_wallet/presentation/pages/home_page/widgets/header_widget.dart';
import 'package:smart_wallet/presentation/pages/home_page/widgets/movimentacao_list_view.dart';
import 'package:smart_wallet/presentation/pages/home_page/widgets/planos_list_view.dart';
import 'package:smart_wallet/presentation/pages/login_page/main_screen.dart';
import 'package:smart_wallet/presentation/pages/user_info_screen/user_info_screen.dart';

import '../../../domain/model/movimentacao_model.dart';
import '../../../persistance/movimentacao_repository_impl.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  double valorTotal = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: DefaultDrawer(),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: const Color(0xFF121e3c),
            primaryColor: const Color(0xFF121e3c),
            splashColor: const Color(0xff10172c),
          ),
          child: const CustomBottomNavigation(index: 1),
        ),
        backgroundColor: const Color(0xff10172c),
        body: Column(
          children: [
            Expanded(flex: 7, child: StreamBuilder<List<Movimentacao>>(
              stream: MovimentacaoService().getMovimentacoes(),
              builder: (context, snapshotMovimentacoes) {
                if (snapshotMovimentacoes.hasError) {
                  return Text('Erro: ${snapshotMovimentacoes.error}');
                }

                if (!snapshotMovimentacoes.hasData) {
                  return const CircularProgressIndicator();
                }

                final List<Movimentacao> listaMovimentacoes = snapshotMovimentacoes.data!;
                double valorTotal = listaMovimentacoes
                    .map((movimentacao) => movimentacao.valor)
                    .fold(0, (previousValue, element) => previousValue + element);

                return HeaderWidget(valorTotal: valorTotal);
              },
            )),
            const Expanded(flex: 4, child: PlanosListView()),
            const Expanded(flex: 6, child: MovimentacaoListView(showLabels: true,))
          ],
        ),
      ),
    );
  }


}
