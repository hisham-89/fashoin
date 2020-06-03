import 'package:flutter/material.dart';
import 'package:flutterapp3/MessageDetails.dart';
import 'package:flutterapp3/general/colors.dart';
import 'package:flutterapp3/general/ganeral.dart';
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
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

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
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => MessageDetails(id:item['id'] ))
                );
              },
              leading:Image  ( width: 50,height: 150,
                image: AssetImage('assets/images/dress2.png'),
              ),
              // title:  Text("From"+ item['title']  ),
              title:  Container(
                  child:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        //   Image  ( width: 50 , image: AssetImage('assets/images/dress3.png')),
                        Container(
                            padding: const EdgeInsets.fromLTRB(9, 0, 9, 0),
                            child:Text(   (item['title'].length >=20 )?item['title'].substring(0,20) :item['title'] )
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
    super.initState();
    // Call the getJSONData() method when the app initializes
    this.getJSONData();
  }
}