import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_wallet/presentation/pages/home_page/home_page_screen.dart';
import 'package:smart_wallet/presentation/pages/login_page/login_controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController senhaController = TextEditingController();
    return SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xff10172c),
          body:Padding(
            padding: const EdgeInsets.symmetric(vertical: 40),
            child: Center(
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 50),
                      child: Image.asset("assets/logo_clara.png", height: 200),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.white,
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(10))
                        ),
                        child: TextField(
                          controller: emailController,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.transparent,
                            border: InputBorder.none,
                            hintText: "E-mail...",
                            hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                          ),
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                      child: Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: Colors.white,
                            ),
                            borderRadius: const BorderRadius.all(Radius.circular(10))
                        ),
                        child: TextField(
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          controller: senhaController,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.transparent,
                            border: InputBorder.none,
                            hintText: "Senha...",
                            hintStyle: TextStyle(color: Colors.grey, fontSize: 18),
                          ),
                          style: const TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 15),
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
                          try{
                            var cred = await FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: emailController.text,
                              password: senhaController.text,
                            );
                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
                          }catch(e){
                            if(e is FirebaseAuthException){
                              if(e.code == "wrong-password" || e.code == "user-not-found"){
                                LoginController().showMySnackbar(context, "Senha ou usuário inválido", Colors.red);
                                return;
                              }
                            }
                            LoginController().showMySnackbar(context, "Erro ao efetuar login", Colors.red);
                            return;
                          }
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        )
    );
  }
}
