import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutterapp3/likes.dart';
import 'package:flutterapp3/general/colors.dart';
import 'package:flutterapp3/likes.dart';
import 'package:flutterapp3/myMessages1.dart';
import 'package:flutterapp3/notification.dart';
import 'package:flutterapp3/products/homeScreen.dart';
import 'package:flutterapp3/products/productScreen.dart';
import 'package:flutterapp3/products/addEditProduct.dart';
import 'package:flutterapp3/products/category.dart';
import 'package:flutterapp3/products/myFollwingPage.dart';
//import 'package:flutterapp3/products/shop.dart';
import 'package:flutterapp3/products/shopScreen.dart';
import 'package:flutterapp3/products/shops.dart';
import 'package:flutterapp3/store/product.dart';
import 'package:flutterapp3/store/shop.dart';
import 'package:flutterapp3/store/user.dart';
import 'package:flutterapp3/user/login.dart';
import 'package:flutterapp3/user/profile.dart';
import 'package:flutterapp3/products/shopUserForm.dart';
import 'package:flutterapp3/user/welcomePage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:getflutter/getflutter.dart';

/// This Widget is the main application widget.
//class Home extends StatelessWidget {
//  static const String _title = 'Flutter Code Sample';
//
//  @override
//  Widget build(BuildContext context) {
//    return MaterialApp(
//      theme: ThemeData(   primaryColor:     MYColors.primaryColor(),textTheme: TextTheme(
//        body1:  GoogleFonts.tajawal(fontStyle: FontStyle.normal   ),
//      ),
//      ),
//      title: _title,
//      home: MyStatefulWidget(),
//    );
//  }
//}

class Home extends StatefulWidget {
  Home({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<Home> {
  int _selectedIndex = 2;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  Future<bool> _onBackPressed( ) async{
    debugPrint('dddddddddddddddddd');
    if(_selectedIndex!=2)
    setState(() {
      _selectedIndex = 2;
    });
    else{
     Navigator.pop(context);
     exit(0);}
  }
  @override
  Widget build(BuildContext context) {
    const IconData favorite = IconData(0xe87d, fontFamily: 'MaterialIcons');
    const IconData home = IconData(0xe8b6, fontFamily: 'MaterialIcons');
    const IconData notification = IconData(0xe7f4, fontFamily: 'MaterialIcons');
    return new  WillPopScope(  onWillPop:  _onBackPressed ,
        child:
      Scaffold(
//      body: Center(
//        child: _widgetOptions.elementAt(_selectedIndex),
//      ),
        body: Container(
            child:
            new IndexedStack(

              index: _selectedIndex,
              children: <Widget>[
                new Likes(),// User().getUser()!=null?new MyMessages():new LoginUser(),
                new Shops(isMyShops: false ) ,
                new HomeScreen() ,
                new MyFollwingPageScreen(),
                new Profile( ) ,
              //  new NotificationsScreen(),
              ],
            )),
        bottomNavigationBar:
        Container(
          decoration: BoxDecoration(color: MYColors.primaryColor() ,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 3,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child:
          BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            selectedLabelStyle: TextStyle(color: MYColors.primaryColor()),
            items: const <BottomNavigationBarItem>[

              BottomNavigationBarItem(
                icon: Icon( favorite  ,size: 25 ),
                title: Text('Likes' ),
              ),
              BottomNavigationBarItem(
                icon: Icon( Icons.store  ,size: 25 ),
                title: Text('Shops' ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home,size: 25),
                title: Text('Home'),
              ),

              BottomNavigationBarItem(
                icon: Icon( Icons.thumb_up,size: 25 ),
                title: Text('Following'),
              ),
              BottomNavigationBarItem(
                icon: Icon( Icons.supervised_user_circle  ,size: 25 ),
                title: Text('Account' ),
              ),
            ],
            currentIndex: _selectedIndex,backgroundColor: MYColors.grey1(),
            selectedItemColor: MYColors.primaryColor(),
            showSelectedLabels: true,
            showUnselectedLabels: true,
            onTap: _onItemTapped,
          ),
        )));
  }
}