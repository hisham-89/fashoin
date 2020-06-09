import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutterapp3/likes.dart';
import 'package:flutterapp3/general/colors.dart';
import 'package:flutterapp3/likes.dart';
import 'package:flutterapp3/myMessages1.dart';
import 'package:flutterapp3/notification.dart';
import 'package:flutterapp3/products/HomeScreen.dart';
import 'package:flutterapp3/products/ProductScreen.dart';
import 'package:flutterapp3/products/addEditProduct.dart';
import 'package:flutterapp3/products/category.dart';
//import 'package:flutterapp3/products/shop.dart';
import 'package:flutterapp3/products/shopScreen.dart';
import 'package:flutterapp3/products/shops.dart';
import 'package:flutterapp3/store/product.dart';
import 'package:flutterapp3/store/shop.dart';
import 'package:flutterapp3/store/user.dart';
import 'package:flutterapp3/user/login.dart';
import 'package:flutterapp3/user/profile.dart';
import 'package:flutterapp3/user/shopUserForm.dart';
import 'package:flutterapp3/user/welcomePage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:getflutter/getflutter.dart';

/// This Widget is the main application widget.
class Home extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 1;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    const IconData favorite = IconData(0xe87d, fontFamily: 'MaterialIcons');
    const IconData home = IconData(0xe8b6, fontFamily: 'MaterialIcons');
    const IconData notification = IconData(0xe7f4, fontFamily: 'MaterialIcons');
    return Scaffold(

//      body: Center(
//        child: _widgetOptions.elementAt(_selectedIndex),
//      ),
        body: Container(
            child:
            new IndexedStack(

              index: _selectedIndex,
              children: <Widget>[
                new Likes(),// User().getUser()!=null?new MyMessages():new LoginUser(),
                new HomeScreen() ,
                new NotificationsScreen(),
              ],
            )),
        bottomNavigationBar:
        Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child:
          BottomNavigationBar(

            selectedLabelStyle: TextStyle(color: MYColors.primaryColor()),

            items: const <BottomNavigationBarItem>[

              BottomNavigationBarItem(
                icon: Icon( favorite ,color: Colors.red ,size: 28 ),
                title: Text('' ),
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.home,size: 28),
                title: Text(''),
              ),
              BottomNavigationBarItem(
                icon: Icon( notification,size: 28 ),
                title: Text(''),
              ),
            ],
            currentIndex: _selectedIndex,backgroundColor: MYColors.grey1(),
            selectedItemColor: MYColors.primaryColor(),showSelectedLabels: false,showUnselectedLabels: false,
            onTap: _onItemTapped,
          ),
        ));
  }
}