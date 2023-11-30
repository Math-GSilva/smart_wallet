import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:smart_wallet/presentation/pages/common_widgets/custom_bottom_navigation.dart';
import 'package:smart_wallet/presentation/pages/login_page/main_screen.dart';
import 'package:smart_wallet/presentation/pages/user_info_screen/change_password_screen.dart';
import 'package:smart_wallet/presentation/pages/user_info_screen/edit_email.dart';
import 'package:smart_wallet/presentation/pages/user_info_screen/edit_telephone_screen.dart';
import '../../../Services/user_service.dart';
import '../../../domain/model/user_model.dart';

class UserInfo extends StatelessWidget {
  final UsuarioService usuarioService = UsuarioService();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: CustomBottomNavigation(index: 2),
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
          child: StreamBuilder<List<Usuario>>(
            stream: usuarioService.getUserInfo(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data!.isNotEmpty) {
                Usuario usuario = snapshot.data![0]; // Assumindo que há apenas um usuário

                return Column(
                  children: [
                    Expanded(
                      flex: 4,
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
                          Text(
                            usuario.nomeUsuario, style: TextStyle(color: Colors.white, fontWeight: FontWeight.w400, fontSize: 24),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                          color: Color(0xffe2e6ed),
                        ),
                        child: Column(
                          children: [
                            Expanded(
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => EditTelephone(user: usuario)));
                                  },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          child: Padding(
                                            padding: const EdgeInsets.all(10),
                                            child: Icon(Icons.local_phone_outlined, size: 40,),
                                          ),
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Telefone", style: TextStyle(fontSize: 20, color: Color(0xffb1b2b4)),),
                                            Text(usuario.telefone ?? "Sem telefone cadastrado",style: TextStyle(fontSize: 16)),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Icon(Icons.arrow_forward_ios),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => EditEmail(user: usuario)));
                                },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Icon(Icons.email_outlined, size: 40,),
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("E-mail", style: TextStyle(fontSize: 20, color: Color(0xffb1b2b4)),),
                                            Text(usuario.email,style: TextStyle(fontSize: 16)),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Icon(Icons.arrow_forward_ios),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              child: GestureDetector(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (_) => ChangePassword(user: usuario)));
                                  },
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Row(
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.all(10),
                                          child: Icon(Icons.security, size: 40,),
                                        ),
                                        Column(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text("Senha", style: TextStyle(fontSize: 20, color: Color(0xffb1b2b4)),),
                                            Text("Redefinir Senha",style: TextStyle(fontSize: 16)),
                                          ],
                                        ),
                                      ],
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                      child: Icon(Icons.arrow_forward_ios),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
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
                          minimumSize: const Size.fromHeight(60),
                        ),
                        onPressed: () async {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => MainScreen()));
                        },
                        child: const Text(
                          'Sair',
                          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w400),
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            },
          ),
        ),
      ),
    );
  }
}
