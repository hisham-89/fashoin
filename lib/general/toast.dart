
import 'package:fluttertoast/fluttertoast.dart';

import 'colors.dart';


class MyToast {

  MyToast(msg,{color,gravity}){

      Fluttertoast.showToast(
          msg:  msg,
          toastLength: Toast.LENGTH_SHORT,
          gravity: gravity==null ?ToastGravity.BOTTOM:gravity,
          timeInSecForIosWeb: 1,
          backgroundColor: color==null ? MYColors.grey():color,
          //textColor: Colors.white,
          fontSize: 16.0
      );
  }
}