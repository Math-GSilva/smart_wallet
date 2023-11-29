import 'package:flutter/material.dart';
import 'package:smart_wallet/Services/categoria_service.dart';
import 'package:smart_wallet/presentation/pages/planos_page/planos_screen.dart';

import '../../../../Services/plano_service.dart';
import '../../../../domain/model/categoria_model.dart';
import '../../../../domain/model/plano_model.dart';
import 'card_plano.dart';

class PlanosListView extends StatelessWidget {
  const PlanosListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 20),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Meus Planos", style: TextStyle(color: Colors.white, fontSize: 18)),
                GestureDetector(
                  child: Text("Ver tudo",
                      style:
                      TextStyle(color: Colors.white, fontSize: 18)),
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> const PlanosScreen()));
                  },
                )
              ],
            ),
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
                        return Container(
                          height: 120,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            children: [
                              for (var p in snapshot.data!)
                                CardPlanoWidget(
                                  categoria: categoriaSnapshot.data!.firstWhere((element) => element.id == p.idCategoria).descricao ?? 'Categoria Desconhecida',
                                  plano: p,
                                  height: 100,
                                  width: 210,
                                )
                            ],
                          ),
                        );
                      }
                    },
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
