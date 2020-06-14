import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutterapp3/general/colors.dart';
import 'package:flutterapp3/general/ganeral.dart';
import 'package:flutterapp3/home.dart';
import 'package:flutterapp3/products/homeScreen.dart';
import 'package:flutterapp3/products/shopScreen.dart';
import 'package:flutterapp3/store/message.dart';
import 'package:flutterapp3/store/shop.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:date_util/date_util.dart';



class MyFollwingPageScreen extends StatefulWidget {
  MyFollwingPageScreen({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyFollwingPageScreen> {

  var data;
  // Function to get the JSON data
  Future<String> getJSONData() async {

    var response =await Shop ().getShops( false) ;//await http.get('https://jsonplaceholder.typicode.com/posts',headers: header );

    setState(() {
      // Get the JSON data
      data  = response;
    });
    return "Successfull";
  }
  Future<bool> _onBackPressed( ) async{
    debugPrint('fffffffff');
   // General().onBackPressed(context, Home());

  }

  @override
  Widget build(BuildContext context) {
    return
      new  WillPopScope( // onWillPop:  _onBackPressed ,
     child: Scaffold(
      appBar: AppBar(
        title: Text( "My Following",style: TextStyle(color: Colors.white), ),
      ),
      body:
      Container( decoration: BoxDecoration(color: MYColors.grey(),
      ),
        child:_buildListView()
        , ),
      ));
  }

  Widget _buildListView() {
    if (data == null)
      this.getJSONData();
    return

      ListView.builder(
          padding: const EdgeInsets.all(5.0),
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (context, index) {
            //  return _buildImageColumn(data[index]);
            return _buildRow(data[index]);
          }
      )
    ;
  }
  Future<bool> onDelete() async{
    return showDialog(
      context: context,
      builder: (context) => new AlertDialog(
        title: new Text('Are you sure?'),
        content: new Text('Do you want to exit an App'),
        actions: <Widget>[
          new GestureDetector(
            onTap: () => Navigator.of(context).pop(false),
            child: Text("NO"),
          ),
          SizedBox(height: 16),
          new GestureDetector(
            onTap: () => Navigator.of(context).pop(true),
            child: Text("YES"),
          ),
        ],
      ),
    ) ??
        false;
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
      ConstrainedBox(constraints: BoxConstraints(maxHeight: 200),
          child:  InkWell( onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context)=>ShopPage(shop:item)) );}, child:
          Container(height: 80,
              //  padding: const EdgeInsets.fromLTRB(0, 9, 0, 9),
              margin: const EdgeInsets.fromLTRB(9, 9, 9, 0),
              decoration:new  BoxDecoration(color: Colors.white,
                borderRadius: new BorderRadius.all (new Radius.circular(10.0)),
              ) ,

              child:
              Container(   child:
              Card(
                margin: const EdgeInsets.symmetric(horizontal: 4,vertical: 7),
                child: SafeArea(
                  child: ListTile(
                    leading:
                    Container  (width: 50,height: 50,
                        decoration: BoxDecoration(color: MYColors.grey1(),
                            borderRadius: BorderRadius.circular(50.0),
                            image: DecorationImage(
                                image: General.mediaUrl (item['profile_image']),
                                fit: BoxFit.cover
                            )
                        )
                    )  ,
                    title: Text('FilledStacks'),
                  //  subtitle: Text('Thanks for checking out my tutorial'),
                    trailing: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {onDelete();
                          //OverlaySupportEntry.of(context).dismiss();
                        }),
                  ),
                ),
              )

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
