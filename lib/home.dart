import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutterapp3/likes.dart';
import 'package:flutterapp3/general/colors.dart';
import 'package:flutterapp3/likes.dart';
import 'package:flutterapp3/myMessages1.dart';
import 'package:flutterapp3/notification.dart';
import 'package:flutterapp3/products/addEditProduct.dart';
import 'package:flutterapp3/products/category.dart';
//import 'package:flutterapp3/products/shop.dart';
import 'package:flutterapp3/products/shopScreen.dart';
import 'package:flutterapp3/products/shops.dart';
import 'package:flutterapp3/store/user.dart';
import 'package:flutterapp3/user/login.dart';
import 'package:flutterapp3/user/profile.dart';
import 'package:flutterapp3/user/shopUserForm.dart';
import 'package:flutterapp3/user/welcomePage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:getflutter/getflutter.dart';
class HomeWidget extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';
  navigateRoute (context){
//     Navigator.push(
//         context,
//         MaterialPageRoute(builder: (context) => LoginUser( ))
//     );
  }
  final List<String> imageList = [
    "https://cdn.pixabay.com/photo/2015/04/25/20/20/dress-739665_960_720.jpg",
    "https://image.shutterstock.com/image-photo/amused-beautiful-young-woman-pink-600w-594774212.jpg",
    "https://cdn.pixabay.com/photo/2016/08/26/20/44/elan-1623085_960_720.jpg",
    "https://cdn.pixabay.com/photo/2016/03/27/19/28/fashion-1283863_960_720.jpg",
    "https://image.shutterstock.com/image-photo/street-fashion-woman-look-fashionista-600w-579909655.jpg",
    "https://cdn.pixabay.com/photo/2020/02/05/11/06/portrait-4820889_960_720.jpg"
  ];
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
                 Text("Price : " ,style: TextStyle(fontSize: 20),),  Text(" 200" ,style: TextStyle(fontSize: 20),)
               ],),

            ),
            Divider(),
              Container( child: Row(
                children: <Widget>[
                  Text("Price : " ,style: TextStyle(fontSize: 20),),  Text(" 200" ,style: TextStyle(fontSize: 20),)
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
  @override
  Widget build(BuildContext context) {
    PageController _pageController;
    int _page = 0;
    final textTheme = Theme.of(context).textTheme;
    const IconData favorite = IconData(0xe87d, fontFamily: 'MaterialIcons');
    List drawerItems = [
      {
        "icon": Icons.add,
        "name": "New Product",
        'route':AddProductScreen()
      },
      {
        "icon": Icons.store,
        "name": "My Shops",
         'route':Shops(true)
      },
      {
        "icon": Icons.supervised_user_circle,
        "name":User().isLogedIn()? "My Account  " :"Login",
        "route":User().isLogedIn()?Profile() :WelcomePage(),
      },
      {
        "icon": Icons.settings,
        "name": "Setting    ",
      },
      User().isLogedIn()? {
        "icon": Icons.edit,
        "name": "Edit My Informations",
        'route':ShopUserFormScreen()

      }:{
        "name": "",},
      {
        "icon": Icons.info,
        "name": "About Us    ",
      },
       User().isLogedIn()? {
        "icon": Icons.exit_to_app,
        "name": "Logout",

      }:{
        "name": "",},
    ];
    return MaterialApp(
        theme: ThemeData(
          primaryColor:     MYColors.primaryColor(),
          textTheme: TextTheme(
            headline: GoogleFonts.tajawal(fontStyle: FontStyle.normal ,fontWeight: FontWeight.w700 ),
            title: GoogleFonts.tajawal(fontStyle: FontStyle.normal ,fontWeight: FontWeight.w700 ),
            body1:  GoogleFonts.tajawal(fontStyle: FontStyle.normal   ),

          ),
        ),
        home: Scaffold(
            appBar: AppBar( // backgroundColor: Color(0xFFFF1728),
              title:   Text('Fashion'  ,  style:  GoogleFonts.tajawal( color: Colors.white,fontSize: 28) ),
              iconTheme: new IconThemeData(color: Colors.white),
            ),
            drawer: Drawer(
              child: ListView(
                children: <Widget>[
                  DrawerHeader(decoration: BoxDecoration(color: Colors.black),
                    child:
                    Column(crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                    Text(
                      "Fashion",
                      style: TextStyle(fontSize: 23,
                          color:  MYColors.primaryColor()
                      ),
                    ),
                      Container( decoration: BoxDecoration(color: Colors.black),
                        child: Image(image: AssetImage("assets/images/fashionLogo.jpeg"),width:100,),
                      ),

                    ]
                    )
                  ), User().getUser()!=null?Container(padding: EdgeInsets.all(  2),
                      decoration: BoxDecoration(color: MYColors.grey()),
                      child:   ListTile(
                          leading:Image  ( width: 50,height: 150,
                            image: AssetImage('assets/images/user-profile.png'),
                          ),
                          // title:  Text("From"+ item['title']  ),
                          title:  Container(
                              child:Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    //   Image  ( width: 50 , image: AssetImage('assets/images/dress3.png')),
                                    Container(
                                        padding: const EdgeInsets.fromLTRB(9, 0, 9, 0),
                                        child:Text( User().getUser()!=null? User().getUser()['name'].toUpperCase():'' ,style:TextStyle(fontSize: 18),)
                                    )

                                    // Divider()
                                  ]
                              )
                          )

                      )):Text(''),
                  
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: drawerItems.length,
                    itemBuilder: (BuildContext context, int index) {
                      Map item = drawerItems[index];
                      return ListTile(
                        leading: Icon(
                          item['icon'],
                          color: _page == index
                              ?Theme.of(context).primaryColor
                              :Theme.of(context).textTheme.title.color,
                        ),
                        title: Text(
                          item['name'],
                          style: TextStyle(
                            color: _page == index
                                ?Theme.of(context).primaryColor
                                :Theme.of(context).textTheme.title.color,
                          ),
                        ),
                        onTap: (){
                        //  _pageController.jumpToPage(index);
                          Navigator.of(context).pop();
                          if(item['name']=='Logout')
                            User().logout(context);
                          else
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) =>  item['route'])
                          );
                        },
                      );
                    },

                  ),
                ],
              ),
            ),
            body: SingleChildScrollView(child:

            Container(color: MYColors.grey(),
                //padding: const EdgeInsets.fromLTRB(0.0,10,0,10),
                child: Align(
                  child: Column(  crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      Container(
                         color: Colors.white,height: 50,
                        child: Row(
                          children: <Widget>[
                            Expanded(flex:1,
                                child:
                                Container(padding: const EdgeInsets.fromLTRB(0.0,15,0,15),
                                  decoration: BoxDecoration(border: Border(right: BorderSide(width: 1,color: MYColors.fontGreyTransparent())),  ) ,height: 50,
                                  child:InkWell(onTap: (){ Navigator.push(
                                      context,
                                      MaterialPageRoute(builder: (context) => Shops( false))
                                  );},
                                    child:  Text("Stores"
                                    ,textAlign: TextAlign.center,
                                    style:GoogleFonts.josefinSans( fontWeight:  FontWeight.bold, color: MYColors.fontGrey(),fontSize: 23)  ,),)
                                 ,
                                )),
                            Divider(),
                            Expanded(flex:1,
                                child: InkWell( onTap:(){CategoryScreen().popup(context,imageList); },child:
                                Text("Cateogry" ,textAlign: TextAlign.center, style:GoogleFonts.josefinSans( fontWeight:  FontWeight.bold,color: MYColors.fontGrey(),fontSize: 23) )  )
                            ) ],
                        ),
                      ),
                      GFCarousel(height: 520,
                        items: imageList.map(
                              (url) {
                            return
                              Container(
                                child: Column(
                                  children: <Widget>[
                                    Container(
                                      height: 30,  margin: EdgeInsets.only(left:30.0,right: 30,top:20),
                                      decoration: new BoxDecoration(color: MYColors.primaryColor(),
                                        borderRadius:BorderRadius.only( topRight: new Radius.circular(10),topLeft: new Radius.circular(10) )
                                    ),child:Container( padding: EdgeInsets.fromLTRB(0,4,0,0), width: double.infinity, child: Text("4 Remaining" ,textAlign: TextAlign.center  ,
                                        style: TextStyle(color: Colors.white,fontSize: 20) ) , )),
                                    Container(height: 400,
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
                                                    child:InkWell(onTap: (){popup(context,url);} ,child:
                                                    Image.network(
                                                        url,
                                                        fit: BoxFit.cover,
                                                    )),
                                                    ),
                                                      ),
                                                       Align(alignment: Alignment.bottomRight,
                                                         child:Container(padding: EdgeInsets.all(5), child: IconButton(icon: Icon( favorite ,color: Colors.red ,size: 40 ),onPressed: (){},)),
                                                       )
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
                                                          Text("Price : 200" ,style: TextStyle(fontSize: 20),)
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
                      ),
                    ],
                  ),
                )))
        )
    );
  }
}
/// This Widget is the main application widget.
class Home extends StatelessWidget {
  static const String _title = 'Flutter Code Sample';

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: _title,
      home: MyStatefulWidget(),
    );
  }
}

class MyStatefulWidget extends StatefulWidget {
  MyStatefulWidget({Key key}) : super(key: key);

  @override
  _MyStatefulWidgetState createState() => _MyStatefulWidgetState();
}

class _MyStatefulWidgetState extends State<MyStatefulWidget> {
  int _selectedIndex = 1;
  static const TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static const List<Widget> _widgetOptions = <Widget>[
    Text(
      'Index 0: Home',
      style: optionStyle,
    ),
    Text(
      'Index 1: Business',
      style: optionStyle,
    ),
    Text(
      'Index 2: School',
      style: optionStyle,
    ),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    const IconData favorite = IconData(0xe87d, fontFamily: 'MaterialIcons');
    const IconData home = IconData(0xe8b6, fontFamily: 'MaterialIcons');
    const IconData notification = IconData(0xe7f4, fontFamily: 'MaterialIcons');
    return Scaffold(

//      body: Center(
//        child: _widgetOptions.elementAt(_selectedIndex),
//      ),
        body: Container(
            child:
            new IndexedStack(

              index: _selectedIndex,
              children: <Widget>[
                new Likes(),// User().getUser()!=null?new MyMessages():new LoginUser(),
                new HomeWidget() ,
                new NotificationsScreen(),
              ],
            )),
        bottomNavigationBar:
        Container(
          padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
          child:
          BottomNavigationBar(selectedLabelStyle: TextStyle(color: MYColors.primaryColor()),

            items: const <BottomNavigationBarItem>[

              BottomNavigationBarItem(
                icon: Icon( favorite ,color: Colors.red ,size: 28 ),
                title: Text('' ),
              ),
              BottomNavigationBarItem(
                icon: Icon(home,size: 28),
                title: Text(''),
              ),
              BottomNavigationBarItem(
                icon: Icon( notification,size: 28 ),
                title: Text(''),
              ),
            ],
            currentIndex: _selectedIndex,backgroundColor: MYColors.grey1(),
            selectedItemColor: MYColors.primaryColor(),showSelectedLabels: false,showUnselectedLabels: false,
            onTap: _onItemTapped,
          ),
        ));
  }
}