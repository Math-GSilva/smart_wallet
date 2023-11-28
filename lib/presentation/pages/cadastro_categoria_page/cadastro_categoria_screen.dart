import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_wallet/Services/categoria_service.dart';
import 'package:smart_wallet/presentation/pages/home_page/home_page_screen.dart';
import 'package:smart_wallet/presentation/pages/movimentacao_page/widgets/custom_text_field.dart';

import '../../../domain/model/categoria_model.dart';

class CadastroCategoria extends StatefulWidget {
  const CadastroCategoria({super.key});

  @override
  State<CadastroCategoria> createState() => _CadastroCategoriaState();
}

class _CadastroCategoriaState extends State<CadastroCategoria> {
  TextEditingController descController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        centerTitle: true,
        backgroundColor: const Color(0xff10172c),
        title: const Text("Nova Categoria",
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
      ),
      backgroundColor: const Color(0xff10172c),
      body: Column(
        children: [
          CustomTextField(controller: descController, title: "Descrição"),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                backgroundColor: const Color(0xff0249dd),
                foregroundColor: Colors.white,
                minimumSize: const Size.fromHeight(50), // NEW
              ),
              onPressed: () async {
                if(descController.text.isEmpty){
                  return;
                }
                try{
                  await CategoriaService().addCategoria(Categoria(descricao: descController.text));
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (_)=>HomePage()));
                } catch(e){
                  return;
                }
              },
              child: const Text(
                'Salvar',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
