import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutterapp3/MessageDetails.dart';
import 'package:flutterapp3/config/url.dart';
import 'package:flutterapp3/general/colors.dart';
import 'package:flutterapp3/general/ganeral.dart';
import 'package:flutterapp3/products/productDetails.dart';
import 'package:flutterapp3/products/shopScreen.dart';
import 'package:flutterapp3/store/message.dart';
import 'package:flutterapp3/store/user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:date_util/date_util.dart';

class ProductsScreen extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(   primaryColor:     MYColors.primaryColor(),textTheme: TextTheme(
        body1:  GoogleFonts.tajawal(fontStyle: FontStyle.normal   ),
      ),
      ),
      home: MyHomePage(title: 'ProductsScreen' ),
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
  final image =  "https://image.shutterstock.com/image-photo/beautiful-tender-girl-silk-top-600w-1081362410.jpg";
  Widget build(BuildContext context){
    if (data == null)
      this.getJSONData();


    return  (
      ListView.builder(
          padding: const EdgeInsets.all(5.0),
          itemCount: data == null ? 0 : data.length,
          itemBuilder: (context, index) {
            //  return _buildImageColumn(data[index]);
            return listViewProducts( );
          }
      )



    );
  }
Widget listViewProducts( ){
    return(

        Container(
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  InkWell(onTap: (){ Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ShopScreen(id:'2'))
                  );},child:  Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        image: DecorationImage(
                            image: CachedNetworkImageProvider(image),
                            fit: BoxFit.cover
                        )
                    ),)),
                  Positioned(
                    bottom: 20.0,
                    left: 20.0,
                    right: 20.0,
                    child: Row(
                      children: <Widget>[
                        Icon(Icons.slideshow, color: Colors.white,),
                        SizedBox(width: 10.0),
                        Text("Technology", style: TextStyle(color: Colors.white),)
                      ],
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(children: <Widget>[
                      Expanded(child: Text("Oct 21, 2020"),),
                      IconButton(icon: Icon(Icons.share), onPressed: (){},)
                    ],),
                    Text("Product" , style: Theme.of(context).textTheme.title,),
                    Divider(),
                    SizedBox(height: 10.0,),
                    Row(children: <Widget>[
                      Icon(Icons.favorite_border),
                      SizedBox(width: 5.0,),
                      Text("20.2k"),
                      SizedBox(width: 16.0,),
                      Icon(Icons.comment),
                      SizedBox(width: 5.0,),
                      Text("2.2k"),
                    ],),
                    SizedBox(height: 10.0,),
                    Text("Lorem ipsum dolor, sit amet consectetur ad  ullam?  .", textAlign: TextAlign.justify,)
                  ],
                ),
              ),
            ],
          ),
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