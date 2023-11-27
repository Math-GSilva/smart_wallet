import 'package:flutter/material.dart';

import 'login_screen.dart';

class ThanksScreen extends StatefulWidget {
  const ThanksScreen({super.key});

  @override
  State<ThanksScreen> createState() => _ThanksScreenState();
}

class _ThanksScreenState extends State<ThanksScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: const Color(0xffe2e6ed),
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: Column(
                  children: [
                    Image.asset("assets/logo_escura.png", height: 200),
                    const SizedBox(height: 20),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text("Hey! Estou feliz que você veio!", style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold)),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(child: Text("Para nós é muito bom saber que você confia e acredita em nossos serviços!", style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400))),
                      ],
                    ),
                    const SizedBox(height: 20),
                    const Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Expanded(child: Text("E sempre um prazer ter você em nosso grupo!", style: TextStyle(fontSize: 20,fontWeight: FontWeight.w400))),
                      ],
                    ),
                    const SizedBox(height: 20),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        backgroundColor: const Color(0xff0249dd),
                        foregroundColor: Colors.white,
                        minimumSize: const Size.fromHeight(50), // NEW
                      ),
                      onPressed: () {
                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
                      },
                      child: const Text(
                        'Entrar',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        )
    );
  }
}
