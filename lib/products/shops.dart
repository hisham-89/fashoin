import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutterapp3/MessageDetails.dart';
import 'package:flutterapp3/config/url.dart';
import 'package:flutterapp3/general/colors.dart';
import 'package:flutterapp3/general/ganeral.dart';
import 'package:flutterapp3/products/searchScreen.dart';
import 'package:flutterapp3/products/shopScreen.dart';
import 'package:flutterapp3/products/shopUserForm.dart';
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

class ShopComponent{

  Widget  buildRow(dynamic item,context) {

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
                                image: item['profile_image']!=null? General.mediaUrl(item['profile_image']) :AssetImage('assets/images/fashionLogo.jpeg'),
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




}

class Shops extends StatefulWidget {
  Shops({Key key, this.title,this.isMyShops}) : super(key: key);

  final String title;
  final bool isMyShops;
  @override
  _MyHomePageState createState() => _MyHomePageState(isMyShops);
}

class _MyHomePageState extends State<Shops> {
  bool visible=true;
  bool isMyShops=false;
  _MyHomePageState(this.isMyShops);
  List data=null;
  int page=1;
  int last_page=1000;
  final controller=new ScrollController();
  // Function to get the JSON data
  Future<String> getJSONData() async {
    setState(() {
      visible= true;
       });
    var response =await Shop().getShops(isMyShops,page:page) ;//await http.get('https://jsonplaceholder.typicode.com/posts',headers: header );
    setState(() {
      visible=false;
      // Get the JSON data
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


  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      appBar: AppBar(
        title: Text(isMyShops!=null&&isMyShops?'My Shops':'Shops',style: TextStyle(color: Colors.white), ),
        actions: <Widget>[
          isMyShops!=null&&isMyShops?  FlatButton.icon(  onPressed: (){General.pushRoute(context, ShopUserFormScreen());}, icon:Icon(Icons.add,color: Colors.white,) ,
              label: Text("Add shop" ,style: TextStyle(color: Colors.white,),)):Container()
          , Padding(
            child:  GestureDetector(onTap: (){  Navigator.of(context).push(
                MaterialPageRoute(builder: (context) =>  SearchScreen())
            );},
                child: Icon(Icons.search,size: 25,color: Colors.white,) ),
            padding: EdgeInsets.only(left: 15,right: 15),) ],
      ),
      body: RefreshIndicator (onRefresh: ()async{
        setState(() {
          page=1;
          data=null;
          getJSONData();
          visible=true;
        });
      },
       child:
        SingleChildScrollView(
        controller:controller ,
        child:
        Container( decoration: BoxDecoration(color: MYColors.grey(),

        ),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildListView(),
              visible? CircularProgressIndicator(
                // valueColor: new AlwaysStoppedAnimation<Color>(AppColors.themeColorSecondary),
              ):Container()
            ],)

          , ),
      ))
      ,)
    ;
  }
  _scrollListener(){
    print( '-----------------');
    if (controller.position.pixels==controller.position.maxScrollExtent){


      if(page<=last_page)
        getJSONData();
      else
        setState(() {
          visible=false;
        });
    }
  }
  Widget _buildListView() {
    if (data == null){
      this.getJSONData();}

    return ListView.builder(
      //  controller: controller,
        shrinkWrap: true,    physics: NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(5.0),
        itemCount: data == null ? 0 : data.length,

        itemBuilder: (context, index) {
          //  return _buildImageColumn(data[index]);
          return ShopComponent().buildRow(data[index],context);
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

  @override
  void initState() {
    controller.addListener(_scrollListener);
    super.initState();
    // Call the getJSONData() method when the app initializes
    //  this.getJSONData();
  }
}