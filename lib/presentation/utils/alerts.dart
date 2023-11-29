import 'package:flutter/material.dart';

class Alerts {
  void showInSnackBar(String texto, Color cor, BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(texto),
      backgroundColor: cor,
      elevation: 5,
    ));
  }
}