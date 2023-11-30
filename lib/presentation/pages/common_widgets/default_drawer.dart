import 'package:flutter/material.dart';

import '../cadastro_categoria_page/cadastro_categoria_screen.dart';
import '../login_page/main_screen.dart';
import '../user_info_screen/user_info_screen.dart';

class DefaultDrawer extends StatelessWidget {
  const DefaultDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: (MediaQuery.of(context).size.width / 2),
      child: Container(
        color: const Color(0xff10172c),
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: Image.asset("assets/logo_clara.png", width: MediaQuery.of(context).size.width / 3),
                  ),
                  TextButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => UserInfo()));
                      },
                      child: const Text(
                        "Minha conta",
                        style: TextStyle(color: Colors.white, fontSize: 18), textAlign: TextAlign.center,)),
                  TextButton(
                      onPressed: (){
                        Navigator.push(context, MaterialPageRoute(builder: (context) => CadastroCategoria()));
                      },
                      child: const Text(
                        "Nova categoria",
                        style: TextStyle(color: Colors.white, fontSize: 18), textAlign: TextAlign.center,))
                ],
              ),
              Column(
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      backgroundColor: const Color(0xff121e3c),
                      foregroundColor: Colors.white,
                      minimumSize: const Size.fromHeight(40), // NEW
                    ),
                    onPressed: () {
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>const MainScreen()));
                    },
                    child: const Text(
                      'Sair',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.w300, color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
