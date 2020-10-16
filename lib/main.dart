import 'package:flutter/material.dart';
import 'package:flutterapp3/general/Loading.dart';
import 'package:flutterapp3/general/colors.dart';
import 'package:flutterapp3/general/translator.dart';
import 'package:flutterapp3/home.dart';
import 'package:flutterapp3/products/homeScreen.dart';
import 'package:flutterapp3/store/setting.dart';
import 'package:flutterapp3/store/user.dart';
import 'package:flutterapp3/user/login.dart';
import 'package:flutterapp3/user/welcomePage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:developer';

import 'package:provider/provider.dart';
void main() => runApp(
    ChangeNotifierProvider(
      create: (context)=>AppTranslations("ar"),
     child:
    MaterialApp(
      theme: ThemeData(   primaryColor:     MYColors.primaryColor(),textTheme: TextTheme(
        body1:  GoogleFonts.tajawal(fontStyle: FontStyle.normal   ),
      ),
      ),
      home:  MyApp(),
      initialRoute: '/',

    ))
);

class MyApp extends StatefulWidget {
  @override
  MyAppState createState()  =>new MyAppState();}

class MyAppState extends State<MyApp> {
  bool visible=true;
  String lang="ar";
  TextDirection dir ;
  AppTranslations AppTrans=null;
  User user=new User();
  getDirection() async{
    var direction= await SettingStore().getDirection();
    var lan = await SettingStore().getLanguage();
    user.init();
    setState(() {
      dir =direction;
      AppTrans=new AppTranslations(lang);
    //  AppTrans.load(lang);
      visible=false;
    });
    print(dir);
  }
  @override
  Widget build(BuildContext context) {
    return

      !visible?MaterialApp(
        theme: ThemeData(  textTheme: TextTheme(
          headline: GoogleFonts.tajawal(fontStyle: FontStyle.normal ,fontWeight: FontWeight.w700 ),
          title: GoogleFonts.tajawal(fontStyle: FontStyle.normal ,fontWeight: FontWeight.w700 ),
          body1:  GoogleFonts.tajawal(fontStyle: FontStyle.normal   ),
          body2:  GoogleFonts.tajawal(fontStyle: FontStyle.normal   ),
          caption:  GoogleFonts.tajawal(fontStyle: FontStyle.normal   ),
          button:  GoogleFonts.tajawal(fontStyle: FontStyle.normal   ),
          subtitle: GoogleFonts.tajawal(fontStyle: FontStyle.normal   ),
          subhead: GoogleFonts.tajawal(fontStyle: FontStyle.normal   ),
          display1: GoogleFonts.tajawal(fontStyle: FontStyle.normal   ),

        ),
        ),
        home:     user.isLogedIn()  ?  Home ()  :WelcomePage(),
        builder: (context, child) {
          return Directionality(
            textDirection:  dir ,
            child: child,
          );
        },
      ) :ProgressDialogPrimary();
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getDirection();

  }
}
