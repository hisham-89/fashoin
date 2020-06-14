import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressDialogPrimary extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery
        .of(context)
        .platformBrightness == Brightness.light;

    return Container(
      child: Center(
        child: CircularProgressIndicator(
         // valueColor: new AlwaysStoppedAnimation<Color>(AppColors.themeColorSecondary),
        ),
      ),
      color: brightness ?  Colors.white.withOpacity(
          0.70) : Colors.black.withOpacity(
          0.70), // this is the main reason of transparency at next screen. I am ignoring rest implementation but what i have achieved is you can see.
    );
  }
}