import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatelessWidget {
  final String title;
  final String hint;
  final Color corTitle;
  final Color corTexto;
  final TextEditingController controller;
  final bool inicialEFinal;

  const CustomDatePicker({
    Key? key,
    this.title = "",
    this.hint = "",
    this.corTexto = Colors.white,
    this.corTitle = Colors.white,
    required this.controller,
    this.inicialEFinal = false,
  }) : super(key: key);

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
                      child: Text(title, style: TextStyle(color: corTitle, fontSize: 18)),
                    ),
                    Container(
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 20, 36, 74),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: TextField(
                        focusNode: AlwaysDisabledFocusNode(),
                        controller: controller,
                        onTap: () {
                            if (inicialEFinal) {
                              showDateRangePicker(
                                context: context,
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101),
                              ).then((pickedDate) {
                                if (pickedDate != null) {
                                  String startDate = DateFormat("dd/MM/yyyy").format(pickedDate.start);
                                  String endDate = DateFormat("dd/MM/yyyy").format(pickedDate.end);
                                  controller.text = '$startDate - $endDate';
                                }
                              });
                            } else {
                              showDatePicker(
                                context: context,
                                initialDate: DateTime.now(),
                                firstDate: DateTime(2000),
                                lastDate: DateTime(2101),
                              ).then((pickedDate) {
                                if (pickedDate != null) {
                                  controller.text = DateFormat("dd/MM/yyyy").format(pickedDate);
                                }
                              });
                            }
                        },
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.transparent,
                          border: InputBorder.none,
                          hintText: hint,
                          hintStyle: TextStyle(color: corTexto),
                        ),
                        style: TextStyle(color: corTexto),
                      ),
                    ),
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

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
