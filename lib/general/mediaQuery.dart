

import 'package:flutter/cupertino.dart';
import 'package:flutterapp3/general/colors.dart';

class MyMediaQuery{


   height (context){
    return    MediaQuery.of( context ).size.height;

   }
   width (context){
     return    MediaQuery.of( context ).size.width;

   }
}