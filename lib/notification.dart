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

class NotificationsScreen extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(   primaryColor:     MYColors.primaryColor(),textTheme: TextTheme(
        body1:  GoogleFonts.tajawal(fontStyle: FontStyle.normal   ),
      ),
      ),
      home: MyHomePage(title: 'Notifications' ),
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
    if (data == null)
      this.getJSONData();
    return

      ListView.builder(
          padding: const EdgeInsets.all(5.0),
          itemCount: imageList == null ? 0 : imageList.length,
          itemBuilder: (context, index) {
            //  return _buildImageColumn(data[index]);
            return _buildRow(imageList[index]);
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
                            image: CachedNetworkImageProvider(item),
                            fit: BoxFit.fitWidth
                        )
                    )
                )  ,
                    title: Text('FilledStacks'),
                    subtitle: Text('Thanks for checking out my tutorial'),
                    trailing: IconButton(
                        icon: Icon(Icons.close),
                        onPressed: () {
                          //OverlaySupportEntry.of(context).dismiss();
                        }),
                  ),
                ),
              )
//              Row(children: <Widget>[
//                Container  ( width: 100,height: 200,
//                    decoration: BoxDecoration(color: MYColors.grey1(),
//                        borderRadius: BorderRadius.circular(10.0),
//                        image: DecorationImage(
//                            image: CachedNetworkImageProvider(item),
//                            fit: BoxFit.fitWidth
//                        )
//                    )
//                ),
//                Container(  padding: const EdgeInsets.all(10 ),
//                    child:Column(mainAxisAlignment: MainAxisAlignment.spaceAround,crossAxisAlignment: CrossAxisAlignment.start,
//                        children: <Widget>[
//                          //   Image  ( width: 50 , image: AssetImage('assets/images/dress3.png')),
//                          Container(
//
//                              child:Text(  "Stor1" ,style:TextStyle(fontSize: 21,fontWeight: FontWeight.bold)//(item['title'].length >=20 )?item['title'].substring(0,20) :item['title']
//                              )
//                          )
//
//
//                        ]
//                    )
//                )
//              ],)
//          ListTile(
//              onTap: () {
//                Navigator.push(
//                    context,
//                    MaterialPageRoute(builder: (context) => MessageDetails(id:item['id'] ))
//                );
//              },
//              leading:Container  ( width: 100,height: 200,
//                  decoration: BoxDecoration(color: Colors.green,
//                    // borderRadius: BorderRadius.circular(10.0),
//                      image: DecorationImage(
//                          image: CachedNetworkImageProvider(image),
//                          fit: BoxFit.fitWidth
//                      )
//                  )
//              ),
//              // title:  Text("From"+ item['title']  ),
//              title:  Container(
//                  child:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                      children: <Widget>[
//                        //   Image  ( width: 50 , image: AssetImage('assets/images/dress3.png')),
//                        Container(
//                            padding: const EdgeInsets.fromLTRB(9, 0, 9, 0),
//                            child:Text(   (item['title'].length >=20 )?item['title'].substring(0,20) :item['title'] )
//                        )
//                        // Divider()
//                      ]
//                  )
//              )
//
//          )
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