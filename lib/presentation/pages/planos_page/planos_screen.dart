import 'package:flutter/material.dart';

class PlanosScreen extends StatefulWidget {
  const PlanosScreen({super.key});

  @override
  State<PlanosScreen> createState() => _PlanosScreenState();
}

class _PlanosScreenState extends State<PlanosScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            backgroundColor: const Color(0xff10172c), ,
            appBar: AppBar(
            title: Text("MEUS PLANOS"),
        centerTitle: true,
        backgroundColor: const Color(0xff10172c), ,
    ),
    body: Container(),
    ));
    }
}
