import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp3/Widget/appBar.dart';
import 'package:flutterapp3/Widget/myDrawer.dart';
import 'package:flutterapp3/general/Loading.dart';
import 'package:flutterapp3/general/Styles.dart';
import 'package:flutterapp3/general/colors.dart';
import 'package:flutterapp3/general/ganeral.dart';
import 'package:flutterapp3/general/translator.dart';
import 'package:flutterapp3/main.dart';
import 'package:flutterapp3/notification.dart';
import 'package:flutterapp3/pages/about.dart';
import 'package:flutterapp3/products/productScreen.dart';
import 'package:flutterapp3/products/category.dart';
import 'package:flutterapp3/products/searchScreen.dart';
import 'package:flutterapp3/products/shops.dart';
import 'package:flutterapp3/store/product.dart';
import 'package:flutterapp3/store/setting.dart';
import 'package:flutterapp3/store/user.dart';
import 'package:flutterapp3/user/login.dart';
import 'package:flutterapp3/user/profile.dart';
import 'package:flutterapp3/products/shopUserForm.dart';
import 'package:flutterapp3/user/setting.dart';
import 'package:flutterapp3/user/welcomePage.dart';
import 'package:getflutter/components/carousel/gf_carousel.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  final String title;

  @override
  HomeScreenState createState() => HomeScreenState();
  HomeScreen({Key key, this.title}) : super(key: key);

}
class HomeScreenState extends State<HomeScreen>    with TickerProviderStateMixin{
  List products;
  int last_page=10;
  bool visible=true;
  int page=1;
  User user=new User();
  final ScrollController controller=new ScrollController();
  GlobalKey<ScaffoldState>_scaffoldKey=new GlobalKey<ScaffoldState>();
  HomeScreenState( );
  static const String _title = 'Flutter Code Sample';
   AppTranslations AppTrans;
  String lang;
  final List<String> imageList = [
    "https://cdn.pixabay.com/photo/2015/04/25/20/20/dress-739665_960_720.jpg",
    "https://image.shutterstock.com/image-photo/amused-beautiful-young-woman-pink-600w-594774212.jpg",
    "https://cdn.pixabay.com/photo/2016/08/26/20/44/elan-1623085_960_720.jpg",

    "https://image.shutterstock.com/image-photo/street-fashion-woman-look-fashionista-600w-579909655.jpg",

  ];
  Future<void> initState()   {
    controller.addListener(_scrollListener);
    super.initState();
    initData();


  }

  _scrollListener(){

    if (controller.position.pixels==controller.position.maxScrollExtent){
      if(page<=last_page)
        getJSONData();
      else
        setState(() {
          visible=false;
        });
    }
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
  Future<String> getJSONData() async {
    var response = await  Product().getProducts( page,false);

    setState(() {
      if (products!=null)
        products.addAll(response['data']['data']) ;
      else
        products=response['data']['data'];
      page++;
      if(response['data']['last_page']!=null)
        last_page=response['data']['last_page'];

    });
    return "Successfull";
  }
  Widget popup(BuildContext context,url) {
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
                  borderRadius:BorderRadius.all(new Radius.circular(10)),color: Colors.white
              ),
                width: MediaQuery.of(context).size.width - 30,
                height: MediaQuery.of(context).size.height -  80,
                padding: EdgeInsets.all(10),
                // color: Colors.white,
                child:  SingleChildScrollView (child:Container(
                    child:Column(
                      children: <Widget>[
                        Container(//width: double.infinity,
                            height: 400,
                            decoration: new BoxDecoration(
                                borderRadius:BorderRadius.all(new Radius.circular(20))
                            ),
                            margin: EdgeInsets.only(left:8.0,right: 8,top: 0),
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
                                            child: Image.network(
                                              url,
                                              fit: BoxFit.contain,
                                            ),
                                          ),
                                        ),
                                      ],
                                      ),
                                    ),
                                    Divider(),
                                    //  Container( alignment: Alignment(-1.6, 18), child:   Icon( favorite ,color: Colors.red ,size: 44 ),),
                                    Container(
                                        child:
                                        Column(  //height: 40,padding:EdgeInsets.all(5),
                                          children: <Widget>[
                                            Container( child: Row(
                                              children: <Widget>[
                                                 Text( AppTrans.text("Price")+" : "  ,style: TextStyle(fontSize: 20),),   Text("20" , style: TextStyle(fontSize: 20),)
                                              ],),

                                            ),
                                            Divider(),
                                            Container( child: Row(
                                              children: <Widget>[
                                                 Text( AppTrans.text("Price")+" : " ,style: TextStyle(fontSize: 20),),   Text( "" ,style: TextStyle(fontSize: 20),)
                                              ],),

                                            ),
                                          ]
                                          ,)
                                    )
                                    ,Divider()
                                  ],
                                ) ))
                      ],)), ),
              ));
        });

  }
  Widget homeProducts(){
    return Container (

        child:  ListView.builder(shrinkWrap: true,  physics: NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(0.0),

            itemCount:  products==null  ? 0 : products.length,
            itemBuilder: (context, index) {

              return ProductScreen(product: products[index]);//.showProduct(products[index] ,context);
            }
        )
    );
  }
  Future<bool> _onBackPressed( ) async{

    //Navigator.pop(context);
    // exit(0);
  }
  @override
  Widget build(BuildContext context) {

    if (products==null){
     this.getJSONData();
    }
    PageController _pageController;
    int _page = 0;
    final textTheme = Theme.of(context).textTheme;
    const IconData favorite = IconData(0xe87d, fontFamily: 'MaterialIcons');
    List drawerItems = [
      {
        "icon": Icons.add,
        "name": "New Shop",
        'route':ShopUserFormScreen()
      },
      {
        "icon": Icons.store,
        "name": "My Shops",
        'route':Shops(isMyShops: true )
      },
      {
        "icon": Icons.supervised_user_circle,
        "name": user.isLogedIn()? "My Account" :"Login",
        "route": user.isLogedIn()?Profile() :LoginPage(),
      },
      {
        "icon": Icons.settings,
        "name": "Setting",
        "route":Setting()
      },
      {
        "icon": Icons.language,
        "name": "Change language",
        "route":MyApp()
      },
//      User().isLogedIn()? {
//        "icon": Icons.edit,
//        "name": "Edit My Informations",
//        'route':ShopUserFormScreen()
//
//      }:{
//        "name": "",},
      {
        "icon": Icons.info,
        "name": "About Us",
        "route":About()
      },
      user.isLogedIn()? {
        "icon": Icons.exit_to_app,
        "name": "Logout",

      }:{
        "name": "",},
    ];
    return
      !visible?   new WillPopScope(  //onWillPop:  _onBackPressed ,
          child:
          Scaffold(key: _scaffoldKey,
              appBar: MyAppBar .getAppBar(context,_scaffoldKey),
              drawer: MyDrawer(),
              body: RefreshIndicator (onRefresh: ()async{
                setState(() {
                  page=1;
                  products=null;
                  getJSONData();
                  visible=true;
                });
              },
              child: SingleChildScrollView(
                  controller: controller,
                  child:
           //  homeProducts())
              Container( color: MYColors.grey(),
                  //padding: const EdgeInsets.fromLTRB(0.0,10,0,10),
                  child: Align(
                    child: Column(  crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
//                      Container(decoration: BoxDecoration(   color: Colors.white,
//                        boxShadow: [
//                        BoxShadow(
//                          color: Colors.grey.withOpacity(0.5),
//                          spreadRadius: 1,
//                          blurRadius: 5,
//                          offset: Offset(0, 3), // changes position of shadow
//                        ),
//                      ],
//                      ),
//                      height: 50,
//                        child: Row(
//                          children: <Widget>[
//                            Expanded(flex:1,
//                                child:
//                                Container(padding: const EdgeInsets.fromLTRB(0.0,15,0,15),
//                                  decoration: BoxDecoration(border: Border(right: BorderSide(width: 3,color: MYColors.fontGreyTransparent())),  ) ,height: 50,
//                                  child:InkWell(onTap: (){
//                                    Navigator.push(
//                                        context,
//                                        MaterialPageRoute(builder: (context) => Shops( isMyShops: false))
//                                    );},
//                                    child:   Text( AppTrans.text("Stores"
//                                      ,textAlign: TextAlign.center,
//                                      style:GoogleFonts.josefinSans( fontWeight:  FontWeight.bold, color: MYColors.fontGrey(),fontSize: 23)  ,),)
//                                  ,
//                                )),
//                            Divider(),
//                            Expanded(flex:1,
//                                child: InkWell( onTap:(){CategoryScreen().popup(context,imageList); },child:
//                                 Text( AppTrans.text("Cateogry" ,textAlign: TextAlign.center, style:GoogleFonts.josefinSans( fontWeight:  FontWeight.bold,color: MYColors.fontGrey(),fontSize: 23) )  )
//                            ) ],
//                        ),
//                      ),
                        Container(color:Colors.white ,
                          margin:EdgeInsets.only(top:0),padding: EdgeInsets.symmetric( horizontal: 15,vertical: 15),

                          child:
                          Column(crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Container(child: Text( AppTrans.text('ADS'),
                                  style:  Styles(lang).headerText)
                                  ,padding: EdgeInsets.only(left: 10,top:10),)
                                , Divider(),
                                GFCarousel(height: 100,viewportFraction: .3,
                                  items: imageList.map(
                                        (url) {
                                      return
                                        Container(
                                          child: Column(
                                            children: <Widget>[
//                                    Container(
//                                        height: 30,  margin: EdgeInsets.only(left:30.0,right: 30,top:20),
//                                        decoration: new BoxDecoration(color: MYColors.primaryColor(),
//                                            borderRadius:BorderRadius.only( topRight: new Radius.circular(10),topLeft: new Radius.circular(10) )
//                                        ),
//                                        child:Container( padding: EdgeInsets.fromLTRB(0,4,0,0), width: double.infinity, child:  Text( AppTrans.text("4 Remaining" ,textAlign: TextAlign.center  ,
//                                        style: TextStyle(color: Colors.white,fontSize: 20) ) , )),
                                              Container(height: 100,
                                                  decoration: new BoxDecoration(
                                                      boxShadow: [
                                                        BoxShadow(
                                                          color: Colors.grey.withOpacity(0.3),
                                                          spreadRadius: 1,
                                                          blurRadius: 2,
                                                          offset: Offset(3, 3), // changes position of shadow
                                                        ),
                                                      ],
                                                      borderRadius:BorderRadius.all(new Radius.circular(20))
                                                  ),
                                                  margin: EdgeInsets.only(left:8.0,right: 8,top: 0),
                                                  child:
                                                  Container(  decoration: new BoxDecoration(color: MYColors.grey1(),
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
                                                                  child:InkWell(onTap: (){//popup(context,url);
                                                                  } ,child:
                                                                  Image.network(
                                                                    url,
                                                                    fit: BoxFit.cover,
                                                                  )),
                                                                ),
                                                              ),
//                                                              Align(alignment: Alignment.bottomRight,
//                                                                child:Container(padding: EdgeInsets.all(5), child: IconButton(icon: Icon( favorite  ,size: 40 ),onPressed: (){},)),
//                                                              )
                                                            ],
                                                            ),
//
                                                          ),
                                                          Divider(),
                                                          //  Container( alignment: Alignment(-1.6, 18), child:   Icon( favorite ,color: Colors.red ,size: 44 ),),

                                                          Flexible(flex:1,
                                                              child:
                                                              Container(  height: 40,padding:EdgeInsets.all(5),
                                                                //  decoration: new BoxDecoration(border: new Border.fromBorderSide(new BorderSide(width:1px))),
                                                                child:  Row(
                                                                  children: <Widget>[
                                                                     Text( AppTrans.text("Price")  ,style: TextStyle(fontSize: 20),)
                                                                  ],
                                                                ),)
                                                          )

                                                        ],
                                                      )
                                                  )

                                              )
                                            ],),
                                        );

                                    },
                                  ).toList(),
                                  onPageChanged: (index) {
//                          setState(() {
//                            index;
//                          });
                                  },
                                ),] ),),
                        Divider(),
                        Container(color: Colors.white,width: double.infinity,
                          child:   Text( AppTrans.text('Last Collections'),style:   Styles(lang).headerText , ),
                          // margin: EdgeInsets.only(left:15,top:15),
                          padding: EdgeInsets.symmetric(horizontal: 20,vertical: 10 ),
                        ),
                        //  Divider(),
                        Container(child: products!=null&& products.length!=0 ? homeProducts():Container()
                            ,padding: EdgeInsets.only(left: 15,right: 15))
                        ,  visible? CircularProgressIndicator(
                          // valueColor: new AlwaysStoppedAnimation<Color>(AppColors.themeColorSecondary),
                        ):Container()

                      ],
                    ),
                  )))
              ))
      ):ProgressDialogPrimary();
  }
}