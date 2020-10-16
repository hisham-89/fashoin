import 'package:flutter/material.dart';
import 'package:flutterapp3/general/colors.dart';
import 'package:google_fonts/google_fonts.dart';

class Styles{
  static String lang;
  Styles( lan){
    lang=lan;
  }
  leftRight(){
    if (lang=="ar")
      return "right";
    else
      return "left";
  }
  var  headerText=lang=="ar"?TextStyle(fontSize: 25,color:  Colors.black,fontWeight: FontWeight.bold ):TextStyle(fontSize: 29,color: MYColors.fontGrey(),fontWeight: FontWeight.bold );
  var  headerText2=lang=="ar"?TextStyle(fontSize: 20,color: MYColors.grey(),fontWeight: FontWeight.bold ):TextStyle(fontSize: 22,color: MYColors.grey(),fontWeight: FontWeight.bold );
  var  headerText3=lang=="ar"?TextStyle(fontSize: 20,color: MYColors.fontGrey(),fontWeight: FontWeight.bold ):TextStyle(fontSize: 22,color: MYColors.fontGrey(),fontWeight: FontWeight.bold );

  var  subHeaderText=GoogleFonts.tajawal(fontStyle: FontStyle.normal , fontSize: 18,color: MYColors.grey() ,);
  var  subHeaderText5=GoogleFonts.tajawal(fontStyle: FontStyle.normal , fontSize: 17,color: MYColors.fontGrey() ,);
  var  subHeaderText2=GoogleFonts.tajawal(fontStyle: FontStyle.normal , fontSize: 18,fontWeight: FontWeight.bold,color: MYColors.grey() ,);
  var  subHeaderText1=GoogleFonts.tajawal(fontStyle: FontStyle.normal , fontSize: 18,color: MYColors.green() ,);
  var  subHeaderText6=GoogleFonts.tajawal(fontStyle: FontStyle.normal , fontSize: 18,color: MYColors.green() ,fontWeight: FontWeight.bold );

  var  subHeaderText4=GoogleFonts.tajawal(fontStyle: FontStyle.normal , fontSize: 15,color: MYColors.grey2() ,);
  var  subHeaderText7=GoogleFonts.tajawal(fontStyle: FontStyle.normal , fontSize: 13,color: MYColors.primaryColor() ,);
  var  subHeaderText3=GoogleFonts.tajawal(color: MYColors.grey(),fontSize: 16,fontWeight: FontWeight.bold);
  var  subHeaderText8=GoogleFonts.tajawal(color: MYColors.grey(),fontSize: 16 );
  var  LoginText=lang=="ar"?TextStyle(fontSize: 19,color: MYColors.grey()):TextStyle(fontSize: 23,color: MYColors.fontGrey());
  var  DrawerText=lang=="ar"?TextStyle(fontSize: 19,color: MYColors.fontGrey()):TextStyle(fontSize: 18,color: MYColors.fontGrey());
  var  newServiceText=lang=="ar"?  GoogleFonts.tajawal(fontStyle: FontStyle.normal , fontSize: 20 ,color: Colors.white,)
      :  GoogleFonts.tajawal(fontStyle: FontStyle.normal , fontSize: 19,color: Colors.white);
  var  newServiceTextPackage=lang=="ar"?  GoogleFonts.tajawal(fontStyle: FontStyle.normal , fontSize: 15 ,color: Colors.white,)
      :  GoogleFonts.tajawal(fontStyle: FontStyle.normal , fontSize: 16,color: Colors.white);


  var  font14=lang=="ar"?  GoogleFonts.tajawal(fontStyle: FontStyle.normal , fontSize: 14 ,color: Colors.white,)
      :  GoogleFonts.tajawal(fontStyle: FontStyle.normal , fontSize: 13,color: Colors.white);
  var  newLoginText2=lang=="ar"?TextStyle(fontSize: 22,color: MYColors.fontGrey() ):TextStyle(fontSize: 18 ,color: MYColors.fontGrey() );
  var hintStyle=  GoogleFonts.tajawal(fontStyle: FontStyle.normal , color: MYColors.fontGrey() ,);
  var BorderPhone=lang=="ar"?BorderRadius.only( topRight: Radius.circular(20)
      ,bottomRight: Radius.circular(20)
  ) :BorderRadius.only( topLeft: Radius.circular(20)
      ,bottomLeft: Radius.circular(20)
  );
  var   textDirection=lang=="ar"?TextDirection.rtl:TextDirection.ltr;
  var   textDirectionReverse=lang=="ar"?TextDirection.ltr:TextDirection.rtl;

  var topAlignment= lang=="ar"?Alignment.topRight: Alignment.topLeft;
  var floatButtonAlimgment= lang=="ar"?Alignment.bottomRight:Alignment.bottomLeft;

  var compnayName =lang=="ar"?TextStyle(fontSize: 17,color: MYColors.grey() ):TextStyle(fontSize: 18 ,color: MYColors.grey() );
}