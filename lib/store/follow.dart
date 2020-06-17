import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutterapp3/store/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutterapp3/config/url.dart';
import 'package:flutterapp3/general/ganeral.dart';

class Follow{
  final url= baseUrl+'followers';
  followShop( data,isliked,followId) async{

      var url = baseUrl+'followers';
      var header=new General().authHeader();
      var response;
      if (!isliked)
          response = await http.post(url,headers:header, body: json.encode(data));
      else
        {
          url=url+"/"+followId.toString();
          response = await http.delete(url,headers:header,);
        }
     // print();
      var response1=jsonDecode( response.body);
      if (response1['success']){
        return  [1] ;
      }
      else
        return   [];
    }
  getMyFollowingShops() async{

    var url = baseUrl+'users/'+User().getUserId()+'?with=following';
    var header=new General().authHeader();
    debugPrint(url);
    var response = await http.get(url,headers: header );
    var response1=jsonDecode( response.body);
    if (response1['success']){
      return response1['data'] ['following'] ;
    }

    else
      return   0;
  }


}