
import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:flutterapp3/config/url.dart';
import 'package:flutterapp3/general/ganeral.dart';

class Category{

  getShopsCategories (is_shop_category ) async{

    var url = baseUrl+'categories?search=is_shop_category:$is_shop_category';

    var header=new General().authHeader();

    var response = await http.get(url,headers: header );

    var response1=jsonDecode( response.body);
    if (response1['success']){
      return response1['data']  ;
    }

    else
      return   [];
  }
}