

import 'package:flutterapp3/general/toast.dart';
import 'package:flutterapp3/general/translator.dart';

class Validate {
  String msg="";
  AppTranslations App;
  bool required=true;
  int length=2;
  Validate(this.msg,{this.App,this.required=true ,this.length =2});
  String validateCheckCode(value){

    if (value.isEmpty){
      MyToast (this.msg);
      return "";
    }
    return null;
  }
  String validatePassword(value){

    if (value.length<6){
      MyToast (this.msg);
      return "";
    }
    return null;
  }
  bool validateCheckbox(value){

    if (!value ){
      MyToast (this.msg);
      return false;
    }
    return true;
  }
  String validateEmail (String value){
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern);
    print("required $required");
   if(  (required  ) ||( value!='' && !required))
    if (!regex.hasMatch(value))
      {  MyToast (App.text("Enter a valid email") );
      return '';}
    else
      return null;
  }
  String validateName(value){
    if(  required ||( value!='' && !required))
     if (value.length<length){

       MyToast (msg==null?App.text("Enter a valid name") :msg);
      return "";
    }
    return null;
  }
  bool isNumeric(String s) {
    if(s == null) {
      return false;
    }

    // TODO according to DartDoc num.parse() includes both (double.parse and int.parse)
    return double.parse(s, (e) => null) != null ||
        int.parse(s, onError: (e) => null) != null;
  }
  String validateNumber(String value){

        if (  !isNumeric( value)){

          MyToast (msg==null?App.text( "Enter a valid number") :msg);
      return "";
    }
    return null;

  }
  String validatePhone(String value){
    if (value.isEmpty){
      MyToast (  App.text("Enter a valid number"));

      return "";
                 }
    return null;

  }
}