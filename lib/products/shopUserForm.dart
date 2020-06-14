import 'dart:developer';
//import 'dart:html';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';
import 'package:flutterapp3/general/alert.dart';
import 'package:flutterapp3/general/Loading.dart';
import 'package:flutterapp3/products/shopScreen.dart';
import 'package:flutterapp3/store/category.dart';
import 'package:flutterapp3/store/shop.dart';
import 'package:flutterapp3/store/user.dart';


class ShopUserFormScreen extends StatefulWidget {
  final String title;
  String shopId="";
  ShopUserFormScreen({Key key, this.title,this.shopId}) : super(key: key);

  @override
  _MyHomePageState createState() => new _MyHomePageState(this.shopId);
}

class _MyHomePageState extends State<ShopUserFormScreen> {
  _MyHomePageState(  this.shopId) ;
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  List<String> _colors = <String>['', 'red', 'green', 'blue', 'orange'];
  String _color = '';
  String shopId;
  var shop;
  bool visible=false;
  final shopNameController=TextEditingController();
  final facebookController=TextEditingController();
  final phoneController=TextEditingController();
  final instagramController=TextEditingController();
  final emailController=TextEditingController();
  final webController=TextEditingController();
  final addressController=TextEditingController();
  dynamic categories=[];
  dynamic shopCategories=[];

   Future getShopsCategories() async {

    var res= await Category().getShopsCategories(1);
    setState(() {
      shopCategories=res;
    });
   }
  Future updateShopDetails() async{

    String shopName= shopNameController.text;
    String facebook= facebookController.text;
    String phone= phoneController.text;
    String instagram= instagramController.text;
    String email= emailController.text;
    String web= webController.text;
    String address= addressController.text;
    if (shopName==''  ) {
      setState(() {
        visible = false;
      });
      return;
    }
    setState(() {
      visible = true ;
    });
    // Store all data with Param Name.
    var data = {'phone': phone, 'email': email, 'facebook' : facebook,'name':shopName,'instagram':instagram ,'website':web ,
      'user_id':User().getUserId(),'shopCategories':categories,
      'address':address  };
    log('data: $data');
    // Starting Web API Call.
    var shop=new Shop();
    var response;
    if(shopId==''|| shopId==null)
      response  = await shop.addShop(data,context);// await http.post(url,headers: {"Content-Type": "application/json"}, body: json.encode(data));
    else
      response = await shop.editShop(data,shopId,context);// await http.post(url,headers: {"Content-Type": "application/json"}, body: json.encode(data));

    //  log('data: $response');
    // Getting Server response into variable.
    Map<String, dynamic> bodyContent =  response;
    setState(() {
      visible = false ;
    });
    // If the Response Message is Matched.
    String message="";
    if(bodyContent['success'] )
    {
      if(shopId==''||shopId==null)
        shopId=response['data']['id'].toString();
      Alert(context,"Successfully  updated shop details",ShopScreen(id:shopId));
    }
    else if(bodyContent['error']!=''){

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
  Future<String> getJSONData() async {
    var res =null;
    setState(() {
      visible=true;
    });
    if(this.shopId !=''  && this.shopId !=null)
      res= await Shop().getShop( this.shopId);

    if(res!=0 && res!=null){
      setState(() {
        shop=res;
        shopNameController.text=shop['name'];
        facebookController.text=shop['facebook'];
        instagramController.text=shop['instagram'];
        phoneController.text=shop['phone'];
        emailController.text=shop['email'];
        webController.text=shop['website'];
        addressController.text=shop['address'];
      });
    }
    setState(() {
      visible=false;
    });
  }
  @override
  Widget build(BuildContext context) {
     if (shopCategories.length==0){
       getShopsCategories();
     }
    return new Scaffold(resizeToAvoidBottomPadding: false,
      appBar: new AppBar(   iconTheme: new IconThemeData(color: Colors.white),
        title: new Text(shopId==""?"Add shop":"Edit ",style: TextStyle(color: Colors.white)),
      ),
      body:
      visible?ProgressDialogPrimary() :
      new SingleChildScrollView(child:
      Column(children: <Widget>[
      SafeArea(
          top: false,
          bottom: false,
          child:
          new Form(
              key: _formKey,
              autovalidate: true,
              child: new ListView(shrinkWrap: true,  physics: NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.person),
                      hintText: 'Enter your shop name',
                      labelText: 'Shop Name',
                    ),controller: shopNameController,

                  ),

                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.phone),
                      hintText: 'Enter your phone number',
                      labelText: 'Phone',
                    ),controller: phoneController,
                    keyboardType: TextInputType.phone,
                    inputFormatters: [
                      WhitelistingTextInputFormatter.digitsOnly,
                    ],
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(

                      icon:  Image(image: AssetImage("assets/images/facebook.png"),width:20,),
                      hintText: 'Enter your faccebook ',
                      labelText: 'Faccebook',
                    ),
                    keyboardType: TextInputType.emailAddress,controller: facebookController,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: Image(image: AssetImage("assets/images/instagram.png"),width:20,),
                      hintText: 'Enter instagram  ',
                      labelText: 'Instagram',
                    ),
                    keyboardType: TextInputType.emailAddress,controller: instagramController,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.email),
                      hintText: 'Enter your email address',
                      labelText: 'Email',
                    ),
                    keyboardType: TextInputType.emailAddress,controller: emailController,
                  ),
                  new TextFormField(
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.web),
                      hintText: 'Enter your website',
                      labelText: 'Website',
                    ),controller: webController,
                    //  keyboardType: TextInputType.,
                  ),

                  TextFormField(  decoration: const InputDecoration(//fillColor:Colors.pink,
                    icon: const Icon(Icons.home),
                    hintText: 'Enter your Address  ',
                    labelText: 'Address',
                  ),controller: addressController,
                    keyboardType: TextInputType.multiline,
                    maxLines: 8,
                    maxLength: 200,
                  ),

                  MultiSelect(
                      autovalidate: true,
                      titleText: 'Category',
                      validator: (value) {
                        if (value == null) {
                          return'';// 'Please select one or more option(s)';
                        }
                        try{
                        setState(() {
                          categories=value;
                        });}
                        catch(d){}
                        return '';
                      },
                      errorText: 'Please select one or more option(s)',
                      dataSource: shopCategories,
                      textField: 'name',
                      valueField: 'id',
                      filterable: true,
                      required: true,
                      value: null,
                      onSaved: (value) {
                        setState(() {
                        });
                        log('llllllllllllllo');
                        print('The value is $value');

                      }
                  ),
//                  new FormField(
//                    builder: (FormFieldState state) {
//                      return InputDecorator(
//                        decoration: InputDecoration(
//                          icon: const Icon(Icons.color_lens),
//                          labelText: 'Color',
//                        ),
//                        isEmpty: _color == '',
//                        child: new DropdownButtonHideUnderline(
//                          child: new DropdownButton(
//                            value: _color,
//                            isDense: true,
//                            onChanged: (String newValue) {
//                              setState(() {
//                                var newContact;
//                                newContact.favoriteColor = newValue;
//                                _color = newValue;
//                                state.didChange(newValue);
//                              });
//                            },
//                            items: _colors.map((String value) {
//                              return new DropdownMenuItem(
//                                value: value,
//                                child: new Text(value),
//                              );
//                            }).toList(),
//                          ),
//                        ),
//                      );
//                    },
//                  ),

                  new Container(
                     // padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                      child: new RaisedButton(
                        child: const Text('Save'),
                        onPressed: (){!visible?updateShopDetails():{};},
                      )),


                ],
              ))),
        new Container(
          // padding: const EdgeInsets.only(left: 40.0, top: 20.0),
          child:    Visibility(
              visible: visible,
              child: Container(
                  margin: EdgeInsets.only(top: 5,bottom: 20),
                  child: CircularProgressIndicator()
              )
          ),),]
      ,)),
    );
  }
  @override
  void initState() {
    super.initState();
    // Call the getJSONData() method when the app initializes
    this.getJSONData();
  }
}