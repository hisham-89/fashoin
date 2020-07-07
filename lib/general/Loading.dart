import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ProgressDialogPrimary extends StatelessWidget {
  ProgressDialogPrimary({this.title});
  String title="ll";
  @override
  Widget build(BuildContext context) {
    var brightness = MediaQuery
        .of(context)
        .platformBrightness == Brightness.light;

    return Container(

      child: Center(
        child:Column(crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[ CircularProgressIndicator(
          // valueColor: new AlwaysStoppedAnimation<Color>(AppColors.themeColorSecondary),
        ),SizedBox (height: 10,),
             Text(title!=null?title:"" ,style: TextStyle(fontSize: 18),)],)
       ,
      ),
      color: brightness ?  Colors.white.withOpacity(
          0.70) : Colors.black.withOpacity(
          0.70), // this is the main reason of transparency at next screen. I am ignoring rest implementation but what i have achieved is you can see.

    );
  }
}