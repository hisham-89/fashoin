import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutterapp3/config/auth-header.dart';
import 'package:flutterapp3/config/url.dart';
import 'package:flutterapp3/general/ganeral.dart';
import 'package:flutterapp3/store/user.dart';
import 'package:http/http.dart' as http;
class Product {

  final content;
  Product({this.content });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      content: json['content'],
    );
  }
  addProduct (data,context) async{
    var url = baseUrl+'products';

    var response = await http.post(url,headers: {"Content-Type": "application/json"}, body: json.encode(data));
    var a=1;

    return  jsonDecode( response.body);
  }
  getColors ( ) async{
    var url = baseUrl+'colors';
    var header=new General().authHeader();

    var response = await http.get(url,headers: header );

    var response1=jsonDecode( response.body);
    if (response1['success']){
      return response1['data']  ;
    }

    else
      return   [];
  }

  getProductsDetails( id) async{

    var url = baseUrl+'products/getReplies?parent_id='+id;
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
  getProducts ( isMyProducts) async{


    var user_id=User().getUserId();
    String url;
    if(isMyProducts){
      url = baseUrl+'products?search=user_id:$user_id';
    }
    else
         url = baseUrl+'products';
    var header=new General().authHeader();
    debugPrint(url+'isMyProducts');
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