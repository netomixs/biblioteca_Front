import 'package:flutter/material.dart';

class InputPassword extends StatefulWidget {
  final String hintText;
  final TextInputType keyboardType;
  final IconData? icon;
  final TextEditingController? controller;
  final void Function()? onEditingComplete;
  final FocusNode? focusNode;
  final String? errorText;
   final  String? Function(String?)? validator;
  const InputPassword({
    Key? key,
    this.controller,
    required this.hintText,
    this.keyboardType = TextInputType.text,
    this.icon,
    this.onEditingComplete,
    this.focusNode,
    this.errorText,
     this.validator,
  }) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _InputPasswordState createState() => _InputPasswordState();
  
}

class _InputPasswordState extends State<InputPassword> {
  
  bool obscureText = true;
 
  @override
  Widget build(BuildContext context) {
 
    return Container(
      margin: const EdgeInsets.all(10),
      child: TextFormField(
        keyboardType: widget.keyboardType,
        obscureText: obscureText,
        controller: widget.controller,
        onEditingComplete: widget.onEditingComplete,
        focusNode: widget.focusNode,
        validator: widget.validator,
        decoration: InputDecoration(
   
          filled: true,
          fillColor: Colors.white,
          prefixIcon: widget.icon != null ? Icon(widget.icon) : null,
          hintText: widget.hintText,
          suffixIcon: IconButton(
            icon: Icon(
              obscureText ? Icons.visibility : Icons.visibility_off,
            ),
            onPressed: () {
              setState(() {
                obscureText = !obscureText;
              });
            },
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        ),
      ),
    );
  }
 
   
}
