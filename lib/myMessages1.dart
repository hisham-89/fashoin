import 'package:flutter/material.dart';
import 'package:flutterapp3/MessageDetails.dart';
import 'package:flutterapp3/store/message.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';



class MyMessages1 extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
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
//    var response = await http.get(
//      // Encode the url
//        Uri.encodeFull("https://unsplash.com/napi/photos/Q14J2k8VE3U/related"),
//        // Only accept JSON response
//        headers: {"Accept": "application/json"}
//    );
    var message=new Message();
      var response1= await message.getMessages(   );
    setState(() {
      // Get the JSON data
      data = response1;//json.decode(response.body);
    });

    return "Successfull";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: _buildListView(),
    );
  }

  Widget _buildListView() {
    if (data == null)
      this.getJSONData();
    return ListView.builder(
        padding: const EdgeInsets.all(5.0),
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (context, index) {
        //  return _buildImageColumn(data[index]);
          return _buildRow(data[index]);
        }
    );
  }

  Widget _buildImageColumn(dynamic item) => Container(
    decoration: BoxDecoration(
        color: Colors.white54
    ),
    margin: const EdgeInsets.all(4),
    child: Column(
      children: [
        CircleAvatar(
          backgroundImage: AssetImage('assets/images/user-profile.png'),
        ),
        _buildRow(item)
      ],
    ),
  );

  Widget _buildRow(dynamic item) {

    return
      ListTile(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => MyMessages1( ))
          );
        },
        leading: CircleAvatar(
          backgroundImage: AssetImage('assets/images/user-profile.png'),
        ),
        title:   Text('User')
           ,
        subtitle: Text( item['content'] == null ? '':item['content'].length>20? item['content'].substring(0,20) :item['content'])
        //  , subtitle:   Text('User')
      );


  }
  @override
  void initState() {
    super.initState();
    // Call the getJSONData() method when the app initializes
    this.getJSONData();
  }
}