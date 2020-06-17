import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:flutterapp3/store/user.dart';
import 'package:http/http.dart' as http;
import 'package:flutterapp3/config/url.dart';
import 'package:flutterapp3/general/ganeral.dart';

class Like{

  likeProduct( data,isliked,productId) async{

      var url = baseUrl+'likes';
      var header=new General().authHeader();
      var response;
      if (  isliked)
          response = await http.post(url,headers:header, body: json.encode(data));
      else
        {
          url=url+"/"+productId;
        //  response = await http.delete(url,headers:header, body: json.encode(data));
           response = await http.delete(url,headers:header,);
        }
       debugPrint(url);
      var response1=jsonDecode( response.body);
      if (response1['success']){
        return response1['data']  ;
      }

      else
        return   [];
    }
  getMyLikes() async{

    var url = baseUrl+'users/'+User().getUserId()+'?with=likes';
    var header=new General().authHeader();
    debugPrint(url);
    var response = await http.get(url,headers: header );
    var response1=jsonDecode( response.body);
    if (response1['success']){
      return response1['data'] ['likes'] ;
    }

    else
      return   0;
  }

}