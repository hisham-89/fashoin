import 'package:flutter/material.dart';
import 'package:flutterapp3/general/colors.dart';
import 'package:flutterapp3/home.dart';
import 'package:flutterapp3/products/homeScreen.dart';
import 'package:flutterapp3/store/user.dart';
import 'package:flutterapp3/user/login.dart';
import 'package:flutterapp3/user/welcomePage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:developer';
void main() => runApp(
    MaterialApp(
      theme: ThemeData(   primaryColor:     MYColors.primaryColor(),textTheme: TextTheme(
        body1:  GoogleFonts.tajawal(fontStyle: FontStyle.normal   ),
      ),
      ),
      home: new User().getUser()!=null?  HomeScreen ():WelcomePage(),
      initialRoute: '/',

    )
);

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(   theme: ThemeData(  textTheme: TextTheme(
      headline: GoogleFonts.tajawal(fontStyle: FontStyle.normal ,fontWeight: FontWeight.w700 ),
      title: GoogleFonts.tajawal(fontStyle: FontStyle.normal ,fontWeight: FontWeight.w700 ),
      body1:  GoogleFonts.tajawal(fontStyle: FontStyle.normal   ),

    ),
    ),
        home: Scaffold(
            appBar: AppBar(title: Text('User Login')),
            body: Center(
                child: LoginPage()
            )
        )
    );
  }
}


class ProfileScreen extends StatelessWidget {

// Creating String Var to Hold sent Email.
  final String email;

// Receiving Email using Constructor.
  ProfileScreen({Key key, @required this.email}) : super(key: key);

// User Logout Function.
  logout(BuildContext context){

    Navigator.pop(context);

  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        home: Scaffold(
            appBar: AppBar(title: Text('Profile Screen'),
                automaticallyImplyLeading: false),
            body: Center(
                child: Column(children: <Widget>[
                  Container(
                      width: 280,
                      padding: EdgeInsets.all(10.0),
                      child: Text('Email = ' + '\n' + email,
                          style: TextStyle(fontSize: 20))
                  ),

                  RaisedButton(
                    onPressed: () {
                      logout(context);
                    },
                    color: Colors.red,
                    textColor: Colors.white,
                    child: Text('Click Here To Logout'),
                  ),

                ],)
            )
        )
    );
  }
}