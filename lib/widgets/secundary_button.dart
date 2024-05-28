import 'package:flutter/material.dart';

import '../utils/app_color.dart';

class SecondarylButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color color;
  final Color textColor;
  final double borderRadius;
  final double fontSize;
  const SecondarylButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.color = AppColors.buttonPrimaryColor,
    this.textColor = Colors.white,
    this.borderRadius = 20.0,
    this.fontSize=16
  });
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
            backgroundColor: AppColors.buttonSecondColor,
            //foregroundColor: Colors.black,

            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(borderRadius),
            ),
          ),
          onPressed: onPressed,
          child: Text(text,
          style: TextStyle(
            fontSize:fontSize 
          )),
        ),
      ),
    );
  }
}
