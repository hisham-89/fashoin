import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutterapp3/MessageDetails.dart';
import 'package:flutterapp3/config/url.dart';
import 'package:flutterapp3/general/colors.dart';
import 'package:flutterapp3/general/ganeral.dart';
import 'package:flutterapp3/products/shopScreen.dart';
import 'package:flutterapp3/store/message.dart';
import 'package:flutterapp3/store/shop.dart';
import 'package:flutterapp3/store/user.dart';
import 'package:flutterapp3/user/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:date_util/date_util.dart';

class Shops extends StatelessWidget {
  bool isMyShops;

  // This widget is the root of your application.
  Shops(this.isMyShops);
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(   primaryColor:     MYColors.primaryColor(),textTheme: TextTheme(
        body1:  GoogleFonts.tajawal(fontStyle: FontStyle.normal   ),
      ),
      ),
      home: MyHomePage(title: isMyShops?'My Shops':'Shops',isMyShops:this.isMyShops ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title,this.isMyShops}) : super(key: key);

  final String title;
  final bool isMyShops;
  @override
  _MyHomePageState createState() => _MyHomePageState(isMyShops);
}

class _MyHomePageState extends State<MyHomePage> {
    bool isMyShops=false;
  _MyHomePageState(this.isMyShops);
  List data=null;

  // Function to get the JSON data
  Future<String> getJSONData() async {

    var response =await Shop().getShops(isMyShops) ;//await http.get('https://jsonplaceholder.typicode.com/posts',headers: header );

    setState(() {
      // Get the JSON data
      data  = response;
    });
    return "Successfull";
  }
  final List<String> imageList = [
    "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcQ_KZalW8BX3-_Oez9mS5b1cEuqxFYcdu3OEeWbzWWAbKUKfLR2&usqp=CAU",
    "https://blog.printsome.com/wp-content/uploads/zara-1.jpg",
    "https://blog.printsome.com/wp-content/uploads/2000px-Gap_logo.svg-copy.jpg",
    "https://blog.printsome.com/wp-content/uploads/2000px-Adidas_Logo.svg-copy-540x360.jpg",
    "https://blog.printsome.com/wp-content/uploads/Lacoste_logo.svg_.jpg",
    "https://blog.printsome.com/wp-content/uploads/1200px-American_Eagle_Outfitters_logo.svg_.jpg"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title,style: TextStyle(color: Colors.white), ),
      ),
      body:
      Container( decoration: BoxDecoration(color: MYColors.grey(),

      ),
        child:_buildListView()
        , ),
    );
  }

  Widget _buildListView() {
    if (data == null){
      this.getJSONData();}

    return ListView.builder(
          padding: const EdgeInsets.all(5.0),
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (context, index) {
            //  return _buildImageColumn(data[index]);
            return _buildRow(data[index]);
          }
      )
    ;
  }
  getDate(date){
    var dateUtility = new DateUtil();
    var moonLanding = DateTime.parse( date);
    String monthName = dateUtility.month(moonLanding.month);
    var year= moonLanding.year==DateTime.now().year?'':"-"+moonLanding.year.toString();
    return moonLanding.day.toString() + " " + monthName+  year
        + " at " + moonLanding.hour.toString() + ":" + moonLanding.minute.toString();
  }
  Widget _buildRow(dynamic item) {
    var newFormat = DateFormat("yyyy-MM-dd hh:mm");
    const IconData favorite = IconData(0xe87d, fontFamily: 'MaterialIcons');
    return
      ConstrainedBox(constraints: BoxConstraints(maxHeight: 300),
          child:  InkWell( onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ShopScreen( shop: item )) );
             },
           child:
          Container(height: 100,
              //  padding: const EdgeInsets.fromLTRB(0, 9, 0, 9),
              margin: const EdgeInsets.fromLTRB(9, 9, 9, 0),
              decoration:new  BoxDecoration(color: Colors.white,
                borderRadius: new BorderRadius.all (new Radius.circular(10.0)),
              ) ,

              child:
              Container(   child:
              Row(children: <Widget>[
                Container  ( width: 100,height: 200,
                    decoration: BoxDecoration(color: MYColors.grey1(),
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                            image: item['profile_image']!=null? CachedNetworkImageProvider(item['profile_image']):AssetImage('assets/images/fashionLogo.jpeg'),
                            fit: BoxFit.fitWidth
                        )
                    )
                ),
                Container(  padding: const EdgeInsets.all(10 ),
                    child:Column(mainAxisAlignment: MainAxisAlignment.spaceAround,crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          //   Image  ( width: 50 , image: AssetImage('assets/images/dress3.png')),
                          Container(

                              child:Text(  item['name'] ,style:TextStyle(fontSize: 21,fontWeight: FontWeight.bold)//(item['title'].length >=20 )?item['title'].substring(0,20) :item['title']
                              )
                          )
                          ,  Container(    height: 1, color:Colors.black ,width:200,) ,
                          Container(
                              child: Row(
                                children: <Widget>[
                                  //  SizedBox(width: 20.0,),
                                  Icon(Icons.star, color: Colors.yellow),
                                  Icon(Icons.star, color: Colors.yellow),
                                  Icon(Icons.star, color: Colors.yellow),
                                  Icon(Icons.star, color: Colors.yellow),
                                  Icon(Icons.star, color: Colors.yellow),
                                  // SizedBox(width: 5.0,),
//                          Text("5.0 stars", style: TextStyle(
//                              color: Colors.grey,
//                              fontSize: 14.0
//                          ))
                                ],
                              )
                          )
                        ]
                    )
                )
              ],)

              )
          )));

  }
  @override
  void initState() {
    super.initState();
    // Call the getJSONData() method when the app initializes
    this.getJSONData();
  }
}