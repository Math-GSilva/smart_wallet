import 'package:flutter/material.dart';
import 'package:smart_wallet/Services/user_service.dart';
import 'package:smart_wallet/presentation/utils/alerts.dart';

import '../../../domain/model/user_model.dart';


class ChangePassword extends StatefulWidget {
  final Usuario user;
  const ChangePassword({required this.user, super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  TextEditingController senha = TextEditingController();
  TextEditingController novaSenha = TextEditingController();
  TextEditingController repetirNovaSenha = TextEditingController();

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
                            backgroundImage: AssetImage("assets/userIcon.png"),
                            radius: 55,
                            backgroundColor: Color(0xffe2e6ed),
                          ),
                        ),
                        Text(widget.user.nomeUsuario, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 24))
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
                                    child: Icon(Icons.security_outlined, size: 40,),
                                  ),
                                  Text("Alterar Senha", style: TextStyle(fontSize: 20, color: Color(0xff10172c)),),
                                ],
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Senha Atual", style: TextStyle(color: Color(0xff979798), fontWeight: FontWeight.w700),),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.white,
                                        ),
                                        borderRadius: const BorderRadius.all(Radius.circular(10))
                                    ),
                                    child: TextField(
                                      obscureText: true,
                                      textAlign: TextAlign.center,
                                      controller: senha,
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
                                  Text("Nova Senha", style: TextStyle(color: Color(0xff979798), fontWeight: FontWeight.w700),),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.white,
                                        ),
                                        borderRadius: const BorderRadius.all(Radius.circular(10))
                                    ),
                                    child: TextField(
                                      obscureText: true,
                                      textAlign: TextAlign.center,
                                      controller: novaSenha,
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
                                  Text("Repetir Nova Senha", style: TextStyle(color: Color(0xff979798), fontWeight: FontWeight.w700),),
                                  Container(
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        border: Border.all(
                                          color: Colors.white,
                                        ),
                                        borderRadius: const BorderRadius.all(Radius.circular(10))
                                    ),
                                    child: TextField(
                                      obscureText: true,
                                      textAlign: TextAlign.center,
                                      controller: repetirNovaSenha,
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
                            if(senha.text.isEmpty){
                              Alerts().showInSnackBar("Informe sua senha!", Colors.red, context);
                              return;
                            }
                            if(novaSenha.text.isEmpty){
                              Alerts().showInSnackBar("Informe uma nova senha válida!", Colors.red, context);
                              return;
                            }
                            if(repetirNovaSenha.text.isEmpty || novaSenha.text != repetirNovaSenha.text ){
                              Alerts().showInSnackBar("As senhas não conferem!", Colors.red, context);
                              return;
                            }
                            await UsuarioService().changePass(senha.text, novaSenha.text, widget.user);
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
