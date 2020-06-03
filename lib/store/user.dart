import 'dart:convert';
import 'dart:developer';
import 'dart:io';
 import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp3/config/url.dart';
import 'package:flutterapp3/general/ganeral.dart';
import 'package:flutterapp3/home.dart';
import 'package:flutterapp3/likes.dart';
import 'package:http/http.dart' as http;
import 'package:localstorage/localstorage.dart';
class User {
  var storage = new LocalStorage('todo_app');

  BuildContext get context => null;
   isLogedIn(){
     if (getUser()==null)
       {
         return false;
       }
     return true;
   }
  getUser()
  {
    var user=storage.getItem('user')  ;
    return user;
  }
    getUserId()
  {
    var user=storage.getItem('user')  ;
    return user!=null?user['id']:null;
   }

  Future<String>   _getDeviceId()  async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    if ( Platform.isIOS) {
      IosDeviceInfo iosDeviceInfo = await deviceInfo.iosInfo;
      return iosDeviceInfo.identifierForVendor; // unique ID on iOS
    }
    else {
      AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;
      return androidDeviceInfo.id; // unique ID on Android
    }
  }
  login (data) async{
   // SERVER LOGIN API URL
    var url = baseUrl+'login';
    String device_id= await _getDeviceId();
    data['device_id']=device_id;

    // Starting Web API Call.
    var response = await http.post(url,headers: {"Content-Type": "application/json"}, body: json.encode(data));
    log('data: $response');
    // Getting Server response into variable.
     var bodyContent = json.decode(response.body);
    if(bodyContent['succes'] ){
       storage.setItem('user', bodyContent['data']);
    }
     return bodyContent;
  }
  register (data,context) async{
    var url = baseUrl+'register';

    var response = await http.post(url,headers: {"Content-Type": "application/json"}, body: json.encode(data));
    var a=1;

    return  jsonDecode( response.body);
  }
  logout (context )  async{
     Navigator.of(context).pop();
    storage.clear( );
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomeWidget( ))
    );
    var url = baseUrl+'logout';
    String device_id= await _getDeviceId();
    var data;
    data={'device_id':device_id} ;
    var header=new General().authHeader();
    var response = await http.post(url,headers: header , body: json.encode(data));
    log("loooooooooooooooogut:$response");
    var bodyContent = json.decode(response.body);

    if(bodyContent['succes'] ){
      storage.clear( );
      Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => HomeWidget( ))
      );
    }
    return  jsonDecode( response.body);
  }
}