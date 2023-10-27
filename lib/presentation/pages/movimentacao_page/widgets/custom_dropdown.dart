import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:smart_wallet/presentation/pages/movimentacao_page/controller_movimentacao_page.dart';
import 'package:smart_wallet/presentation/utils/lista_categorias.dart';

import '../../../../domain/model/categoria_model.dart';

class CustomDropDown<T> extends StatefulWidget {
  final String title;
  final String hint;
  final Color corTitle;
  final Color corTexto;
  final ControllerMovimentacao controller;

  CustomDropDown({
    Key? key,
    this.title = "",
    this.hint = "",
    this.corTexto = Colors.white,
    this.corTitle = Colors.white,
    required this.controller,
  }) : super(key: key);

  @override
  _CustomDropDownState<T> createState() => _CustomDropDownState<T>();
}

class _CustomDropDownState<T> extends State<CustomDropDown<T>> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: const Color(0xff121e3c),
                borderRadius: BorderRadius.circular(20),
              ),
              height: 100,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 5, top: 10),
                      child: Text(
                        widget.title,
                        style: TextStyle(color: widget.corTitle, fontSize: 18),
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(255, 20, 36, 74),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: DropdownButton<Categoria>(
                              dropdownColor: const Color.fromARGB(255, 20, 36, 74),
                              borderRadius: BorderRadius.circular(10),
                              value: widget.controller.categoriaSelecionada,
                              items: categoriasTeste.map((Categoria value) {
                                return DropdownMenuItem<Categoria>(
                                  value: value,
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: const Color.fromARGB(255, 20, 36, 74),
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 10.0),
                                      child: Text(
                                        value.toString(),
                                        style: const TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  if(value != null){
                                    widget.controller.categoriaSelecionada = value;
                                  }

                                });
                              },
                              underline: Container(),
                              icon: const Icon(
                                Icons.arrow_drop_down,
                                color: Colors.white,
                              ),
                              iconSize: 24,
                              style: const TextStyle(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CurrencyPtBrInputFormatter extends TextInputFormatter {
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.selection.baseOffset == 0) {
      return newValue;
    }

    double value = double.parse(newValue.text);
    final formatter = NumberFormat("#,##0.00", "pt_BR");
    String newText = "R\$ ${formatter.format(value / 100)}";

    return newValue.copyWith(
        text: newText,
        selection: TextSelection.collapsed(offset: newText.length));
  }
}
