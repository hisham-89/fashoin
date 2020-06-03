import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutterapp3/MessageDetails.dart';
import 'package:flutterapp3/config/icons.dart';
import 'package:flutterapp3/config/url.dart';
import 'package:flutterapp3/general/colors.dart';
import 'package:flutterapp3/general/ganeral.dart';
import 'package:flutterapp3/store/message.dart';
import 'package:flutterapp3/store/user.dart';
import 'package:getflutter/components/carousel/gf_carousel.dart';

import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';

class ProductsDetailsScreen extends StatelessWidget {
  // This widget is the root of your application.
dynamic product;
  String id;
   ProductsDetailsScreen( {Key key,this.id,this.product}): super(key: key) ;
  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(   primaryColor:     MYColors.primaryColor(),textTheme: TextTheme(
        body1:  GoogleFonts.tajawal(fontStyle: FontStyle.normal   ),
      ),
      ),
      home: ProductsDetailsScreenPage(title: 'ProductsScreen',product:this.product,id:this.id ),
    );
  }
}

class ProductsDetailsScreenPage extends StatefulWidget {
  var product;
  String id;
  ProductsDetailsScreenPage({Key key,@required this.product, this.title,   this.id }) : super(key: key);
  final String title;

  @override
  _ProductsDetailsScreenPageState createState() => _ProductsDetailsScreenPageState( this.product);
}

class _ProductsDetailsScreenPageState extends State<ProductsDetailsScreenPage> {
  var product;
  _ProductsDetailsScreenPageState(this.product);
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
  Widget imageSlider(imageList,product_id,product){
    return(
        GFCarousel( height:400,
          items: imageList.map<Widget>(
                (url) {
              if(url['name']!=null)
                return
                       Container( width: double.infinity,height: double.infinity,
                                          child:ClipRRect(
                                          //  borderRadius: BorderRadius.only(topLeft: new Radius.circular(10),topRight: new Radius.circular(10) ),
                                            child:InkWell(onTap: (){
                                            } ,child:
                                            Image.network(
                                              General.mediaUrl(url['name']) ,
                                              fit: BoxFit.cover,
                                            )),
                                          ),
                                        )

                   ;
              else
                return(Container());
            },
          ).toList(),
          onPageChanged: (index) {
//                          setState(() {
//                            index;
//                          });
          },
        ));
  }
  final image =  "https://image.shutterstock.com/image-photo/beautiful-tender-girl-silk-top-600w-1081362410.jpg";
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar( elevation: 0,
        leading: new IconButton(
        icon: new Icon(Icons.arrow_back),
        onPressed: () =>    Navigator.of(context).pop()

      ),
      iconTheme: IconThemeData(
          color: Colors.black
      ),
      brightness: Brightness.light,
      // backgroundColor: Colors.transparent,

      title: Text("Back to Shopping", style: TextStyle(color: Colors.black),),
      actions: <Widget>[

      ],
    ),
      body: SingleChildScrollView(
      //  fit: StackFit.expand,
        child: Column(
        children: <Widget>[
          Column(//physics: NeverScrollableScrollPhysics(),shrinkWrap: true,
            children: <Widget>[
              Container( // height: double.infinity,
                //decoration: BoxDecoration(border: Border.all(width: 2 )),
                child:
             Stack(children: <Widget>[
            Container( child: imageSlider(product['images'],product['id'].toString(), product ))//  Image(image: CachedNetworkImageProvider(image)))
      //General.mediaUrl(product['images'][0]['name'],) ,),

             ],)
             ,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 5.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                        child: buildDropdownButton(['Black','Blue','Red'],'Black')
                    ),
                    Expanded(
                        child: buildDropdownButton(['S','M','XL','XXL'],'XXL')
                    ),
                  ],
                ),
              ),
    Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
    Expanded( child:Container(
    padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
    child: Text(product['name']  , style: TextStyle(
    fontSize: 22.0,
    fontWeight: FontWeight.w500
    ),),
    )),
    Align(alignment: Alignment.bottomRight, child: IconButton(icon: Icon( Icons.favorite_border,size: 32, ), onPressed: () {},),)
    ]),
              Container( padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 10.0),
              child:Row(children: <Widget>[
                Text("By :"),
                Text("Store 1" ,style: TextStyle(
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold
                )),
              ]   ,)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                  Text(product['price']!=null? product['price']:"", style: TextStyle(
                    color: MYColors.primaryColor(),
                    fontSize: 30.0,
                  )),
                  SizedBox(width: 20.0,),
                ],
              ),
              Container(padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0) ,
                  child: Text( product['details']!=null? product['details']:"",style: TextStyle(
                      fontSize: 20.0,
                      fontWeight: FontWeight.w400
                  ))),
              Container(
                padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
                child: Text(   '',
                  textAlign: TextAlign.justify,
                  style: TextStyle(
                      color: Colors.grey.shade600
                  ),
                ),
              ),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[

              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: MaterialButton(
                      color: Colors.deepOrange,
                      elevation: 0,
                      onPressed: (){},
                      child: Container(
                        padding: EdgeInsets.all(15.0),
                        child: Text("Buy", textAlign: TextAlign.center,style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w500
                        ),),
                      ),
                    ),
                  ),
                  Expanded(
                    child: MaterialButton(
                      color: Colors.black54,
                      elevation: 0,
                      onPressed: (){},
                      child: Container(
                        padding: EdgeInsets.all(15.0),
                        child: Text("Add a bag", textAlign: TextAlign.center,style: TextStyle(
                            fontSize: 20.0,
                            color: Colors.white,
                            fontWeight: FontWeight.w500
                        ),),
                      ),
                    ),
                  ),
                ],
              )
            ],
          )
        ]
        ),
      ),
    );
  }

  Widget buildDropdownButton(List<String> products, String selectedValue) {
    return DropdownButton<String>(
      isExpanded: true,
      value: selectedValue,
      onChanged: (_) {},
      items: products.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }
  @override
  void initState() {
    super.initState();
    // Call the getJSONData() method when the app initializes
    this.getJSONData();
  }
}