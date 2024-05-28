import 'package:flutter/material.dart';

class InputTextOnTap extends StatelessWidget {
  final String hintText;
  final TextInputType keyboardType;
  final bool obscureText;
  final IconData? icon;
  final TextEditingController? controller;
  final  void Function()? onEditingComplete;
   final  void Function()? onTap;
   final  String? Function(String?)? validator;
  final FocusNode? focusNode;
  final String? erroText;
  const InputTextOnTap({
    Key? key,
    required this.hintText,
    this.controller,
    this.keyboardType = TextInputType.text,
    this.obscureText = false,
    this.icon,
    this.focusNode,
    this.erroText,
    this.onEditingComplete,
     this.validator, this.onTap
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(10),
        child: TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          obscureText: obscureText,
          validator: validator,
          focusNode: focusNode,
          onEditingComplete: onEditingComplete,
          onTap: onTap,
          decoration:
           InputDecoration(
            errorText: erroText,
            prefixIcon: icon != null ? Icon(icon) : null,
            hintText: hintText,
          
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
  void errorDecoration(Color color, String text){

  }
  ///Metodo que cambia entre los nodos indicados
  ///List: FocusNode
  ///Nodo actual: int
  ///Nodo siguiente: int
  ///Contexto :BuildContext
   static void nextFocus(List<FocusNode> list,int actual,int siguiente, BuildContext context) {
    list[actual].unfocus();
    FocusScope.of(context).requestFocus(list[siguiente]);
  }
}
