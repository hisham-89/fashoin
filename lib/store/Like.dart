import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutterapp3/config/url.dart';
import 'package:flutterapp3/general/ganeral.dart';

class Like{

  likeProduct( data,isliked,followId) async{

      var url = baseUrl+'likes';
      var header=new General().authHeader();
      var response;
      if (!isliked)
          response = await http.post(url,headers:header, body: json.encode(data));
      else
        {
          url=url+"/"+followId;
          response = await http.delete(url,headers:header,);
        }
     // print();
      var response1=jsonDecode( response.body);
      if (response1['success']){
        return response1['data']  ;
      }

      else
        return   [];
    }

}