import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:smart_wallet/Services/user_service.dart';
import '../../../domain/model/user_model.dart';
import '../../utils/alerts.dart';

class EditTelephone extends StatefulWidget {
  final Usuario user;
  const EditTelephone({required this.user,super.key});

  @override
  State<EditTelephone> createState() => _EditTelephoneState();
}

class _EditTelephoneState extends State<EditTelephone> {
  TextEditingController controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          appBar: AppBar(
            leading: Builder(
              builder: (context) => IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
              ),
            ),
            title: Text(
              "MINHA CONTA",
              style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
            ),
            backgroundColor: Color(0xff10172c),
            centerTitle: true,
          ),
          backgroundColor: Color(0xff10172c),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: CircleAvatar(
                              radius: 55,
                              backgroundColor: Colors.green
                          ),
                        ),
                        Text("Nome do Usuario", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),)
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          color: Color(0xffe2e6ed),
                        ),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 15),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(10),
                                    child: Icon(Icons.local_phone_outlined, size: 40,),
                                  ),
                                  Text("Editar Telefone", style: TextStyle(fontSize: 20, color: Color(0xff10172c)),),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Número de Telefone Antigo", style: TextStyle(color: Color(0xff979798), fontWeight: FontWeight.w700),),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.white,
                                        ),
                                        borderRadius: const BorderRadius.all(Radius.circular(10))
                                    ),
                                    child: TextField(
                                      enabled: false,
                                        textAlign: TextAlign.center,
                                      controller: TextEditingController(text: widget.user.telefone ?? "Sem telefone registrado"),
                                      decoration: const InputDecoration(
                                        filled: true,
                                        fillColor: Colors.transparent,
                                        border: InputBorder.none,
                                      ),
                                      style: const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical:15),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Novo Número de Telefone", style: TextStyle(color: Color(0xff979798), fontWeight: FontWeight.w700),),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.white,
                                        ),
                                        borderRadius: const BorderRadius.all(Radius.circular(10))
                                    ),
                                    child: TextField(
                                      inputFormatters: [
                                        MaskTextInputFormatter(
                                          mask: '(##) #####-####',
                                          filter: {"#": RegExp(r'[0-9]')}
                                        ),
                                      ],
                                        textAlign: TextAlign.center,
                                      controller: controller,
                                      decoration: const InputDecoration(
                                        filled: true,
                                        fillColor: Colors.transparent,
                                        border: InputBorder.none,
                                      ),
                                      style: const TextStyle(color: Colors.black),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            backgroundColor: const Color(0xffe2e6ed),
                            foregroundColor: const Color(0xff14142b),
                            minimumSize: const Size.fromHeight(60), // NEW
                          ),
                          onPressed: () async {
                            if(controller.text.isEmpty){
                              Alerts().showInSnackBar("Informe um número válido!", Colors.red, context);
                              return;
                            }
                            if(widget.user.telefone == controller.text){
                              Alerts().showInSnackBar("Informe um número diferente do atual!", Colors.red, context);
                              return;
                            }
                            widget.user.telefone = controller.text;
                            await UsuarioService().updateUsuario(widget.user);
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Salvar',
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
