import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutterapp3/MessageDetails.dart';
import 'package:flutterapp3/config/url.dart';
import 'package:flutterapp3/general/colors.dart';
import 'package:flutterapp3/general/ganeral.dart';
import 'package:flutterapp3/products/category.dart';
import 'package:flutterapp3/store/message.dart';
import 'package:flutterapp3/store/user.dart';
import 'package:flutterapp3/user/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ShopScreen extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(   primaryColor:     MYColors.primaryColor(),textTheme: TextTheme(
        body1:  GoogleFonts.tajawal(fontStyle: FontStyle.normal   ),
      ),
      ),
      home: MyHomePage(title: 'Shop' ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>   with TickerProviderStateMixin {

  List data;
  List<Tab> tabList = List();
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    tabList.add(new Tab(text:'Info',));
    tabList.add(new Tab(text:'Products',));
    _tabController = new TabController( vsync: this, length:
    tabList.length);

  }
  // Function to get the JSON data
  Future<String> getJSONData() async {
    var response1;
    var message=new Message();
    //   response1= await message.getMessages(   );
    var header=new General().authHeader();

    var response = await http.get('https://jsonplaceholder.typicode.com/posts',headers: header );
    response1=jsonDecode( response.body);
    setState(() {
      // Get the JSON data
      data  = response1;
    });
    return "Successfull";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title,style: TextStyle(color: Colors.white), ),
        ),
        body:SingleChildScrollView(child:
        Container(   decoration: BoxDecoration(color: Colors.white,
        ),
          child:
          Column(
            children: <Widget>[
              cover(),
              tabs(),
            ],)
          , ),
        ));
  }
  Widget tabs(){
    var screenSize = MediaQuery.of(context).size.width;
    return (  new Container(
      width: screenSize,
      //   top: 210,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: new Column(mainAxisSize: MainAxisSize.max,
          children: <Widget>[
            new Container(
              decoration: new BoxDecoration(color:MYColors.grey2()),
              child: new TabBar(
                  controller: _tabController,
                  indicatorColor: Colors.pink,
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: tabList
              ),
            ),
            Container(
               height: 620.0,
              child:   TabBarView(
                controller: _tabController,
                children:  <Widget>[
                  Center(child: CategoryScreen(),) ,
                  CategoryScreen(),
                ],
              ),
            )
          ],
        ),
      ),
    ));
  }
  Widget cover() {
//    if (data == null)
//      this.getJSONData();
//    return

    return (
        Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                  child:Image.network("https://image.shutterstock.com/image-photo/beautiful-tender-girl-silk-top-600w-1081362410.jpg")
              ),
              Container(padding: EdgeInsets.fromLTRB (12,3,12,3), child:   Row(  mainAxisSize: MainAxisSize.max, children: <Widget>[
                CircleAvatar(  radius  : 30.0,
                  backgroundImage:NetworkImage("https://image.shutterstock.com/image-photo/beautiful-tender-girl-silk-top-600w-1081362410.jpg",

                  ) ,),
                Expanded (
                    child: Container( padding: EdgeInsets.all(10),
                        child:Text("Shop1 " ,textAlign: TextAlign.left, style: GoogleFonts.oswald( fontWeight:  FontWeight.bold, color: MYColors.fontGrey(),fontSize: 23),)))

                ,Container(   decoration: BoxDecoration(color: MYColors.grey1() ,borderRadius: BorderRadius.all(new Radius.circular(10))),
                  padding: EdgeInsets.fromLTRB(10,5,10,5),
                  child:Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Text( "Follow" ,textAlign: TextAlign.left, style: GoogleFonts.oswald(   color: MYColors.fontGrey(),fontSize: 18),),
                      new Icon(Icons.thumb_up),
                    ],
                  ),

                )


              ],))
              ,Divider() ]
        ) )
    ;
  }


}