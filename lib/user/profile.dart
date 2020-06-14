
import 'package:flutter/material.dart';
import 'package:flutterapp3/config/url.dart';
import 'package:flutterapp3/general/colors.dart';
import 'package:flutterapp3/store/user.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';
class Choice {
  const Choice({this.id,this.title, this.icon});
  final String id;
  final String title;
  final IconData icon;
}
const List<Choice> choices = const <Choice>[

  const Choice(id:"1", title: 'Log out', icon: Icons.directions_boat),
  const Choice(id:"2",title: 'Edit Account', icon: Icons.directions_bus),

];
class Profile extends StatefulWidget {

  ProfileState createState() => ProfileState();

}
class ProfileState extends State {

  final String name=User().getUser()!=null?User().getUser()['name']:'';
  final String email=User().getUser()!=null?User().getUser()['email']:'';
  final String userId=User().getUser()!=null?User().getUser()['user_id']:'';
  final  Controller = TextEditingController();
  _select(Choice choice)
  {

    if (choice.id=="1")
      User().logout(context);
  }
  @override
  Widget build(BuildContext context) {
     var share=  url+userId ;
    // TODO: implement build
    return MaterialApp(
      theme: ThemeData(  primaryColor:     MYColors.primaryColor(), textTheme: TextTheme(
        body1:  GoogleFonts.tajawal(fontStyle: FontStyle.normal ),
      ),
      ),
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            "Profile ",
          ),
            actions: <Widget>[

              PopupMenuButton<Choice>(
                 onSelected: _select,
                itemBuilder: (BuildContext context) {
                  return choices.map((Choice choice) {
                    return PopupMenuItem<Choice>(
                        value: choice,
                        child: Text(choice.title)
                    );
                  }).toList();
                },
              ),
            ],
        ),

//        backgroundColor: Colors.grey[300],
        body: Container(margin: EdgeInsets.all(20.1),
          child: Align(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                CircleAvatar(
                  radius: 80,
                  backgroundImage: AssetImage('assets/images/user-profile.png'),
                ),
                Container(padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child:     Text(
                    name,
                    style: TextStyle(color:  MYColors.primaryColor(),

                      fontSize: 30,
                    ),
                  ),
                )
              ,
                Container(padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child:     Text(
                    email,
                    style: TextStyle(
                      fontSize: 15,

                      color: Colors.black ,
                      letterSpacing: 0.5,
                    ),
                  ),
                )
            ,
                SizedBox(
                  height: 20.0,
                  width: 200,
                  child: Divider(
                    color: Colors.teal[100],
                  ),
                ),
                Text(
                "رابط حسابك",
                  style: TextStyle(color:  MYColors.primaryColor(),fontWeight: FontWeight.bold,
                    fontSize: 25,
                  ),
                ),
                Container(padding: EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child:      SelectableText( url+userId ,style: TextStyle(fontSize: 18) ),
                )
               ,

                Card(
                    color: Colors.white,
                    margin:
                    EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
                    child: ListTile( onTap: () {

                      final RenderBox box = context.findRenderObject();
                      Share.share(share,
                          subject:  name,
                          sharePositionOrigin:
                          box.localToGlobal(Offset.zero) &
                          box.size);
                    },
                      leading: Icon(
                        Icons.share,
                        color: Colors.teal[900],
                      ),
                      title: Text(
                        ' شارك على وسائل التواصل ',
                        style:
                        TextStyle(  fontSize: 20.0,color:  MYColors.primaryColor(),),
                      ),
                    )),
//                Card(
//                  color: Colors.white,
//                  margin:
//                  EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
//                  child: ListTile(
//                    leading: Icon(
//                      Icons.face,
//                      color: Colors.teal[900],
//                    ),
//                    title: Text(
//                      '08-05-1995',
//                      style: TextStyle(fontSize: 20.0, fontFamily: 'Neucha'),
//                    ),
//                  ),
//                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}