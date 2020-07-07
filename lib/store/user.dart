import 'dart:convert';
import 'dart:developer';
import 'dart:io';
 import 'package:device_info/device_info.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp3/config/url.dart';
import 'package:flutterapp3/general/ganeral.dart';
import 'package:flutterapp3/home.dart';
import 'package:flutterapp3/likes.dart';
import 'package:flutterapp3/products/homeScreen.dart';
import 'package:flutterapp3/user/welcomePage.dart';
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
   hasPermission(itemUserId)
   {
     if(itemUserId.toString()==getUserId())
       return true;
     else
       return false;
   }
  getUser()
  {
    var user=storage.getItem('user')  ;
    return user;
  }
    getUserId()
  {
    var user=storage.getItem('user')  ;
    return user!=null?user['id'].toString():null;
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
  loginByGoogle(_currentUser ) async{
    final http.Response response = await http.get(
      'https://people.googleapis.com/v1/people/me/connections'
          '?requestMask.includeField=person.names',
      headers: await _currentUser.authHeaders,
    );
    if (response.statusCode != 200) {
//      setState(() {
//        _contactText = "People API gave a ${response.statusCode} "
//            "response. Check logs for details.";
//      });
      //print('People API ${response.statusCode} response: ${respo_handleSignOutnse.body}');
      return;
    }
    final Map<String, dynamic> data = json.decode(response.body);
    return data;
  }

  loginBySocialAccount(data){

  }

  login (data,{isSocial}) async{
   // SERVER LOGIN API URL
    var url = baseUrl+'login';

    String device_id= await _getDeviceId();
    data['device_id']=device_id;
    if (isSocial!=null&&isSocial){
        url = baseUrl+'loginSocial';
    }
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
        MaterialPageRoute(builder: (context) => HomeScreen( ))
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
          MaterialPageRoute(builder: (context) => WelcomePage( ))
      );
    }
    return  jsonDecode( response.body);
  }
}