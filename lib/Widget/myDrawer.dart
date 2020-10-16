import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:flutterapp3/general/Styles.dart';
import 'package:flutterapp3/general/colors.dart';
import 'package:flutterapp3/general/ganeral.dart';
import 'package:flutterapp3/general/mediaQuery.dart';
import 'package:flutterapp3/general/translator.dart';
import 'package:flutterapp3/home.dart';
import 'package:flutterapp3/main.dart';
import 'package:flutterapp3/pages/about.dart';

import 'package:flutterapp3/products/shopUserForm.dart';
import 'package:flutterapp3/products/shops.dart';

import 'package:flutterapp3/store/setting.dart';
import 'package:flutterapp3/store/user.dart';
import 'package:flutterapp3/user/login.dart';
import 'package:flutterapp3/user/profile.dart';
import 'package:flutterapp3/user/setting.dart';
import 'package:flutterapp3/user/welcomePage.dart';
import 'package:share/share.dart';

class MyDrawer extends StatefulWidget{


  @override
   MyDrawerState createState()  => new MyDrawerState();

}
class MyDrawerState extends State<MyDrawer> {

  AppTranslations AppTrans = null;
  var lang = null;
  String username;
  static User user=new User();
  bool visible=true;    int _page = 0;
  List drawerItems = [
  ];
  initData() async{
    var lan = await SettingStore().getLanguage();
    await user.init();

    setState(() {
      lang=lan;
        drawerItems = [
        {
          "icon": Icons.add,
          "name": "New Shop",
          'route':ShopUserFormScreen()
        },
        {
          "icon": Icons.store,
          "name": "My Shops",
          'route':Shops(isMyShops: true )
        },
        {
          "icon": Icons.supervised_user_circle,
          "name":user.isLogedIn()? "My Account" :"Login",
          "route":user.isLogedIn()?Profile() :LoginPage(),
        },
        {
          "icon": Icons.settings,
          "name": "Setting",
          "route":Setting()
        },
        {
          "icon": Icons.language,
          "name": "Change language",
          "route":MyApp()
        },

        {
          "icon": Icons.info,
          "name": "About Us",
          "route":About()
        },
          user.isLogedIn()? {
          "icon": Icons.exit_to_app,
          "name": "Logout",

        }:{
          "name": "",},
      ];



      var phone=  user.getUser(value: "phone");
      var name=  user.getUser(value: lang=="en"?"name":"name_ar");
      username=name!=null?name:phone!=null?phone:"";
      AppTrans=new AppTranslations(lang);
      AppTrans.load(lang);
      visible=false;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initData();
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return !visible? ClipRRect(
        borderRadius: BorderRadius.only(
          topRight:    lang=="en"? Radius.circular(40): Radius.circular(0),
          bottomRight: lang=="en"? Radius.circular(40) : Radius.circular(0),
          topLeft:    lang=="ar"? Radius.circular(40):  Radius.circular(0),
          bottomLeft: lang=="ar"? Radius.circular(40) : Radius.circular(0),
        ),
        child:
         Drawer(
          child:Container(
         //  decoration: BoxDecoration(borderRadius: BorderRadius.only(topLeft: Radius.circular(20)),color:  Colors.white,),
           child: ListView(
            children: <Widget>[
              DrawerHeader(decoration: BoxDecoration(color: Colors.black),
                  child:
                  Column(crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(   "Fashion" ,
                          style: TextStyle(fontSize: 23,
                              color:  MYColors.primaryColor()
                          ),
                        ),
                        Container( decoration: BoxDecoration(color: Colors.black),
                          child: Image(image:AssetImage("assets/images/fashionLogo.jpeg"),width:100,),
                        ),

                      ]
                  )
              ),
              SizedBox(height: 20,),
              Container(color: Colors.white , child:
              ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: drawerItems.length,
                itemBuilder: (BuildContext context, int index) {
                  Map item = drawerItems[index];
                  return ListTile(
                    leading: Icon(
                      item['icon'],
                      color: _page == index
                          ?Theme.of(context).primaryColor
                          :Theme.of(context).textTheme.title.color,
                    ),
                    title:  Text(
                      AppTrans.text( AppTrans.text(item['name']) ),
                      style:   Styles(lang).DrawerText
                      ,
                    ),
                    onTap: () async {
                      //  _pageController.jumpToPage(index);
                      Navigator.of(context).pop();
                      if(item['name']=='Logout')
                        User().logout(context);
                      else if(item['name']=='Change language')
                      { await SettingStore().setLanguage();
                      //Navigator.of(context).pop();
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) =>  item['route']));
                      }
                      else
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) =>  item['route'])
                        );
                    },
                  );
                },

              ),
              ),

              SizedBox(height: 40,),
              Center(child: Container(child: Text("Developed By",style: Styles(lang).subHeaderText7,),),),
              SizedBox(height: 3,),
              Center(child: Container(child: Text("Hisham" ,
                style: TextStyle(color: MYColors.grey(),fontSize: 13),),),),
              SizedBox(height:20,),
            ],
          ) ),
    )
    ):Container();
  }

}