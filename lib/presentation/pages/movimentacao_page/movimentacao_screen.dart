import 'package:flutter/material.dart';
import 'package:smart_wallet/domain/model/movimentacao_model.dart';
import 'package:smart_wallet/persistance/movimentacao_repository_impl.dart';
import 'package:smart_wallet/presentation/pages/movimentacao_page/widgets/custom_text_field.dart';

class MovimentacaoScreen extends StatelessWidget {
  const MovimentacaoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(

          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text("ADICIONAR ENTRADA", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 18),),
          centerTitle: true,
        ),
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
        body: SingleChildScrollView(
          child: Column(
            children: [
              CustomTextField(title: "Categoria", hint: "..."),
              CustomTextField(title: "Descrição", hint: "..."),
              CustomTextField(title: "Data", hint: "..."),
              CustomTextField(title: "Valor", hint: "R\$0,00", corTexto: Colors.green,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff0249dd),
                    minimumSize: const Size.fromHeight(50),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  onPressed: () async {
                    await MovimentacaoRepository().insert(Movimentacao(id: null, valor: 100, tipo: "1", descricao: "teste", data: DateTime.now().toString(), categoriaId: 1));
                  },
                  child: const Text(
                    'Salvar',
                    style: TextStyle(fontSize: 20,color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
