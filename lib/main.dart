import 'package:flutter/material.dart';
import 'package:smart_wallet/data/DBHelper.dart';
import 'package:smart_wallet/presentation/pages/home_page/home_page_screen.dart';
import 'package:smart_wallet/presentation/pages/movimentacao_page/movimentacao_screen.dart';
import 'package:smart_wallet/presentation/pages/transacoes_page/transacoes_screen.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dbHelper = DBHelper.instance;
  final database = await dbHelper.database;

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
      home: TransacoesScreen(),
    );
  }
}
