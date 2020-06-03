import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutterapp3/MessageDetails.dart';
import 'package:flutterapp3/config/url.dart';
import 'package:flutterapp3/general/colors.dart';
import 'package:flutterapp3/general/ganeral.dart';
import 'package:flutterapp3/store/message.dart';
import 'package:flutterapp3/store/user.dart';
import 'package:flutterapp3/user/login.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:date_util/date_util.dart';

class CategoryScreen extends StatelessWidget {
  // This widget is the root of your application.
  Widget popup(BuildContext context,items) {

    List <Widget> list =[];
    for(var item in items){
      list.add(
          Container(height:180, decoration: BoxDecoration(  color: Colors.white, borderRadius:BorderRadius.all(new Radius.circular(20) )),
            padding: const EdgeInsets.all(5),
            child:Column(mainAxisAlignment:MainAxisAlignment.spaceAround ,crossAxisAlignment: CrossAxisAlignment.center,
                children :<Widget>[
                  Flexible(fit: FlexFit.tight,flex: 5,
                      child:  Image.network(
                      item ,  fit:BoxFit.cover) )
               ,
                  Flexible(flex: 1,
                      child:  new Text("shop" ,  style: TextStyle(fontSize: 12),))
           ] )
         ));
    }
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    showGeneralDialog(
        context: context,
        barrierDismissible: true,

        barrierLabel: MaterialLocalizations.of(context)
            .modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext,
            Animation animation,
            Animation secondaryAnimation) {
          return Center(
              child: Container(decoration: new BoxDecoration(
                borderRadius:BorderRadius.all(new Radius.circular(10)),//color: Colors.white
              ),
                width: MediaQuery.of(context).size.width - 30,
                height: MediaQuery.of(context).size.height -  80,
                padding: EdgeInsets.all(10),
                // color: Colors.white,
                child:  SingleChildScrollView (child:Container(
                    child:Column(
                      children: <Widget>[
                        Container(margin: EdgeInsets.only(bottom: 10),decoration: new BoxDecoration( color: Colors.white,
                          borderRadius:BorderRadius.all(new Radius.circular(15)),//color: Colors.white
                        ),height: 50, child: Row(
                          children: <Widget>[
                            Expanded(child: Container(width: double.infinity, height: double.infinity,child: Center(child: Text("Store" ,style: TextStyle(fontSize: 16),)))),
                            Expanded(child: Container(width: double.infinity, height: double.infinity,child: Center(child: Text("Category" ,style: TextStyle(fontSize: 16),)),
                              decoration: BoxDecoration(color: Colors.yellow , borderRadius:BorderRadius.only(bottomRight: new Radius.circular(15),topRight: new Radius.circular(15) ),),),)
                          ],
                        ),),
                        Container(//width: double.infinity,
                            height: 400,
                            decoration: new BoxDecoration(color: Colors.red,
                                borderRadius:BorderRadius.all(new Radius.circular(20) )
                            ),
                            margin: EdgeInsets.only(left:0.0,right: 0,top: 0),
                            child:
                            Container(  decoration: new BoxDecoration(color:MYColors.grey2(),
                                borderRadius:BorderRadius.all(new Radius.circular(10))
                            ),
                                child: GridView.count(
                                  primary: false,
                                  padding: const EdgeInsets.all(10),
                                  crossAxisSpacing: 10,
                                  mainAxisSpacing: 10,
                                  crossAxisCount: 3,
                                  children:  list,
                                   childAspectRatio: (itemWidth / itemHeight),

                                )))
                      ],)), ),
              ));
        });

  }
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(   primaryColor:     MYColors.primaryColor(),textTheme: TextTheme(
        body1:  GoogleFonts.tajawal(fontStyle: FontStyle.normal   ),
      ),
      ),
      home: MyHomePage(title: 'Category' ),
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
//            border: new Border.all(
//
//                width: 5.0,
//                style: BorderStyle.solid
//            ),
          ) ,
          //  margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
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