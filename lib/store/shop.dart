import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutterapp3/config/auth-header.dart';
import 'package:flutterapp3/config/url.dart';
import 'package:flutterapp3/general/ganeral.dart';
import 'package:flutterapp3/store/user.dart';
import 'package:http/http.dart' as http;
class Shop {
  var user=new User();
  final content;
  Shop({this.content });

  factory Shop.fromJson(Map<String, dynamic> json) {
    return Shop(
      content: json['content'],
    );
  }
  uploadShopImages(id,data)async{
    var url = baseUrl+'shops/'+id+'/uploadImage';
    var response = await http.post(url,headers: {"Content-Type": "application/json"}, body: json.encode(data));
   if((response.statusCode == 200)){
    var response1=jsonDecode( response.body);
    if (response1['success']){
      return response1['data']  ;
    }
   }

      return   0;
  }

  addShop (data,context) async{
    var url = baseUrl+'shops';
    var response = await http.post(url,headers: {"Content-Type": "application/json"}, body: json.encode(data));
    return  jsonDecode( response.body);
  }
  editShop (data,id,context) async{
    var url = baseUrl+'shops/'+id;
    var response = await http.put(url,headers: {"Content-Type": "application/json"}, body: json.encode(data));

    return  jsonDecode( response.body);
  }

  getShop( id) async{

    var url = baseUrl+'shops/'+id;
    debugPrint(url);
    var header=new General().authHeader();
    var response = await http.get(url,headers: header );
    var response1=jsonDecode( response.body);
    if (response1['success']){
      return response1['data']  ;
    }

    else
      return   0;

  }

  getShops ( isMyShops,{searchByName,page}) async{
      user.init();
    page!=null?page:1;
    var user_id=user.getUserId();
    String url;
    if(isMyShops!=null&&isMyShops){
      url = baseUrl+'shops?search=user_id:$user_id&page=$page';
    }
    else if (searchByName!=null){
      url = baseUrl+'shops?search=$searchByName&searchFields=name:like&page=$page';
    }
    else
         url = baseUrl+'shops?page=$page';
    var header= await new General().authHeader();
    debugPrint(url  );
    var response = await http.get(url,headers: header );

    if(response.statusCode==200){
      print(response.body );
      var response1=jsonDecode( response.body);

      if (response1['success']){
      return response1   ;
    }}

    else
      return   0;
  }
}