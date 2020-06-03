import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutterapp3/config/auth-header.dart';
import 'package:flutterapp3/config/url.dart';
import 'package:flutterapp3/general/ganeral.dart';
import 'package:http/http.dart' as http;
class Message {

  final content;
  Message({this.content });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      content: json['content'],
    );
  }
  sendMessage(messageDet,reply) async{
  //  if (reply)
     var url = baseUrl+'messages/sendReply';
   // var url = baseUrl+'messages/send';
    var header=new General().authHeader();
    var response = await http.post(url,headers: header , body: json.encode(messageDet));
    var response1=jsonDecode( response.body);
    debugPrint( 'sssssssssssss');
    if (response1['success']){

      debugPrint( url);

      return response1['data']  ;
    }

    else
      return   0;
  }
  getMessagesDetails( id) async{

    var url = baseUrl+'messages/getReplies?parent_id='+id;
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
  getMessages ( ) async{
    var url = baseUrl+'messages';
    var header=new General().authHeader();

    var response = await http.get(url,headers: header );

     var response1=jsonDecode( response.body);
     if (response1['success']){
       return response1['data']  ;
     }

     else
    return   0;
  }
}