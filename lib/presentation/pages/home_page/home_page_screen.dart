import 'package:flutter/material.dart';
import 'package:smart_wallet/presentation/pages/cadastro_categoria_page/cadastro_categoria_screen.dart';
import 'package:smart_wallet/presentation/pages/common_widgets/custom_bottom_navigation.dart';
import 'package:smart_wallet/presentation/pages/home_page/widgets/header_widget.dart';
import 'package:smart_wallet/presentation/pages/home_page/widgets/movimentacao_list_view.dart';
import 'package:smart_wallet/presentation/pages/home_page/widgets/planos_list_view.dart';
import 'package:smart_wallet/presentation/pages/login_page/main_screen.dart';

import '../../../persistance/movimentacao_repository_impl.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  double valorTotal = 0;


  @override
  void initState() {
    MovimentacaoRepository().getAll().then((value) {
      if(value.isNotEmpty){
        setState(() {
          valorTotal = value.map((e) => e.valor).reduce((value, element) => value + element);
        });
      }
    });
  }


  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        drawer: Drawer(
          width: (MediaQuery.of(context).size.width / 2),
          child: Container(
            color: const Color(0xff10172c),
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Image.asset("assets/logo_clara.png", width: MediaQuery.of(context).size.width / 3),
                      ),
                      TextButton(
                          onPressed: (){},
                          child: const Text(
                            "Minha conta",
                            style: TextStyle(color: Colors.white, fontSize: 18), textAlign: TextAlign.center,)),
                      TextButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context) => CadastroCategoria()));
                          },
                          child: const Text(
                            "Nova categoria",
                            style: TextStyle(color: Colors.white, fontSize: 18), textAlign: TextAlign.center,))
                    ],
                  ),
                  Column(
                    children: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          backgroundColor: const Color(0xff121e3c),
                          foregroundColor: Colors.white,
                          minimumSize: const Size.fromHeight(40), // NEW
                        ),
                        onPressed: () {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const MainScreen()));
                        },
                        child: const Text(
                          'Sair',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300, color: Colors.white),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: const Color(0xFF121e3c),
            primaryColor: const Color(0xFF121e3c),
            splashColor: const Color(0xff10172c),
          ),
          child: const CustomBottomNavigation(index: 2),
        ),
        backgroundColor: const Color(0xff10172c),
        body: Column(
          children: [
            Expanded(flex: 7, child: HeaderWidget(valorTotal: valorTotal)),
            const Expanded(flex: 4, child: PlanosListView()),
            const Expanded(flex: 6, child: MovimentacaoListView(showLabels: true,))
          ],
        ),
      ),
    );
  }


}
