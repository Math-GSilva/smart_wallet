import 'package:flutter/material.dart';

class LoginController {
  void showMySnackbar(BuildContext context, String message, Color cor) {
    final snackBar = SnackBar(
      backgroundColor: cor,
      content: Text(message),
      duration: Duration(seconds: 2),
    );

    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }
}