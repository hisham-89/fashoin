
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp3/general/Styles.dart';
import 'package:flutterapp3/general/colors.dart';
import 'package:flutterapp3/general/ganeral.dart';
import 'package:flutterapp3/service/requestService.dart';

class MyFloatingActionButton{



 Widget get( lang ,title ,context) {
    return
      (
          Align(  alignment:lang=="ar"?Alignment.bottomRight:Alignment.bottomLeft ,
          child: Container( width: 200, height: 55 ,
              padding: EdgeInsets.only(right: 5,left: 5 ),
              margin: EdgeInsets.symmetric(horizontal:40,vertical: 5),

          child:
          FlatButton(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(33.0),side: BorderSide(width: 4,color: MYColors.green1())
              // side: BorderSide(color: Colors.red)
            ),
            color: MYColors.green(),
            textColor: Colors.white,
            padding: EdgeInsets.only(left: 1,bottom: 5,top: 0,right: 1),
            onPressed: () { General.pushRoute(context, RequestService ());},
            child:
            ListTile(
              title: Align(alignment: Alignment(lang=="ar"?3:-5,0),
                  child: Text(
                title  ,
                style:  Styles(lang).newServiceText  ,
              )  ),
              contentPadding: EdgeInsets.symmetric(horizontal: lang=="ar"?13:3,vertical: 0),
              leading: Icon(Icons.add,color: Colors.white,size: 34,),
            )
          ,
          ))
      )

//       , child: FloatingActionButton(
//            backgroundColor:MYColors.green(),
//            onPressed: (){},
//            child:
//            Icon(Icons.add ,color: MYColors.primaryColor(),),)

        // Image.asset("assets/images/facebook.png")

   );


  }

}