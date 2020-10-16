
import 'package:flutter/cupertino.dart';

import 'package:shared_preferences/shared_preferences.dart';

class SettingStore {
  getLanguage()async{
    final prefs=await SharedPreferences.getInstance();
    String lang=prefs.getString("lang");
    if(lang==null)
      lang="ar";
     print( "lang="+lang+"=" );
    return lang;
  }

  setLanguage() async{

    final prefs=await SharedPreferences.getInstance();
    final key="lang";
    print(  getLanguage());
    if(prefs.getString("lang")=="ar")
      prefs.setString(key, 'en');
    else
      prefs.setString(key,  "ar");

  }
    getDirection() async{
    var lang =  await getLanguage();
    if(lang=="ar")
      return  TextDirection.rtl;
    else
      return  TextDirection.ltr;

  }
}