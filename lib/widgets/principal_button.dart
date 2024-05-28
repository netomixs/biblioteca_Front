import 'package:flutter/material.dart';

import '../utils/app_color.dart';

class PrincipalButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final double borderRadius;
  final double fontSize;
  final bool isload;
  const PrincipalButton(
      {super.key,
      required this.text,
      required this.onPressed,
      this.color = const Color.fromARGB(255, 0, 68, 255),
      this.textColor = Colors.white,
      this.borderRadius = 20.0,
      this.fontSize = 16,
      required this.isload});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(10),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            //padding: const EdgeInsets.only(left: 50,top: 20,bottom: 20,right: 50),
            minimumSize: const Size(200, 50),
            //backgroundColor: color,
            foregroundColor: textColor,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          onPressed: isload ? null : onPressed,
          child: isload
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                )
              : Text(text, style: TextStyle(fontSize: fontSize)),
        ),
      ),
    );
  }
}
