import 'dart:developer';


import 'package:flutter/material.dart';
import 'package:flutterapp3/Widget/bezierContainer.dart';
import 'package:flutterapp3/general/colors.dart';
import 'package:flutterapp3/store/user.dart';
import 'package:flutterapp3/user/login.dart';

import 'package:google_fonts/google_fonts.dart';

class SignUpPage extends StatefulWidget {
  SignUpPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  int _Role =0;
  Widget _backButton() {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Row(
          children: <Widget>[
            Container(
              padding: EdgeInsets.only(left: 0, top: 10, bottom: 10),
              child: Icon(Icons.keyboard_arrow_left, color: Colors.black),
            ),
            Text('Back',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500))
          ],
        ),
      ),
    );
  }

  Widget _entryField(String title, TextEditingController controller,{bool isPassword = false,bool isCheckBox}) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
          ),
          SizedBox(
            height: 10,
          ),
          TextField(controller: controller,
              obscureText: isPassword,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  fillColor: Color(0xfff3f3f4),
                  filled: true)),

        ],
      ),
    );
  }

  Widget _submitButton() {
    return
      InkWell(child:
      Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.symmetric(vertical: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(5)),
            boxShadow: <BoxShadow>[
              BoxShadow(
                  color: Colors.grey.shade200,
                  offset: Offset(2, 4),
                  blurRadius: 5,
                  spreadRadius: 2)
            ],
            gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                colors: [Color(0xfffbb448),   MYColors.primaryColor()])),
        child: Text(
          'Register Now',
          style: TextStyle(fontSize: 20, color: Colors.white),
        ),
      ),onTap: (){
        visible?null: userRegister();
      });
  }

  Widget _loginAccountLabel() {
    return InkWell(
      onTap: () {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => LoginPage()));
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        padding: EdgeInsets.all(15),
        alignment: Alignment.bottomCenter,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Already have an account ?',
              style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              width: 10,
            ),
            Text(
              'Login',
              style: TextStyle(
                  color: MYColors.primaryColor(),
                  fontSize: 14,
                  fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }

  Widget _title() {
    return RichText(
      textAlign: TextAlign.center,
      text: TextSpan(
          text: 'F',
          style: GoogleFonts.portLligatSans(
            textStyle: Theme.of(context).textTheme.display1,
            fontSize: 30,
            fontWeight: FontWeight.w700,
            color: MYColors.primaryColor(),
          ),
          children: [
            TextSpan(
              text: 'ash',
              style: TextStyle(color: Colors.black, fontSize: 30),
            ),
            TextSpan(
              text: 'ion',
              style: TextStyle(color: MYColors.primaryColor(), fontSize: 30),
            ),
          ]),
    );
  }
    _handleRadioValueChange(int value) {
    setState(() {
      _Role = value;
    });
  }
  Widget _emailPasswordWidget() {
    return Column(   crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
    _entryField("Name",nameController),
    _entryField("Email",emailController),
    _entryField("Password",passwordController, isPassword: true),

     Container(padding: EdgeInsets.only(top: 5),
      child: Text('Register as', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)),
    Row(children: <Widget>[
    new Radio(
    value: 2,
    groupValue: _Role,
    onChanged: _handleRadioValueChange,
    ),    Container(padding: EdgeInsets.only(top: 5),
          child: Text('As a user', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)),]),

    Row(children: <Widget>[

    new Radio(
    value: 3,
    groupValue: _Role,
    onChanged: _handleRadioValueChange,
    ), Container(padding: EdgeInsets.only(top: 5),
          child: Text('As a shop', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),)),
    ]
    )
        ]);
  }
  // For CircularProgressIndicator.
  bool visible = false ;

  // Getting value from TextField widget.
  final emailController    = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  Future userRegister() async{

    // Showing CircularProgressIndicator.

    // Getting value from Controller
    String email = emailController.text;
    String password = passwordController.text;
    String name = nameController.text;
    String role_id = _Role.toString();
    if (email=='' ||  password=='' ||name==''  ) {
      setState(() {
        visible = false;
      });
      return;
    }
    setState(() {
      visible = true ;
    });

    // SERVER register API UR

    // Store all data with Param Name.
    var data = {'email': email, 'password' : password,'name':name,'role_id':role_id};
     log('data: $data');
    // Starting Web API Call.
    var user=new User();
    var response = await user.register(data,context);// await http.post(url,headers: {"Content-Type": "application/json"}, body: json.encode(data));
    //  log('data: $response');
    // Getting Server response into variable.
    Map<String, dynamic> bodyContent =  response;

    // If the Response Message is Matched.
    String message="";
    if(bodyContent['succes'] )
    {   setState(() {
      visible = false ;
    });
    log('data: $bodyContent');
    // Hiding the CircularProgressIndicator
    // Navigate to Profile Screen & Sending Email to Next Screen.
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text( "Successfully  Registration ,please login"),
          actions: <Widget>[
            FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();

              },
            ),
          ],
        );
      },
    );
    Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => LoginPage())
    );

    }
    else if(bodyContent['error']!=''){

      // If Email or Password did not Matched.
      // Hiding the CircularProgressIndicator.
      setState(() {
        visible = false;
      });
      var errmsg='';
      Map<String,dynamic> err=bodyContent['error'];
      err.forEach((k,v)=>

      // debugPrint(v[0]),
      errmsg=v[0]
      );

      // Showing Alert Dialog with Response JSON Message.
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: new Text( errmsg),
            actions: <Widget>[
              FlatButton(
                child: new Text("OK"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );}

  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(resizeToAvoidBottomPadding: false,
      body: Container(
        height: height,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: -MediaQuery.of(context).size.height * .15,
              right: -MediaQuery.of(context).size.width * .4,
              child: BezierContainer(),
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(height: height * .2),
                    _title(),
                    SizedBox(
                      height: 50,
                    ),
                    _emailPasswordWidget(),
                    SizedBox(
                      height: 20,
                    ),
                    _submitButton(),
                    Visibility(
                        visible: visible,
                        child: Container(
                            margin: EdgeInsets.only(bottom: 30),
                            child: CircularProgressIndicator()
                        )
                    ),
                    //   SizedBox(height: height * .14),
                    _loginAccountLabel(),
                  ],
                ),
              ),
            ),
            Positioned(top: 40, left: 0, child: _backButton()),
          ],
        ),
      ),
    );
  }
}
