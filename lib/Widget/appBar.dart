import 'package:flutter/material.dart';
import 'package:flutterapp3/general/colors.dart';
import 'package:flutterapp3/general/ganeral.dart';
import 'package:flutterapp3/home.dart';
import 'package:flutterapp3/notification.dart';
import 'package:flutterapp3/products/searchScreen.dart';
import 'package:flutterapp3/user/profile.dart';
import 'package:google_fonts/google_fonts.dart';


class MyAppBar   {
  @override
  static getAppBar(  context,_scaffoldKey ,{title} ) {
    // TODO: implement build
    return   AppBar(
      titleSpacing: 0,
      title:  Text( title==null? 'Fashion':title  ,
          style:  GoogleFonts.tajawal( color: Colors.white,fontSize: 28) ),
      iconTheme: new IconThemeData(color: Colors.white),
      backgroundColor:MYColors.primaryColor(),
      actions: <Widget>[Padding(
        child:  GestureDetector(onTap: (){  Navigator.of(context).push(
            MaterialPageRoute(builder: (context) =>  SearchScreen())
        );},  child: Icon(Icons.search,size: 25,color: Colors.white,) ),padding: EdgeInsets.only(left: 15,right: 5),)
        ,
        Padding(
            child: GestureDetector(onTap: (){  Navigator.of(context).push(
                MaterialPageRoute(builder: (context) =>  NotificationsScreen())
            );},  child: Icon(Icons.notifications,size: 25,color: Colors.white,) ),padding: EdgeInsets.only(left: 15,right: 15))
      ],
    ) ;
  }


}