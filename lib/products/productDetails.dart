

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';

import 'package:flutterapp3/config/icons.dart';
import 'package:flutterapp3/general/alert.dart';
import 'package:flutterapp3/general/choice.dart';
import 'package:flutterapp3/general/Loading.dart';

import 'package:flutterapp3/general/colors.dart';
import 'package:flutterapp3/general/ganeral.dart';
import 'package:flutterapp3/products/homeScreen.dart';
import 'package:flutterapp3/products/addEditProduct.dart';

import 'package:flutterapp3/products/shopScreen.dart';
import 'package:flutterapp3/store/message.dart';
import 'package:flutterapp3/store/product.dart';

import 'package:getflutter/components/carousel/gf_carousel.dart';

import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:photo_view/photo_view.dart';

class ProductsDetailsScreen extends StatelessWidget {
  // This widget is the root of your application.
  dynamic product;
  String id;
  ProductsDetailsScreen( {Key key,this.id,this.product}): super(key: key) ;
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: ProductsDetailsScreenPage(title: 'ProductsScreen',product:this.product,id:this.id ),
    );
  }
}

class ProductsDetailsScreenPage extends StatefulWidget {
  var product;
  String id;
  ProductsDetailsScreenPage({Key key,@required this.product, this.title,   this.id }) : super(key: key);
  final String title;

  @override
  _ProductsDetailsScreenPageState createState() => _ProductsDetailsScreenPageState( this.product,this.id);
}

class _ProductsDetailsScreenPageState extends State<ProductsDetailsScreenPage> {
  var product;
  bool visible=false;
  String id;
  _ProductsDetailsScreenPageState(this.product,this.id);
  List data;
    List<Choice> choices = const <Choice>[

    const Choice(id:"1", title: 'Edit', icon: Icons.edit),
    const Choice(id:"2",title: 'Delete  ', icon: Icons.delete),

  ];
  // Function to get the JSON data
  Future<String> getJSONData() async {
    var res =null;
    setState(() {

      visible=true;
    });
    if(this.id!='' &&product==null)
      res= await Product().getProductsDetails( id);
    if(res!=0 && res!=null){
      setState(() {
        product=res;

      });
    }
    setState(() {

      visible=false;
    });
  }
  _select(Choice choice ,{context})
  {
    if (choice.id=="1")
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => AddProductScreen(shopId:this.id))
      );
    AddProductScreen();

  }
  Widget imageSlider(imageList,product_id,product){

    return(
        (imageList==null||imageList.length==0)?  Container():
        GFCarousel( height:400,
          items: imageList.map<Widget>(
                (url) {
              if(url['name']!=null)
                return
                  Container( width: double.infinity,height: double.infinity,
                    child:ClipRRect(
                      //  borderRadius: BorderRadius.only(topLeft: new Radius.circular(10),topRight: new Radius.circular(10) ),
                      child:InkWell(onTap: (){
                      } ,child:PhotoView(
                        imageProvider: General.mediaUrl( url['name']),
                      )
                     )
                     ,
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
  Widget colors(){
    return( Column (children: <Widget>[
      ListTile(
        title: Text("Available Colors" ,style:TextStyle(fontSize: 20 )) , contentPadding: EdgeInsets.only(left: 0),),
      Container(
          child: buildDropdownButton(['Black','Blue','Red'],'Black')
      ),
      Divider() ,
    ]
    )
    );
  }
  Widget sizes(){
    return( Column (children: <Widget>[
      ListTile(
        title: Text("Available Sizes" ,style:TextStyle(fontSize: 20 )) , contentPadding: EdgeInsets.only(left: 0),),
      Container(
          child:   buildDropdownButton(['S','M','XL','XXL'],'XXL')
      ),
      Divider() ,
    ]
    )
    );
  }
  Widget Box(child){
    return(
        Container(
          padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 0.0),
          child: Column(mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              SizedBox(height: 10.0),
              Container(padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 5.0),
                width:double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child:
                child, //
              ),

            ],
          ),
        )
    );
  }
  final image =  "https://image.shutterstock.com/image-photo/beautiful-tender-girl-silk-top-600w-1081362410.jpg";
  Widget build(BuildContext context) {
    return Scaffold( backgroundColor: Colors.grey.shade300,

      appBar: AppBar( elevation: 0,backgroundColor:      MYColors.primaryColor(),
        leading: new IconButton(
            icon: new Icon(Icons.arrow_back,color: Colors.white,),
            onPressed: () =>     Navigator.of(context).maybePop()

        ),


        title: Text(product!=null? product['name']:'' , style: TextStyle(color: Colors.white),),
        actions: <Widget>[

          PopupMenuButton<Choice>(color: Colors.white,
            onSelected:  (Choice choice) {
              if (choice.id=="1")
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => AddProductScreen(shopId: product['shop']['id'].toString(),productId: product['id'].toString()))
                );
              if (choice.id=="2")
                Alert(context,"Are you sure to delete",HomeScreen()).AlertBeforeDelete( Product(),id);
            } ,
            itemBuilder: (BuildContext context) {
              return choices.map((Choice choice) {
                return PopupMenuItem<Choice>(
                    value: choice,
                    child: ListTile(title: Text(choice.title) ,leading:Icon(choice.icon) ,)

                );
              }).toList();
            },
          ),
        ],
      ),
      body:   visible?ProgressDialogPrimary() :
      SingleChildScrollView(
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
                  Box( Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded( child:Container(

                              child: Text(product['name']  , style: TextStyle(
                                  fontSize: 22.0,
                                  fontWeight: FontWeight.bold
                              ),),
                            )),
                            Align(alignment: Alignment.bottomRight, child: IconButton(icon: Icon( Icons.favorite_border,size: 32, ), onPressed: () {},),)
                          ]),

                      Row(children: <Widget>[
                        Icon(Icons.favorite_border),
                        SizedBox(width: 5.0,),
                        Text("20.2k"),
                        //  SizedBox(width: 16.0,),
                        // Icon(Icons.comment),
                        //SizedBox(width: 5.0,),
                        // Text("2.2k"),
                      ],),
                      Container(
                          child:
                          ListTile(
                              onTap: () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>ShopScreen( id: product['shop']['id'].toString()  )) );
                              },contentPadding: EdgeInsets.only(left:0 ),
                              leading:
                              Container  (width: 50,height: 50,
                                  decoration: BoxDecoration(color: MYColors.grey1(),
                                      borderRadius: BorderRadius.circular(50.0),
                                      image: DecorationImage(
                                          image:  General.mediaUrl(product['shop']['profile_image']),
                                          fit: BoxFit.fitWidth
                                      )
                                  )
                              )  ,
                              // title:  Text("From"+ item['title']  ),
                              title:  Container(
                                  child:Row(mainAxisAlignment: MainAxisAlignment.start,
                                      children: <Widget>[
                                        //   Image  ( width: 50 , image: AssetImage('assets/images/dress3.png')),
                                        Container(
                                            padding: const EdgeInsets.fromLTRB(0, 0, 9, 0),
                                            child:Text(  product['shop']['name'] , style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18))
                                        )
                                        , //Icon( favorite ,color: Colors.red ,size: 44 )
                                        // Divider()
                                      ]
                                  )
                              ),subtitle:Text( General.getDate(product['created_at'],time:true)) ,

                          )
                      ),
                     // Container(child: Text( General.getDate(product['created_at'],time:true)),),
                    ],)),
                  Container(
                    child: Column(mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        Container(
                          child:Box(colors())
                          , //
                        ),
//                        Container(
//                            child:Box(sizes())
//                        ),
                      ],
                    ),
                  ),
                  Box(     Column(
                    mainAxisAlignment: MainAxisAlignment.start,crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      SizedBox(height : 20.0 ),
                      Text(product['price']!=null? "Price: "+product['price'].toString()+" "+product['currency']['sign']:"", style: TextStyle(
                        color: MYColors.primaryColor(),
                        fontSize: 30.0,
                      )),
                      SizedBox(width: 20.0,),
                      Container(padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0) ,
                          child: Text( product['details']!=null? product['details']:"",style: TextStyle(
                              fontSize: 20.0,
                              fontWeight: FontWeight.w400
                          ))),
                    ],
                  ),),


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