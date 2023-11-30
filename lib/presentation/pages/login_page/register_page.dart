import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:smart_wallet/Services/user_service.dart';
import 'package:smart_wallet/presentation/pages/login_page/login_controller.dart';
import 'package:smart_wallet/presentation/pages/login_page/thanks_screen.dart';

import '../../../domain/model/user_model.dart';
import '../../utils/alerts.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController senhaController = TextEditingController();
  TextEditingController confirmSenhaController = TextEditingController();
  TextEditingController nomeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xff10172c),
          body: Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 50),
                    child: Image.asset("assets/logo_clara.png", height: 200),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: TextField(
                        controller: nomeController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.transparent,
                          border: InputBorder.none,
                          hintText: "Nome...",
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.transparent,
                          border: InputBorder.none,
                          hintText: "E-mail...",
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: TextField(
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        controller: senhaController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.transparent,
                          border: InputBorder.none,
                          hintText: "Senha...",
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border.all(
                            color: Colors.white,
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                      child: TextField(
                        obscureText: true,
                        enableSuggestions: false,
                        autocorrect: false,
                        controller: confirmSenhaController,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.transparent,
                          border: InputBorder.none,
                          hintText: "Repetir Senha...",
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                        ),
                        style: TextStyle(color: Colors.black),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 15),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: Color(0xff0249dd),
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(50), // NEW
                      ),
                      onPressed: () async {
                        if(nomeController.text.isEmpty){
                          LoginController().showMySnackbar(context, "Informe um nome!!", Colors.red);
                          return;
                        }
                        if(emailController.text.isEmpty){
                          LoginController().showMySnackbar(context, "Informe um e-mail!!", Colors.red);
                          return;
                        }
                        RegExp emailRegex = RegExp(
                          r'^[\w-]+(\.[\w-]+)*@([\w-]+\.)+[a-zA-Z]{2,7}$',
                        );
                        if(!emailRegex.hasMatch(emailController.text)){
                          Alerts().showInSnackBar("Informe um e-mail válido!", Colors.red, context);
                          return;
                        }
                        if(senhaController.text.isEmpty){
                          LoginController().showMySnackbar(context, "Informe uma senha!", Colors.red);
                          return;
                        }
                        if(senhaController.text != confirmSenhaController.text){
                          LoginController().showMySnackbar(context, "As senhas não conferem!", Colors.red);
                          return;
                        }
                        try{
                          var cred = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                            email: emailController.text,
                            password: senhaController.text,
                          );

                          UsuarioService()
                              .addUsuario(
                              Usuario(
                                  email:  cred.user!.email!,
                                  nomeUsuario: nomeController.text,
                                  telefone: null
                              ));
                        }catch(e){
                          if(e is FirebaseAuthException){
                            if(e.code == "email-already-in-use"){
                              LoginController().showMySnackbar(context, "Este e-mail já está sendo utilizado por outro usuário!", Colors.red);
                              return;
                            }
                          }
                          log(e.toString());
                        }
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const ThanksScreen()));
                      },
                      child: const Text(
                        'Registrar-se',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        )
    );
  }
}
