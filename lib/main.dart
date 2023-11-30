import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:smart_wallet/data/DBHelper.dart';
import 'package:smart_wallet/presentation/pages/cadastro_categoria_page/cadastro_categoria_screen.dart';
import 'package:smart_wallet/presentation/pages/home_page/home_page_screen.dart';
import 'package:smart_wallet/presentation/pages/login_page/login_screen.dart';
import 'package:smart_wallet/presentation/pages/login_page/main_screen.dart';
import 'package:smart_wallet/presentation/pages/planos_page/cadastro_plano_screen.dart';
import 'package:smart_wallet/presentation/pages/planos_page/planos_screen.dart';
import 'package:smart_wallet/presentation/pages/user_info_screen/change_password_screen.dart';
import 'package:smart_wallet/presentation/pages/user_info_screen/edit_email.dart';
import 'package:smart_wallet/presentation/pages/user_info_screen/edit_telephone_screen.dart';
import 'package:smart_wallet/presentation/pages/user_info_screen/user_info_screen.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dbHelper = DBHelper.instance;
  final database = await dbHelper.database;
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo teste',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MainScreen(),
    );
  }
}
