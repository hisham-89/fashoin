import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutterapp3/config/url.dart';
import 'package:flutterapp3/general/colors.dart';
import 'package:flutterapp3/general/ganeral.dart';
import 'package:flutterapp3/likes.dart';
import 'package:flutterapp3/products/addEditProduct.dart';
import 'package:flutterapp3/products/category.dart';
import 'package:flutterapp3/products/productDetails.dart';
import 'package:flutterapp3/products/products.dart';
import 'package:flutterapp3/store/message.dart';
import 'package:flutterapp3/store/shop.dart';
import 'package:getflutter/components/carousel/gf_carousel.dart';

import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';


class ShopScreen extends StatelessWidget {
  // This widget is the root of your application.
  var shop;
  String id;
  ShopScreen({Key key, this.shop,  this.id}) : super(key: key);
//   ShopScreen( shop, { this.id}){
//    this.shop=shop;
//   }

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(   primaryColor:     MYColors.primaryColor(),textTheme: TextTheme(
        body1:  GoogleFonts.tajawal(fontStyle: FontStyle.normal   ),
      ),
      ),
      home: ShopPage(title: 'Shop', id:this.id ,shop:this.shop),
    );
  }
}

class ShopPage extends StatefulWidget {
  dynamic shop;
  String id;
  ShopPage({Key key, this.title,this.shop,this.id}) : super(key: key);

  final String title;

  @override
  _ShopPageState createState() => _ShopPageState(this.shop ,this.id);
}

class _ShopPageState extends State<ShopPage>   with TickerProviderStateMixin {
  dynamic shop;
  String id;
  _ShopPageState(this.shop,this.id);
  List data;
  final List<String> imageList = [
    "https://cdn.pixabay.com/photo/2015/04/25/20/20/dress-739665_960_720.jpg",
    "https://image.shutterstock.com/image-photo/amused-beautiful-young-woman-pink-600w-594774212.jpg",
    "https://cdn.pixabay.com/photo/2016/08/26/20/44/elan-1623085_960_720.jpg",
    "https://cdn.pixabay.com/photo/2016/03/27/19/31/fashion-1283863_960_720.jpg",
    "https://image.shutterstock.com/image-photo/street-fashion-woman-look-fashionista-600w-579909655.jpg",
    "https://cdn.pixabay.com/photo/2020/02/05/11/06/portrait-4820889_960_720.jpg"
  ];
  List<Tab> tabList = List();
  TabController _tabController;
  @override
  void initState() {
    super.initState();
    tabList.add(new Tab(text:'Info',));
    tabList.add(new Tab(text:'Products',));
    _tabController = new TabController( vsync: this, length:
    tabList.length);

  }
  // Function to get the JSON data
  Future<String> getJSONData() async {

    var response = await  Shop().getShop(this.id);
    setState(() {
      // Get the JSON data
      shop  = response;
    });
    return "Successfull";
  }

  static final String path = "lib/src/pages/profile/profile3.dart";
  final image =  "https://image.shutterstock.com/image-photo/beautiful-tender-girl-silk-top-600w-1081362410.jpg";
  List categories(cats){
    List <Widget> li=[];

    for(var cat in cats){
      li.add(
          Expanded(child: Column(
            children: <Widget>[
              Image(image: cat['category']['icon']!=null?  CachedNetworkImageProvider(General.mediaUrl( cat['category']['icon'])):AssetImage('assets/images/fashionLogo.jpeg'),width: 30,
              ), SizedBox(height: 4.0),
              Text( cat['category']['name'] ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)
            ],
          ),));
    }
    return li;
  }
  @override
  Widget build(BuildContext context) {
    return
      Scaffold(
          backgroundColor: Colors.grey.shade300,
          body:
          // ProductsScreen()
          SingleChildScrollView(
            child :
            //
            Stack(
              children: <Widget>[
                SizedBox(
                  height: 250,
                  width: double.infinity,
                  child:shop!=null && shop['cover_image']!=null ?Image.network(shop['cover_image'], fit: BoxFit.cover ):Container(),
                ),
                Container(
                  margin: EdgeInsets.fromLTRB(16.0, 200.0, 16.0, 16.0),
                  child: Column(
                    children: <Widget>[
                      Stack(
                        children: <Widget>[
                          Container(
                            padding: EdgeInsets.all(16.0),
                            margin: EdgeInsets.only(top: 16.0),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5.0)
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(
                                  margin: EdgeInsets.only(left: 96.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Row(children: <Widget>[
                                        Text( shop['name'],  style: Theme.of(context).textTheme.title,),
                                        Expanded( child: Container( alignment: Alignment.bottomRight, child:Icon( Icons.thumb_up ,textDirection: TextDirection.rtl)) ,) ],),
                                      SizedBox(height: 30.0),
//                                    ListTile(
//                                      contentPadding: EdgeInsets.all(0),
//                                   //   title: Text("For Kids  "),
//                                    //  subtitle: Text("Kathmandu"),
//                                    ),
                                    ],
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Row(
                                  children: <Widget>[
                                    Expanded(child: Column(
                                      children: <Widget>[
                                        Text("285"),
                                        Text("Likes" ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)
                                      ],
                                    ),),
                                    Expanded(child: Column(
                                      children: <Widget>[
                                        Text("3025"),
                                        Text("Comments",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)
                                      ],
                                    ),),
                                    Expanded(child: Column(
                                      children: <Widget>[
                                        Text("650"),
                                        Text("Favourites",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)
                                      ],
                                    ),),
                                  ],
                                ),
                                Divider(),
                                SizedBox(height: 10.0),
                                Row(
                                  children:
                                  shop['shop_categories']!=null? categories( shop['shop_categories']):<Widget>[Text('')]
                                  ,
                                )
                              ],
                            ),
                          ),
                          Container(
                            height: 80,
                            width: 80,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.0),
                                image: DecorationImage(
                                    image: shop['profile_image']!=null? CachedNetworkImageProvider(shop['profile_image']):AssetImage('assets/images/fashionLogo.jpeg'),
                                    fit: BoxFit.cover
                                )
                            ),
                            margin: EdgeInsets.only(left: 16.0),
                          ),
                        ],
                      ),

                      SizedBox(height: 20.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child:
                        info(), //
                      ),
                      SizedBox(height: 20.0),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(5.0),
                        ),
                        child:
                        products(), //
                      )
                    ],
                  ),
                ),
                AppBar(
                  backgroundColor: Colors.transparent,
                  elevation: 0,
                )
                // , ProductsScreen()
                , ],
            )  ,

          )

      )
    ;
  }
  Widget info (){
    return (
        Column (children: <Widget>[
          ListTile(title: Text("Information" ,style:TextStyle(fontSize: 20 )),),
          Divider() ,
          shop!=null && shop['phone']!=null?  ListTile(
            title: Text("Phone"),
            subtitle: Text("+977-9815225566"),
            leading: Icon(Icons.phone),
          ):Container(),
          shop!=null && shop['facebook']!=null?   ListTile(onTap: (){  },
              title: Text("Facebook",style: TextStyle(color: Colors.blue)),
              subtitle: Text("facebook.com",),
              leading: Image(image: AssetImage("assets/images/facebook.png"),width:20,)// Icon(Icons.email),
          ):Container(),
          shop!=null && shop['instagram']!=null?  ListTile(onTap: (){  },
              title: Text("Instagram",style: TextStyle(color: Colors.pink)),
              subtitle: Text("instagram.com",),
              leading: Image(image: AssetImage("assets/images/instagram.png"),width:20,)// Icon(Icons.email),
          ):Container(),
          shop!=null && shop['email']!=null?  ListTile(
            title: Text("Email"),
            subtitle: Text("butterfly.little@gmail.com"),
            leading: Icon(Icons.email),
          ):Container(),

          shop!=null && shop['website']!=null?   ListTile(
            title: Text("Website"),
            subtitle: Text("https://www.littlebutterfly.com"),
            leading: Icon(Icons.web),
          ):Container(),
          shop!=null && shop['address']!=null?   ListTile(
            title: Text("Address"),
            subtitle: Text("Lorem ipsum, dolor sit amet consectetur adipisicing elit. Nulla, illo repellendus quas beatae reprehenderit nemo, debitis explicabo officiis sit aut obcaecati iusto porro? Exercitationem illum consequuntur magnam eveniet delectus ab."),
            leading: Icon(Icons.person),
          ):Container(),
          ListTile(
            title: Text("Joined Date"),
            subtitle: Text(General.getDate(shop['created_at'],time: false,year: true)  ),
            leading: Icon(Icons.calendar_view_day),
          ),
        ],));
  }


  Widget products( ){
    if (shop == null)
      this.getJSONData();
    ///**/
    return  (

        Column(children: <Widget>[

          Container(  decoration: BoxDecoration(
            //  color:MYColors.grey(),
            borderRadius: BorderRadius.circular(5.0),
          ),
              margin: EdgeInsets.only(top: 0),    child:ListTile(title: Text("Our products",style: TextStyle(fontSize: 20,color: MYColors.primaryColor()),),)),
          ListTile(

            title:RaisedButton.icon(icon: Icon(Icons.add ,color: Colors.white,) , color:MYColors.primaryColor(),  label:  Text(
              'Add New Product',
              style: TextStyle(
                color
                    : Colors.white,
              ),
            ),)  ,
            onTap: (){
              //  _pageController.jumpToPage(index);
              // Navigator.of(context).pop();

              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddProductScreen(shopId:shop['id'].toString()))
              );
            },
          ),
          Container ( //height: 600,
              child:  ListView.builder(shrinkWrap: true,  physics: NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.all(5.0),
                  itemCount:  shop['products'] == null ? 0 : shop['products'] .length,
                  itemBuilder: (context, index) {
                    //  return _buildImageColumn(data[index]);
                    return listViewProducts(shop['products'] [index] );
                  }
              ))
        ]
        )
    );
  }
//  List<Widget> images(images){
//    for(var a in images){
//      return (
//
//      )
//    }
//  }
  Widget imageSlider(imageList,product_id,product){
    return(
        GFCarousel(height: 350,pagination: true,reverse: false,
          items: imageList.map<Widget>(
                (url) {
                  if(url['name']!=null)
              return
                Container(
                  child: Column(
                    children: <Widget>[
                      Container(height: 350,
                          decoration: new BoxDecoration(
                              borderRadius:BorderRadius.all(new Radius.circular(20))
                          ),
                          margin: EdgeInsets.only(left:4.0,right: 4,top: 0),
                          child:
                          Container(  decoration: new BoxDecoration(color: Colors.white,
                              borderRadius:BorderRadius.all(new Radius.circular(10))
                          ),
                              child:Column(
                                children: <Widget>[
                                  Flexible(flex:10,fit: FlexFit.tight,
                                    child:
                                    new Stack(children: <Widget>[
                                      new Container( width: double.infinity,height: double.infinity,
                                        child:ClipRRect(
                                          borderRadius: BorderRadius.only(topLeft: new Radius.circular(10),topRight: new Radius.circular(10) ),
                                          child:InkWell(onTap: (){  Navigator.push(
                                              context,
                                              MaterialPageRoute(builder: (context) => ProductsDetailsScreen(product:product, id:product_id))
                                          );
                                          } ,child:
                                          Image.network(
                                          General.mediaUrl(url['name']) ,
                                            fit: BoxFit.cover,
                                          )),
                                        ),
                                      ),

                                    ],
                                    ),
//
                                  ),


                                ],
                              )
                          )

                      )
                    ],),
                );
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
  Widget listViewProducts(item ){
    return(
        Container(color: MYColors.grey2(),margin: EdgeInsets.only(bottom: 30),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  InkWell(onTap: (){ Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProductsDetailsScreen(  id:item['id'].toString(),product:item )
                  ));
                      },child:  Container(
                    height: 350,
                    width: double.infinity,
//                decoration: BoxDecoration(
//                        borderRadius: BorderRadius.circular(10.0),
//                         image:  item['images']!=null&&item['images'].length==1?DecorationImage(
//                            image: CachedNetworkImageProvider(General.mediaUrl(item['images'][0]['name'])),
//                            fit: BoxFit.contain
//                        ):null
//                    ) ,
                 child:item['images']!=null && item['images'].length>0? imageSlider(item['images'],item['id'].toString(), item ):Container(),
                  )),

                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 4.0, bottom: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(children: <Widget>[
                      Expanded(child: Text( General.getDate(item['created_at'],time:true)),),
                      IconButton(icon: Icon(Icons.share), onPressed: (){},)
                     ,  IconButton(icon: Icon( Icons.favorite   ,size: 30 ),onPressed: (){},) ,

                    ],),
                    Text(item['name'].toString() , style: Theme.of(context).textTheme.title,),
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
                    Text(item['details'] == null ? '':item['details'].length>20? item['details'].substring(0,20)+"..." :item['details'], textAlign: TextAlign.justify,)
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}