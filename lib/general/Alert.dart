
import 'package:flutter/material.dart';
import 'package:flutterapp3/general/Loading.dart';
import 'package:flutterapp3/general/colors.dart';
import 'package:flutterapp3/general/toast.dart';

class Alert{
 var context;
 var success;
 var msg;
 var route;
 Alert(this.context,this.success,this.msg) ;
  Alert1(){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(  success),
          actions: <Widget>[
            FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => route)
                );
              },
            ),
          ],
        );
      },
    );
  }

 Alert2Button(  AppTrans,func ,{attribute:null}){
   showGeneralDialog(
     barrierLabel: "Barrier",
     barrierDismissible: true,
     barrierColor: Colors.black.withOpacity(0.4),
     transitionDuration: Duration(milliseconds: 300),
     context: context,
     pageBuilder: (_, __, ___) {
       return
       AlertDialog(
         title: new Text(  AppTrans.text(msg) ),

         actions: <Widget>[

           FlatButton(color: MYColors.green(),textColor: Colors.white,
             child: new Text(AppTrans.text("OK")),
             onPressed: ()  {
               attribute==null? func():func(attribute) ;
               Navigator.of(context, rootNavigator: true).pop( );
             },
           ),  FlatButton(color: Colors.red,textColor: Colors.white,
             child: new Text(AppTrans.text("Cancel" )),
             onPressed: () {
               Navigator.of(context, rootNavigator: true).pop();

             },
           ),

         ],
       );
     },
     transitionBuilder: (_, anim, __, child) {
       return SlideTransition(
         position: Tween(begin: Offset(0, 1), end: Offset(0, 0)).animate(anim),
         child: child,
       );
     },
   );
 }
}