import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutterapp3/general/colors.dart';
import 'package:flutterapp3/general/ganeral.dart';
import 'package:flutterapp3/products/productDetails.dart';

import 'package:flutterapp3/products/shopScreen.dart';
import 'package:flutterapp3/products/shops.dart';
import 'package:flutterapp3/store/shop.dart';
import 'package:google_sign_in/google_sign_in.dart';

class SearchScreen extends StatefulWidget {
  SearchScreen({Key key }) : super(key: key);
  final String title="Setting";
  @override
  _SettingState createState() => _SettingState();
}

class _SettingState extends State<SearchScreen> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _typeAheadController = TextEditingController();
  String _selected ="";

  List data = [];
  bool showResult=false;
  var fetchedPosts;
  getPostsList(pattern) async {
    setState(() {
      showResult=false;
    });
    // new Timer(const Duration(milliseconds: 2000), () async{
    fetchedPosts  = await Shop().getShops( false,searchByName:pattern );
    setState(() {
      data = fetchedPosts;
    });
    //  });


    return data;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
//      appBar: AppBar(   iconTheme: new IconThemeData(color: Colors.white),
//        title: Text(widget.title,style: TextStyle(color: Colors.white), ),
//      ),
        body:
            SingleChildScrollView(child:
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
        Row(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
         Padding(padding  : const EdgeInsets.symmetric(vertical: 40),  child:  Container(
             width: 40 , child:
            FlatButton.icon(onPressed: (){Navigator.pop(context);}, icon:Icon( Icons.arrow_back),padding: EdgeInsets.all(0), label: Text(''),),))
         ,
        Expanded(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Form(
          key: this._formKey,
          child: Padding(
            padding: EdgeInsets.only(top:40.0),
            child: Column(
              children: <Widget>[

                TypeAheadFormField(hideOnError: true,
                  textFieldConfiguration: TextFieldConfiguration(
                      onSubmitted: (term){
                        setState(() {
                          showResult=true;
                        });
                      },
                      textInputAction: TextInputAction.search,
                      controller: this._typeAheadController,
                      decoration: InputDecoration(
                        focusedBorder:  UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(25.7),
                        ),
                        contentPadding: EdgeInsets.only(top: 0,bottom: 0,right: 15,left: 15),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.white),
                          borderRadius: BorderRadius.circular(25.7),
                        ),
                        filled: true,//errorText: "",
                        fillColor: Color.fromRGBO(142, 142, 147, .15),
                        border: new OutlineInputBorder( borderRadius: const BorderRadius.all(
                          const Radius.circular(20.0),
                        ),
                            borderSide: new BorderSide(color: Color.fromRGBO(142, 142, 147, .15)) ),
                        // labelText: 'Search'
                      )
                  ),

                  suggestionsCallback: (pattern) async {
                    if (pattern.length>1) {

                      return await getPostsList(pattern);
                    }
                  },
                  itemBuilder: (context, suggestion) {
                    return

                      ListTile(
                        onTap: (){debugPrint('f'); General.pushRoute(context, ShopScreen(id:suggestion['id'].toString()) );},
                      title: Text(suggestion['name']),
                      leading:    Container  (width: 50,height: 50,
                          decoration: BoxDecoration(color: MYColors.grey1(),
                              borderRadius: BorderRadius.circular(50.0),
                              image: DecorationImage(
                                  image: General.mediaUrl( suggestion['profile_image']),
                                  fit: BoxFit.cover
                              )
                          )
                      ) ,
                    );
                  },
                  transitionBuilder: (context, suggestionsBox, controller) {
                    return   suggestionsBox;
                  },
                  onSuggestionSelected: (suggestion) {
                    this._typeAheadController.text = suggestion['name'];
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please select ';
                    }
                  },
                  onSaved: (value) =>{
                    this._selected  = value   },
                ),
//                SizedBox(height: 10.0,), //SearchBar(),
//                RaisedButton(
//                  child: Text('Submit'),
//                  onPressed: () {
//                    if (this._formKey.currentState.validate()) {
//                      this._formKey.currentState.save();
//                      Scaffold.of(context).showSnackBar(SnackBar(
//                          content: Text('Your Favorite City is ${this._selectedCity}')
//                      ));
//                    }
//                  },
//                )
              ],
            ),
          ),
        )

        ) )]

    ),
              Container(padding: EdgeInsets.symmetric(horizontal: 15), child: Text("Search for : "+_selected ,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),)
           ,Divider(),
               showResult==true?_buildListView():Container()
            ],),)

    );
  }



  Widget _buildListView() {

    return ListView.builder(physics:NeverScrollableScrollPhysics() ,shrinkWrap: true,
        padding: const EdgeInsets.all(5.0),
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (context, index) {
          //  return _buildImageColumn(data[index]);
          return new ShopComponent() .buildRow(data[index],context);
        }
    )
    ;
  }

  @override
  void initState() {
    super.initState();

  }
}