import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutterapp3/config/auth-header.dart';
import 'package:flutterapp3/config/url.dart';
import 'package:flutterapp3/general/ganeral.dart';
import 'package:flutterapp3/store/user.dart';
import 'package:http/http.dart' as http;
class Product {

  final content;
  final url= baseUrl+'products';
  Product({this.content });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      content: json['content'],
    );
  }
  getLikesCount(count){

    if(count==0||count==null){
      return "";
    }
    else if(   count/1000000  >=1 ){
      return (count/1000000).toString() +"M";
    }
    else if(   count/1000  >=1 ){
      return (count/1000).toString() +"K";
    }
    else{
      return count.toString();
    }
  }
  addProduct (data,context) async{
    var url = baseUrl+'products';

    var response = await http.post(url,headers: {"Content-Type": "application/json"}, body: json.encode(data));
    var a=1;

    return  jsonDecode( response.body);
  }
  editProduct (data,id,context) async{
    var url = baseUrl+'products/'+id;
     debugPrint('ffff');
    var response = await http.put(url,headers: {"Content-Type": "application/json"}, body: json.encode(data));
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

    var url = baseUrl+'products/'+id;
    var header=new General().authHeader();
    var response = await http.get(url,headers: header );
  debugPrint (url);
   if(response.statusCode==200){
   var response1=jsonDecode( response.body);

    if (response1['success']){
      debugPrint( url);
      return response1['data']  ;
    }
    else
      return   0;

  }
    return   0;
  }
  getProducts ( page,isMyProducts) async{


    var user_id=User().getUserId();
    String url;
    if(isMyProducts){
      url = baseUrl+'products?search=user_id:$user_id'+"&page="+page;
    }
    else
         url = baseUrl+'products?page='+page.toString();
    var header=new General().authHeader();
    debugPrint(url);
    var response = await http.get(url,headers: header );
    var response1;
   if (response.statusCode==200)
       response1=jsonDecode( response.body);
   else
     return 0;
    if (response1['success']){

      return response1   ;
    }

    else
      return   0;
  }
  delete ( id) async{

    var url = baseUrl+'products/'+id;
    var header=new General().authHeader();
    var response = await http.delete(url,headers: header );
    var response1=jsonDecode( response.body);

    if (response1['success']){

      return response1['data']  ;
    }
    else
      return   0;

  }
}