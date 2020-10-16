import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutterapp3/MessageDetails.dart';
import 'package:flutterapp3/Widget/appBar.dart';
import 'package:flutterapp3/Widget/myDrawer.dart';
import 'package:flutterapp3/config/url.dart';
import 'package:flutterapp3/general/Loading.dart';
import 'package:flutterapp3/general/colors.dart';
import 'package:flutterapp3/general/ganeral.dart';
import 'package:flutterapp3/general/translator.dart';
import 'package:flutterapp3/products/searchScreen.dart';
import 'package:flutterapp3/products/shopScreen.dart';
import 'package:flutterapp3/products/shopUserForm.dart';
import 'package:flutterapp3/store/setting.dart';
import 'package:flutterapp3/store/shop.dart';
import 'dart:async';
import 'package:date_util/date_util.dart';
import 'package:flutterapp3/store/user.dart';

class ShopComponent{

  Widget  buildRow(dynamic item,context) {

    return
      ConstrainedBox(constraints: BoxConstraints(maxHeight: 100),
          child:  InkWell( onTap: (){
            Navigator.push(context, MaterialPageRoute(builder: (context)=>ShopScreen( shop: item )) );
          },
              child:
              Container(height: 100,
                  //  padding: const EdgeInsets.fromLTRB(0, 9, 0, 9),
                  margin: const EdgeInsets.symmetric( horizontal: 20,vertical: 10),
                  decoration:new  BoxDecoration(color: Colors.white,
                    borderRadius: new BorderRadius.all (new Radius.circular(10.0)),
                  ) ,

                  child:
                  Container(   child:
                  Row(children: <Widget>[
                    Container  ( width: 80,
                        decoration: BoxDecoration(color: MYColors.grey1(),
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                                image: item['profile_image']!=null? General.mediaUrl(item['profile_image']) :AssetImage('assets/images/fashionLogo.jpeg'),
                                fit: BoxFit.cover
                            )
                        )
                    ),
                    Container(  padding: const EdgeInsets.all(10 ),
                        child:Column(mainAxisAlignment: MainAxisAlignment.spaceAround,crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              //   Image  ( width: 50 , image: AssetImage('assets/images/dress3.png')),
                              Container(
                                  child:Text(  item['name'] ,style:TextStyle(fontSize: 21,fontWeight: FontWeight.bold)//(item['title'].length >=20 )?item['title'].substring(0,20) :item['title']
                                  )
                              )
                              ,  Container(    height: 1, color:Colors.black ,width:200,) ,
                              Container(
                                  child: Row(
                                    children: <Widget>[
                                      //  SizedBox(width: 20.0,),
                                      Icon(Icons.star, color: Colors.yellow),
                                      Icon(Icons.star, color: Colors.yellow),
                                      Icon(Icons.star, color: Colors.yellow),
                                      Icon(Icons.star, color: Colors.yellow),
                                      Icon(Icons.star, color: Colors.yellow),
                                      // SizedBox(width: 5.0,),
//                          Text("5.0 stars", style: TextStyle(
//                              color: Colors.grey,
//                              fontSize: 14.0
//                          ))
                                    ],
                                  )
                              )
                            ]
                        )
                    )
                  ],)

                  )
              )));
  }
}

class Shops extends StatefulWidget {
  Shops({Key key, this.title,this.isMyShops}) : super(key: key);

  final String title;
  final bool isMyShops;
  @override
  _MyHomePageState createState() => _MyHomePageState(isMyShops);
}

class _MyHomePageState extends State<Shops> {
  bool visible=true;
  bool isMyShops=false;
  _MyHomePageState(this.isMyShops);
  List data=null;
  int page=1;
  int last_page=1000;
  final controller=new ScrollController();
  GlobalKey<ScaffoldState>_scaffoldKey=new GlobalKey<ScaffoldState>();
  AppTranslations AppTrans;
  String lang;
  User user=new User();
  Future<String> getJSONData() async {
    setState(() {
      visible= true;
       });
    var response =await Shop().getShops(isMyShops,page:page) ;//await http.get('https://jsonplaceholder.typicode.com/posts',headers: header );
    setState(() {
      visible=false;
      // Get the JSON data
      if (data!=null)
        data.addAll(response['data']['data']) ;
      else
        data=response['data']['data'];
      page++;
      if(response['data']['last_page']!=null)
        last_page=response['data']['last_page'];
    });
    return "Successfull";
  }
  initData() async{
    var lan = await SettingStore().getLanguage();
    await user.init();
    var res=await getJSONData();

    setState(()  {

      lang=lan;
      AppTrans=new AppTranslations(lang);
      AppTrans.load(lang);
      visible=false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return  !visible? Scaffold(
      appBar: MyAppBar.getAppBar(context,_scaffoldKey,title:isMyShops!=null&&isMyShops?AppTrans.text('My Shops'):AppTrans.text('Shops') ),
      drawer: MyDrawer() ,

      body: RefreshIndicator (onRefresh: ()async{
        setState(() {
          page=1;
          data=null;
          getJSONData();
          visible=true;
        });
      },
       child:
        SingleChildScrollView(
        controller:controller ,
        child:
        Container( decoration: BoxDecoration(

        ),
          child:Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              _buildListView(),
              visible? CircularProgressIndicator(
                // valueColor: new AlwaysStoppedAnimation<Color>(AppColors.themeColorSecondary),
              ):Container()
            ],)

          , ),
      ))
      ,):ProgressDialogPrimary()
    ;
  }
  _scrollListener(){
    print( '-----------------');
    if (controller.position.pixels==controller.position.maxScrollExtent){


      if(page<=last_page)
        getJSONData();
      else
        setState(() {
          visible=false;
        });
    }
  }
  Widget _buildListView() {
    if (data == null){
      this.getJSONData();}

    return ListView.builder(
      //  controller: controller,
        shrinkWrap: true,    physics: NeverScrollableScrollPhysics(),
        padding: const EdgeInsets.all(5.0),
        itemCount: data == null ? 0 : data.length,

        itemBuilder: (context, index) {
          //  return _buildImageColumn(data[index]);
          return ShopComponent().buildRow(data[index],context);
        }
    )
    ;
  }


  @override
  void initState() {
    controller.addListener(_scrollListener);
    super.initState();

    initData();
  }
}