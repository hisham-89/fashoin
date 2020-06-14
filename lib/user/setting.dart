import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutterapp3/general/colors.dart';
import 'package:flutterapp3/general/ganeral.dart';
import 'package:flutterapp3/products/shopScreen.dart';
import 'package:flutterapp3/store/message.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/intl.dart';
import 'package:date_util/date_util.dart';

 
class Setting extends StatefulWidget {
  Setting({Key key }) : super(key: key);
  final String title="Setting";
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<Setting> {

  List data;
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
      appBar: AppBar(   iconTheme: new IconThemeData(color: Colors.white),
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

    return

      _buildRow( );
          }


  Widget _buildRow( ) {

    return
      ConstrainedBox(constraints: BoxConstraints(maxHeight: 200),
          child:  InkWell(

            child:
          Container(
              //  padding: const EdgeInsets.fromLTRB(0, 9, 0, 9),
              margin: const EdgeInsets.fromLTRB(9, 9, 9, 0),
              decoration:new  BoxDecoration(color: Colors.white,
                borderRadius: new BorderRadius.all (new Radius.circular(10.0)),
              ) ,

              child:
              Column(
           children: <Widget>[
             Card(
               margin: const EdgeInsets.symmetric(horizontal: 4,vertical: 7),
               child: SafeArea(
                 child:
                 SwitchListTile(
                   value: false,
                   title: Text( "Notifications"),
                   onChanged: (value) {},
                 ),
               ),
             ),
             Card(
               margin: const EdgeInsets.symmetric(horizontal: 4,vertical: 7),
               child: SafeArea(
                 child:
                 CheckboxListTile(
                   value: true,
                   title: Text("Preference"),
                   onChanged: (value) {},
                 ),
               ),
             )
           ],
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