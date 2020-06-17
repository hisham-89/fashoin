
import 'dart:convert';

import 'package:flutterapp3/config/url.dart';
import 'package:flutterapp3/general/ganeral.dart';
import 'package:http/http.dart' as http;
class BaseStore {
  dynamic store;
  BaseStore(this.store);
  delete(id) async{
   // store.delete(id);
    var url =  store.url+'/'+id;
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