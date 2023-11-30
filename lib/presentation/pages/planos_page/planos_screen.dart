import 'package:flutter/material.dart';
import 'package:smart_wallet/presentation/pages/planos_page/cadastro_plano_screen.dart';
import 'package:smart_wallet/presentation/pages/planos_page/info_plano_screen.dart';

import '../../../Services/categoria_service.dart';
import '../../../Services/plano_service.dart';
import '../../../domain/model/categoria_model.dart';
import '../../../domain/model/plano_model.dart';
import '../cadastro_categoria_page/cadastro_categoria_screen.dart';
import '../common_widgets/custom_bottom_navigation.dart';
import '../common_widgets/default_drawer.dart';
import '../home_page/widgets/card_plano.dart';
import '../login_page/main_screen.dart';

class PlanosScreen extends StatefulWidget {
  const PlanosScreen({super.key});

  @override
  State<PlanosScreen> createState() => _PlanosScreenState();
}

class _PlanosScreenState extends State<PlanosScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(25),
        ),
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context)=> CadastroPlano()));
        },
        child: Icon(
          Icons.add,
          color: Colors.black, // Cor do ícone
        ),
      ),
      backgroundColor: const Color(0xff10172c),
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () {
              Scaffold.of(context).openDrawer();
            },
            icon: const Icon(
              Icons.settings,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: const Color(0xff10172c),
        title: Text("MEUS PLANOS", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w600),),
        centerTitle: true,
      ),
      drawer: DefaultDrawer(),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: const Color(0xFF121e3c),
          primaryColor: const Color(0xFF121e3c),
          splashColor: const Color(0xff10172c),
        ),
        child: const CustomBottomNavigation(index: 2),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          StreamBuilder<List<Categoria>>(
            stream: CategoriaService().getCategorias(),
            builder: (context, categoriaSnapshot) {
              if (categoriaSnapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (categoriaSnapshot.hasError) {
                return Text("Erro: ${categoriaSnapshot.error}");
              } else {
                return StreamBuilder<List<Plano>>(
                  stream: PlanoService().getPlanos(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text("Erro: ${snapshot.error}");
                    } else {
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: ListView(
                            scrollDirection: Axis.vertical,
                            children: [
                              for (var p in snapshot.data!)
                                GestureDetector(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => InfoPlano(plano: p, descricao: categoriaSnapshot.data!.firstWhere((element) => element.id == p.idCategoria).descricao)));
                                  },
                                  child: CardPlanoWidget(
                                    categoria: categoriaSnapshot.data!.firstWhere((element) => element.id == p.idCategoria).descricao,
                                    plano: p,
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height * 0.15,
                                  ),
                                )
                            ],
                          ),
                        ),
                      );
                    }
                  },
                );
              }
            },
          )
        ],
      ),
    );
  }
}
