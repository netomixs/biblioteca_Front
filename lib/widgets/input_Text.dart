// ignore: file_names
import 'package:flutter/material.dart';

class InputText extends StatelessWidget {
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData? icon;
  final TextEditingController? controller;
  final void Function()? onEditingComplete;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final String? label;
  final String? erroText;
  final int? maxLength;
  const InputText(
      {Key? key,
      required this.hintText,
      this.controller,
      this.keyboardType = TextInputType.text,
      this.obscureText = false,
      this.icon,
      this.focusNode,
      this.erroText,
      this.onEditingComplete,
      this.validator,
      this.label,  this.maxLength})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        child: TextFormField(
          maxLength: maxLength != null ? maxLength : null,
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          focusNode: focusNode,
          onEditingComplete: onEditingComplete,
          decoration: InputDecoration(
            errorText: erroText,
            prefixIcon: icon != null ? Icon(icon) : null,
            hintText: hintText,
            labelText: hintText,
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
            contentPadding:
                const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
          ),
        ));
  }

  void errorDecoration(Color color, String text) {}
  static void nextFocus(
      List<FocusNode> list, int actual, int siguiente, BuildContext context) {
    list[actual].unfocus();
    FocusScope.of(context).requestFocus(list[siguiente]);
  }
}
