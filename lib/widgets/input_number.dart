import 'package:flutter/material.dart';

class InputNumber extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final IconData? icon;
  final TextEditingController? controller;
  final void Function()? onEditingComplete;

  final FocusNode? focusNode;
  final String? label;
  final String? medida;
  const InputNumber({
    Key? key,
    required this.hintText,
    this.controller,
    this.obscureText = false,
    this.icon,
    this.focusNode,
    this.onEditingComplete,
    this.label,
    this.medida,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: TextFormField(
        controller: controller,
        keyboardType: TextInputType.number,
        obscureText: obscureText,
        validator: (value) {
          if (value!.isEmpty) {
            return "Completa este campo";
          }
          return null;
        },
        focusNode: focusNode,
        onChanged: (value) {},
        onEditingComplete: onEditingComplete,
        onTap: () {
          if (controller!.text == "0") {
            controller!.text = "";
          }
        },
        decoration: InputDecoration(
          prefixIcon: icon != null ? Icon(icon) : null,
          hintText: hintText,
          labelText: label,
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        ),
      ),
    );
  }

  void errorDecoration(Color color, String text) {}
 
  static void nextFocus(
      List<FocusNode> list, int actual, int siguiente, BuildContext context) {
    list[actual].unfocus();
    FocusScope.of(context).requestFocus(list[siguiente]);
  }
}
