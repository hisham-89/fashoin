import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutterapp3/config/url.dart';
import 'package:flutterapp3/general/alert.dart';
import 'package:flutterapp3/general/Loading.dart';
import 'package:flutterapp3/general/popUp.dart';
import 'package:flutterapp3/general/colors.dart';
import 'package:flutterapp3/general/ganeral.dart';
import 'package:flutterapp3/products/productScreen.dart';
import 'package:flutterapp3/products/addEditProduct.dart';
import 'package:flutterapp3/products/productDetails.dart';
import 'package:flutterapp3/products/shopUserForm.dart';
import 'package:flutterapp3/store/Like.dart';
import 'package:flutterapp3/store/follow.dart';
import 'package:flutterapp3/store/shop.dart';
import 'package:flutterapp3/store/user.dart';
import 'package:getflutter/components/carousel/gf_carousel.dart';
import 'package:google_fonts/google_fonts.dart';
import 'dart:async';
import 'package:image_picker/image_picker.dart';
import 'package:photo_view/photo_view.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

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
  File tempCoverImage=null;
  File tempProfileImage=null;
  bool isLoading=false;
  String changedImage='';
  var tempCoverImage64;
  var tempProfileImage64;
  PanelController _pc = new PanelController();
  bool uploadImage=false;
  bool uploadImage2=false;
  bool isFollowed=false;
  final picker = ImagePicker();
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
  Future<void> initState()   {
    super.initState();
    var res;

    if (shop == null){
      this.getJSONData();
    }else
    {
      this.id=shop['id'].toString();
    }
    if(shop['is_followed'].length>0 )
      setState(() {
        isFollowed=true;
      });

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
  Future<bool> _onBackPressed() async{
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
  static final String path = "lib/src/pages/profile/profile3.dart";
  final image =  "https://image.shutterstock.com/image-photo/beautiful-tender-girl-silk-top-600w-1081362410.jpg";
  List categories(cats){
    List <Widget> li=[];

    for(var cat in cats){
      li.add(
          Expanded(child: Column(
            children: <Widget>[
              Image(image: cat['category']['icon']!=null?  General.mediaUrl( cat['category']['icon']):AssetImage('assets/images/fashionLogo.jpeg'),width: 30,
              ), SizedBox(height: 4.0),
              Text( cat['category']['name'] ,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)
            ],
          ),));
    }
    return li;
  }
  Future getImage(image) async {
    _pc.close();
    var  pickedFile = await picker.getImage(source: ImageSource.gallery);
    File imageFile = new File(pickedFile.path);
    List<int> imageBytes = imageFile.readAsBytesSync();
    String base64Image = base64Encode(imageBytes);
    if(image=='cover_image'){
      setState(() {
        uploadImage=true;
        tempCoverImage=imageFile;
        tempCoverImage64=base64Image;
      });}
    else{
      setState(() {
        uploadImage2=true;
        tempProfileImage=imageFile;
        tempProfileImage64=base64Image;
      });}
    debugPrint('ssssssss');

  }

  removeCoverImage(image){
    if(image=='cover_image') {
      setState(() {
        uploadImage = false;
        tempCoverImage64 = '';
        tempCoverImage = null;
      });
    }
    else{
      setState(() {
        uploadImage2=false;
        tempProfileImage= null ;
        tempProfileImage64="";
      });

    }
  }

  uploadCoverImage(image,tempImage) async{

    setState(() {
      isLoading=true;
    });
    var res=await  Shop().uploadShopImages(  this.id ,{image:tempImage });
    if (res!=0){
      Alert(context,"Successfully added image",ShopScreen(id:this.id));
      setState(() {
        uploadImage=false;
        isLoading=false;
      });}
    else {

    }
  }
  openMenu(image){
    changedImage=image;
    //popUp(image);
    _pc.open();
  }
  viewImage(changedImage){
    var child=PhotoView(
      imageProvider: General.mediaUrl(shop[changedImage]),
    );
    PopUp(context, child);
    _pc.close();
  }
  follow(){
    var followId='0';
    if(shop['is_followed'].length>0 )
       followId=shop['is_followed'][0]['id'].toString();
    Follow().followShop({'shop_id':shop['id'] ,"user_id":User().getUserId()}, isFollowed,followId);
    setState(() {
      isFollowed=!isFollowed;
    });
  }
  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return
      new  WillPopScope(onWillPop: _onBackPressed,
          child:new
          Scaffold(
              backgroundColor: Colors.grey.shade300,
              body:SlidingUpPanel (
                  minHeight:0,maxHeight:180, backdropEnabled: true,
                  controller: _pc,
                  panel: Center(
                      child:
                      Column(
                          children:<Widget>[
                            ListTile(onTap: () {viewImage( changedImage );},
                              title: Text("View Image"),
                              leading: Icon(Icons.camera),
                            ),
                            ListTile(onTap: () {getImage( changedImage );},
                              title: Text("Change Image"),
                              leading: Icon(Icons.edit),
                            ),
//             ListTile(
//             title: Text(""
//                 "Delete Image"),
//              leading: Icon(Icons.delete),
//           ),
                          ]
                      )),
                  body:
                  isLoading?ProgressDialogPrimary() :
                  // ProductsScreen()
                  SingleChildScrollView(
                    child :
                    //
                    Stack(
                      children: <Widget>[

                        SizedBox(
                          height: 250,
                          width: double.infinity,
                          child:tempCoverImage!=null?  Image.file(tempCoverImage,fit: BoxFit.fitWidth):shop!=null && shop['cover_image']!=null ?
                          InkWell(child:   Image(image:
                            General.mediaUrl(shop['cover_image'] ),fit: BoxFit.fitWidth,
                          )  ,onTap:() {
                            openMenu('cover_image');

                          },):
                          Center(
                            child:ListTile(onTap: (){getImage('cover_image');},
                              title:
                              new Row(children: <Widget>[
                                Icon(Icons.photo),
                                new Text("Add Cover Image",
                                  style: new TextStyle(
                                      fontSize: 18.0),)
                              ], mainAxisAlignment: MainAxisAlignment.center,),
                              //  leading: Icon(Icons.photo),
                              contentPadding: EdgeInsets.only(left: 4),)
                            ,),
                        ),  uploadImage==true?Positioned(
                          child:RaisedButton( textColor: MYColors.primaryColor(), splashColor:  MYColors.grey()
                            ,child: Text('Upload Image'),onPressed: (){uploadCoverImage('cover_image',tempCoverImage64);},) ,top: 100,left:size.width/3.4,):Container(),
                        uploadImage==true?Positioned(
                          child:RaisedButton( textColor:Colors.red, splashColor:  Colors.red
                            ,child: Text('Cancel'),onPressed: (){removeCoverImage('cover_image',);},) ,top: 150,left:size.width/3.4,):Container(),

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
                                                Text(shop!=null&&shop['name']!=null?shop['name']:"",  style: Theme.of(context).textTheme.title,),
                                                Expanded( child: Container(
                                                    alignment: Alignment.bottomRight,
                                                    child:InkWell(child: Icon( Icons.thumb_up ,textDirection: TextDirection.rtl ,color:isFollowed?MYColors.primaryColor():Colors.black,) ,
                                                      onTap: (){follow(); },)
                                                   ) ,) ],),
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
                                                Text(shop['followed_count']!=null? shop['followed_count'].toString():"0"),
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
                                                Text(shop['FollowedCount']!=null? shop['FollowedCount'].toString():"0"),
                                                Text("Favourites",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 15),)
                                              ],
                                            ),),
                                          ],
                                        ),
                                        Divider(),
                                        SizedBox(height: 10.0),
                                        Row(
                                          children:
                                          shop!=null&& shop['shop_categories']!=null? categories( shop['shop_categories']):<Widget>[Text('')]
                                          ,
                                        )
                                      ],
                                    ),
                                  ),
                                  InkWell(   onTap:() {
                                    openMenu('profile_image');
                                  },
                                      child:
                                      Container(
                                        height: 80,
                                        width: 80,
                                        child:tempProfileImage!=null?  Image.file(tempProfileImage,fit: BoxFit.cover,): Container() ,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(10.0),
                                            image: DecorationImage(
                                                image: shop!=null&&shop['profile_image']!=null?   General.mediaUrl(shop['profile_image'] ):AssetImage('assets/images/fashionLogo.jpeg'),
                                                fit: BoxFit.cover
                                            )
                                        ),
                                        margin: EdgeInsets.only(left: 16.0),
                                      )  ) ,
//                          Positioned(
//                            child: InkWell(child: Icon(Icons.settings ,color: Colors.grey ) ,
//                              onTap: (){getImage('profile_image');}, )
//                            ,top: 0,left:75,),
                                  uploadImage2==true?Positioned(
                                    child:RaisedButton( textColor:  Colors.black//,  color:   Colors.transparent
                                      ,padding: EdgeInsets.all(2)
                                      ,child: Text('Upload Image'),onPressed: (){uploadCoverImage('profile_image',tempProfileImage64);},) ,top: -8,left:96,):Container(),
                                  uploadImage2==true?Positioned(
                                    child:RaisedButton( textColor:Colors.red, splashColor:  Colors.red,padding: EdgeInsets.all(0)
                                      ,child: Text('Cancel'  ),onPressed: (){removeCoverImage('profile_image');},) ,top:  38,left:96,):Container(),

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
          )
      )
    ;
  }
  Widget info (){
    return (
        Column ( children: <Widget>[
          Row(children: <Widget>[
           Container(child:Text( "Information",  style: Theme.of(context).textTheme.title,) ,padding: EdgeInsets.all(15)) ,
            Expanded( child: Container( padding: EdgeInsets.all(15),alignment: Alignment.bottomRight,
                child:InkWell(child:Icon( Icons.edit ,textDirection: TextDirection.rtl) ,onTap: (){    Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => ShopUserFormScreen(shopId: shop['id'].toString()  ))
                );},) ) ,) ],),

          Divider() ,
          shop!=null && shop['phone']!=null?  ListTile(
            title: Text("Phone"),
            subtitle: Text( shop['phone']),
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
            subtitle: Text(shop['email']),
            leading: Icon(Icons.email),
          ):Container(),

          shop!=null && shop['website']!=null?   ListTile(
            title: Text("Website"),
            subtitle: Text( shop['website']),
            leading: Icon(Icons.web),
          ):Container(),
          shop!=null && shop['address']!=null?   ListTile(
            title: Text("Address"),
            subtitle: Text( shop['address']),
            leading: Icon(Icons.person),
          ):Container(),
          ListTile(
            title: Text("Joined Date"),
            subtitle: Text(General.getDate(shop!=null ?shop['created_at']:null,time: false,year: true)  ),
            leading: Icon(Icons.calendar_view_day),
          ),
        ],));
  }


  Widget products( ){
    ///**/
    return  (
        Column(children: <Widget>[

          Container(  decoration: BoxDecoration(
            //  color:MYColors.grey(),
            borderRadius: BorderRadius.circular(5.0),
          ),
              margin: EdgeInsets.only(top: 0),    child:ListTile(title: Text("Our products",style: TextStyle(fontSize: 20,color: MYColors.primaryColor()),),)),
          ListTile(

            title:RaisedButton.icon(icon: Icon(Icons.add ,color: Colors.white,) , color:MYColors.primaryColor(),
              label:  Text(
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
                  itemCount:  shop==null || shop['products'] == null ? 0 : shop['products'] .length ,
                  itemBuilder: (context, index) {
                    //  return _buildImageColumn(data[index]);
                    return
                        ProductScreen(product: shop['products'] [index] );
                  }
              ))
        ]
        )
    );
  }

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
                                            } ,child:Image(image:  General.mediaUrl(url['name']) ,)
                                            ),
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
    return( ProductScreen(product: item)
//        Container(color: MYColors.grey2(),margin: EdgeInsets.only(bottom: 30),
//          child: Column(
//            children: <Widget>[
//              Stack(
//                children: <Widget>[
//                  InkWell(onTap: (){ Navigator.push(
//                      context,
//                      MaterialPageRoute(builder: (context) => ProductsDetailsScreen(  id:item['id'].toString(),product:item )
//                      ));
//                  },child:  Container(
//                    height: 350,
//                    width: double.infinity,
////                decoration: BoxDecoration(
////                        borderRadius: BorderRadius.circular(10.0),
////                         image:  item['images']!=null&&item['images'].length==1?DecorationImage(
////                            image: CachedNetworkImageProvider(General.mediaUrl(item['images'][0]['name'])),
////                            fit: BoxFit.contain
////                        ):null
////                    ) ,
//                    child:item['images']!=null && item['images'].length>0? imageSlider(item['images'],item['id'].toString(), item ):Container(),
//                  )),
//
//                ],
//              ),
//              Padding(
//                padding: const EdgeInsets.only(left: 10.0, right: 4.0, bottom: 16.0),
//                child: Column(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                    Row(children: <Widget>[
//                      Expanded(child: Text( General.getDate(item['created_at'],time:true)),),
//                      IconButton(icon: Icon(Icons.share), onPressed: (){},)
//                      ,  IconButton(icon: Icon( Icons.favorite   ,size: 30 ),onPressed: (){},) ,
//
//                    ],),
//                    Text(item['name'].toString() , style: Theme.of(context).textTheme.title,),
//                    Divider(),
//                    SizedBox(height: 10.0,),
//                    Row(children: <Widget>[
//                      Icon(Icons.favorite_border),
//                      SizedBox(width: 5.0,),
//                      Text("20.2k"),
//                      //  SizedBox(width: 16.0,),
//                      // Icon(Icons.comment),
//                      //SizedBox(width: 5.0,),
//                      // Text("2.2k"),
//                    ],),
//                    SizedBox(height: 10.0,),
//                    Text(item['details'] == null ? '':item['details'].length>20? item['details'].substring(0,20)+"..." :item['details'], textAlign: TextAlign.justify,)
//                  ],
//                ),
//              ),
//            ],
//          ),
//        )
    );
  }
}