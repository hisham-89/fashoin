import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutterapp3/config/auth-header.dart';
import 'package:flutterapp3/config/url.dart';
import 'package:flutterapp3/general/ganeral.dart';
import 'package:flutterapp3/store/user.dart';
import 'package:http/http.dart' as http;
class Shop {

  final content;
  Shop({this.content });

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      content: json['content'],
    );
  }
  addShop (data,context) async{
    var url = baseUrl+'shops';

    var response = await http.post(url,headers: {"Content-Type": "application/json"}, body: json.encode(data));
    var a=1;

    return  jsonDecode( response.body);
  }
  getShop( id) async{

    var url = baseUrl+'shops/'+id;
    var header=new General().authHeader();
    var response = await http.post(url,headers: header );
    var response1=jsonDecode( response.body);

    if (response1['success']){
      debugPrint( url);
      return response1['data']  ;
    }

    else
      return   0;

  }
  getShops ( isMyShops) async{


    var user_id=User().getUserId();
    String url;
    if(isMyShops){
      url = baseUrl+'shops?search=user_id:$user_id';
    }
    else
         url = baseUrl+'shops';
    var header=new General().authHeader();
    debugPrint(url+'isMyShops');
    var response = await http.get(url,headers: header );

    var response1=jsonDecode( response.body);
    if (response1['success']){
      print(response1['success']);
      return response1['data']  ;
    }

    else
      return   0;
  }
}