import 'package:flutter/material.dart';
import 'package:flutterapp3/MessageDetails.dart';
import 'package:flutterapp3/general/colors.dart';
import 'package:flutterapp3/general/ganeral.dart';
import 'package:flutterapp3/products/productDetails.dart';
import 'package:flutterapp3/products/productScreen.dart';
import 'package:flutterapp3/store/Like.dart';
import 'package:flutterapp3/store/message.dart';
import 'package:flutterapp3/store/user.dart';

import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:date_util/date_util.dart';

class Likes extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(   primaryColor:     MYColors.primaryColor(),textTheme: TextTheme(
        body1:  GoogleFonts.tajawal(fontStyle: FontStyle.normal   ),
      ),
      ),
      home: MyHomePage(title: 'Likes' ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if(state == AppLifecycleState.resumed){
      debugPrint('resumed');
    }else if(state == AppLifecycleState.inactive){
      debugPrint('inactive');
    }else if(state == AppLifecycleState.paused){
      debugPrint('paused');
    }
//    else if(state == AppLifecycleState.){
//      // app suspended (not used in iOS)
//    }
  }
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List data;
  int page=1;
  int last_page=10;
  bool visible=false;
  var controller= new ScrollController();
  _MyHomePageState(){
    debugPrint("constructor");
  }
  // Function to get the JSON data
  Future<String> getJSONData() async {
    setState(() {
      visible=true;});
    var response =await Like ().getMyLikes(  page  ) ;

    setState(() {
      visible=false;
      if (data!=null)
        data.addAll(response['data']['data']) ;
      else
        data=response['data']['data'];
      page++;
      if(response['data']['last_page']!=null)
        last_page=response['data']['last_page'];
    });
    return "Successfull";
  }
  _scrollListener(){

    if (controller.position.pixels==controller.position.maxScrollExtent){
      if(page<=last_page)
        getJSONData();
      else
        setState(() {
          visible=false;
        });
    }
  }
  @override
  Widget build(BuildContext context) {
    return  new  WillPopScope(
        child: Scaffold(
            appBar: AppBar(
              title: Text(widget.title,style: TextStyle(color: Colors.white), ),
            ),
            body:RefreshIndicator(onRefresh: ()async{
              setState(() {
                page=1;
                data=null;
                getJSONData();
                visible=true;
              });
            },
                child: SingleChildScrollView(
                  controller:controller ,
              child:
              Column(children: <Widget>[  Container( decoration: BoxDecoration(color: MYColors.grey(),

              ),
                child:_buildListView()
                , ) ,
                visible?CircularProgressIndicator():Container()],)

            )
        )
    )
    );
  }

  Widget _buildListView() {

    return

      ListView.builder(
          shrinkWrap: true,physics: NeverScrollableScrollPhysics(),
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
      Container(
          padding: const EdgeInsets.fromLTRB(0, 9, 0, 9),
          margin: const EdgeInsets.fromLTRB(9, 9, 9, 0),
          decoration:new  BoxDecoration(color: Colors.white,
            borderRadius: new BorderRadius.all (new Radius.circular(20.0)),
          ) ,
          child:
          ListTile(
              onTap: () {
                General.pushRoute(context, ProductsDetailsScreenPage (id:item['product']['id'].toString() ));

              },
              leading:
              Container  (width: 50,height: 50,
                  decoration: BoxDecoration(color: MYColors.grey1(),
                      borderRadius: BorderRadius.circular(50.0),
                      image: DecorationImage(
                          image: General.mediaUrl(item['product']['images'].length>0?item['product']['images'][0]['name']:null),
                          fit: BoxFit.cover
                      )
                  )
              ),


              // title:  Text("From"+ item['title']  ),
              title:  Container(
                  child:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        //   Image  ( width: 50 , image: AssetImage('assets/images/dress3.png')),
                        Container(
                            padding: const EdgeInsets.fromLTRB(9, 0, 9, 0),
                            child:Text(   (item['product']['name'].length >=20 )?item['product']['name'].substring(0,20) :item['product']['name'] )
                        )
                        , Icon( favorite ,color: Colors.red ,size: 44 )
                        // Divider()
                      ]
                  )
              )

          )
      );

  }
  @override
  void initState() {
    controller.addListener(_scrollListener);
    super.initState();
    // Call the getJSONData() method when the app initializes
    // if (data == null)
    this.getJSONData();
  }
}