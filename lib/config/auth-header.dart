import 'package:flutterapp3/store/user.dart';
import 'package:localstorage/localstorage.dart';
//var user=new User();
var authHeader={ 'Authorization': 'Bearer ' + new User().getUser() ,'Content-Type': 'application/json' };