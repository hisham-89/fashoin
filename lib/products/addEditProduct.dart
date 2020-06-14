import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_multiselect/flutter_multiselect.dart';
import 'package:flutterapp3/config/icons.dart';
import 'package:flutterapp3/general/alert.dart';
import 'package:flutterapp3/general/Loading.dart';
import 'package:flutterapp3/general/colors.dart';
import 'package:flutterapp3/home.dart';
import 'package:flutterapp3/products/homeScreen.dart';
import 'package:flutterapp3/products/productScreen.dart';
import 'package:flutterapp3/products/productDetails.dart';
import 'package:flutterapp3/store/category.dart';
import 'package:flutterapp3/store/product.dart';
import 'package:flutterapp3/uploadImages.dart';
import 'package:image_picker/image_picker.dart';


//class AddProductScreen extends StatelessWidget {
//  String shopId;
//  AddProductScreen({this.shopId});
//  @override
//  Widget build(BuildContext context) {
//    return new    MyHomePage(title: 'Add product',shopId:this.shopId)
//    ;
//  }
//}

class AddProductScreen extends StatefulWidget {
  String shopId;
  String productId;
  AddProductScreen({Key key, this.title ,this.shopId,this.productId }) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState(this.shopId,this.productId );
}

class _MyHomePageState extends State<AddProductScreen> {
  String shopId;
  String productId="";
  _MyHomePageState(this.shopId,this.productId );
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  dynamic  editProduct =null;
  String _category = '1';
  bool isLoading=false;
  List  colors =[];
  List productColors;
  bool visible=false;
  final titleController=TextEditingController();
  final priceController=TextEditingController();
  final detailsController=TextEditingController();
  dynamic categories=[];
  dynamic shopCategories=[];
  Future getProduct() async {

    var res= await Product().getProductsDetails( productId);
    print(res);
    setState(() {
      editProduct=res;

      titleController.text=res['name'];
      priceController.text=res['price'].toString();
      detailsController.text=res['details'];
      if(res['category_id'].toString()!=null|| res['category_id'].toString()!=0)
      _category =res['category_id'].toString();
      productColors=[1,2];//res['colors'];
    });

  }
  Future<void> initState()   {
    super.initState();
    if(this.productId!="")
      getProduct();
  }
  Future getShopsCategories() async {

    var res= await Category().getShopsCategories(0);
    setState(() {
      shopCategories=res;
      if(this.productId=="")
      _category=shopCategories[0]['id'].toString();
    });

  }
  Future getProductColors() async {

    var res= await Product().getColors();
    setState(() {
      //  shopCategories=res;
      colors=res;
    });
  }
  Future updateShopDetails() async{

    // Getting value from Controller
    String title= titleController.text;
    String price= priceController.text;
    String details= detailsController.text;
    if (title==''  ) {
      setState(() {
        visible = false;
      });
      return;
    }
    setState(() {
      visible = true ;
    });
    var data = {'price': price, 'name': title, 'category_id' : _category, 'colors':productColors,
      'shop_id':shopId.toString(),//'shopCategories':categories,
      'details':details ,'images':images64,  };
    log('data: $data');
    // Starting Web API Call.
    var product=new Product();
    var response ;
    if(productId==''|| productId==null)
        response = await product.addProduct(data,context);// await http.post(url,headers: {"Content-Type": "application/json"}, body: json.encode(data));
    else
        response = await product.editProduct(data,productId,context);// await http.post(url,headers: {"Content-Type": "application/json"}, body: json.encode(data));

    Map<String, dynamic> bodyContent =  response;
    setState(() {
      visible = false ;
    });
    // If the Response Message is Matched.
    String message="";
    if(bodyContent['success'] )
      {   if(productId==''||productId==null)
             productId=response['data']['id'].toString();
      Alert(context,"Successfully  updated shop details",ProductsDetailsScreen (id:productId,));

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
   List <File>_images=[];
  List images64=[];
  final picker = ImagePicker();
   deleteImage(int index){
     setState(() {
       images64.removeAt(index);
       _images.removeAt(index);
     });
    }
  Future getImage() async {
    var  pickedFile = await picker.getImage(source: ImageSource.gallery);

    setState(() {
      File imageFile = new File(pickedFile.path);
      _images.add( imageFile) ;
      List<int> imageBytes = imageFile.readAsBytesSync();
      String base64Image = base64Encode(imageBytes);
      images64.add(base64Image);

    });
  }
  List <Widget> imagesWidget (){
    List <Widget>list=[];
    var index=0;
    _images.asMap().forEach((index, item) =>   {

      list.add(
          new Stack( children: <Widget>[

            new Container( width: double.infinity,height: double.infinity ,
              child:
                 Image.file(item) ,
              ),

            Align(
              alignment: Alignment.center,
              child:Container(padding: EdgeInsets.all(5), child:
              IconButton(icon: Icon( Icons.cancel ,color: Colors.red ,size: 22 ),
                onPressed: () =>   {
                    print(index.toString()),
                    setState(() {
                  images64.removeAt(index);
                  _images.removeAt(index);
                })}
                ,)),
            )
          ],
          ),

      ),
     // index++
    });
    index=0;
    return list;
    }
  @override
  Widget build(BuildContext context) {
    if (shopCategories.length==0){
      getShopsCategories();
    }
    if (colors.length==0){
      getProductColors();
    }
    return new Scaffold(resizeToAvoidBottomPadding: false,
      appBar: new AppBar(
        title: new Text( "Edit "),
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
                 Container(decoration: BoxDecoration(color: MYColors.grey1()),
                   child:Column(crossAxisAlignment: CrossAxisAlignment.start,
                     children: <Widget>[
                   SizedBox(height: 22,),
                   Text('Title' ,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                   new TextFormField(
                     decoration: const InputDecoration(
                       icon: const Icon(Icons.title),
                       hintText: 'Enter title',
                       labelText: 'Product title',
                     ),controller: titleController,
                   ),
                 ],) ,) ,
                    SizedBox(height: 22,),
                    Text('Images' ,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    imageUpload(),

                    Text('Price' ,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    new TextFormField(
                      decoration: const InputDecoration(
                        icon: const Icon(Icons.shop),
                        hintText: 'Enter price',
                        labelText: 'Price',
                      ),controller: priceController,
                      keyboardType: TextInputType.text,
                      inputFormatters: [
                        WhitelistingTextInputFormatter.digitsOnly,
                      ],
                    ),
//                    new TextFormField(
//                      decoration: const InputDecoration(
//
//                        icon:  Image(image: AssetImage("assets/images/facebook.png"),width:20,),
//                        hintText: 'Enter your faccebook ',
//                        labelText: 'Faccebook',
//                      ),
//                      keyboardType: TextInputType.emailAddress,controller: facebookController,
//                    ),
//                    new TextFormField(
//                      decoration: const InputDecoration(
//                        icon: Image(image: AssetImage("assets/images/instagram.png"),width:20,),
//                        hintText: 'Enter instagram  ',
//                        labelText: 'Instagram',
//                      ),
//                      keyboardType: TextInputType.emailAddress,controller: instagramController,
//                    ),
//                    new TextFormField(
//                      decoration: const InputDecoration(
//                        icon: const Icon(Icons.email),
//                        hintText: 'Enter your email address',
//                        labelText: 'Email',
//                      ),
//                      keyboardType: TextInputType.emailAddress,controller: emailController,
//                    ),
//                    new TextFormField(
//                      decoration: const InputDecoration(
//                        icon: const Icon(Icons.web),
//                        hintText: 'Enter your website',
//                        labelText: 'Website',
//                      ),controller: webController,
//                      //  keyboardType: TextInputType.,
//                    ),                  s
                 SizedBox(height: 22,),
                  Text('Available Colors' ,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    MultiSelect(
                        autovalidate: true,
                       // titleText: 'Available Colors',
                        validator: (value) {
                          debugPrint('dddddddddd');
                         // value=[1,2];
                          if (value == null) {
                            return'';// 'Please select one or more option(s)';
                          }
                          try{
                            print(value);
                            setState(() {
                              productColors=value;
                            });}
                          catch(d){}
                          return '';
                        },
                        errorText: 'Please select one or more option(s)',
                        dataSource: colors,
                        value: productColors,
                        textField: 'name',
                        valueField: 'id',
                        filterable: true,
                        required: false,
                        //initialValue: 1,

                        onSaved: (value) {
                          setState(() {
                          });
                         // print('The value is $value');
                        }
                    ),
                    Text('Category' ,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    Divider(),
                  new FormField(
                    builder: (FormFieldState state) {
                      return InputDecorator(
                        decoration: InputDecoration(
                          icon: const Icon(Icons.category),
                         // labelText: 'Category',
                        ),
                        isEmpty: _category == '',
                        child: new DropdownButtonHideUnderline(
                          child: buildDropdownButton(shopCategories,_category)
                        ),
                      );
                    },
                  ), SizedBox(height: 22,),
                    Divider(),
                    Text('Details' ,style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),),
                    TextFormField(  decoration: const InputDecoration(//fillcategory:categorys.pink,
                      icon: const Icon(Icons.details),
                      hintText: 'Enter your Details  ',
                      labelText: 'Details',fillColor:  Colors.grey,
                    ),controller: detailsController,
                      keyboardType: TextInputType.multiline,
                      maxLines: 8,
                      maxLength: 200,
                    ),
                    new Container(
                      // padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                      child:    Visibility(
                          visible: visible,
                          child: Container(
                              margin: EdgeInsets.only(top: 5,bottom: 20),
                              child: CircularProgressIndicator()
                          )
                      ),),
                    new Container(
                      // padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                        child: new RaisedButton(color: MYColors.primaryColor(),
                          child: const Text('Save' ,style: TextStyle(color: Colors.white),),
                         // onPressed: (){!visible?updateShopDetails():{};},
                          onPressed: (){ updateShopDetails() ;},
                        )),


                  ],
                ))),
       ]
        ,)),
    );
  }


  Widget imageUpload () {
    var size = MediaQuery.of(context).size;
    final double itemHeight = (size.height - kToolbarHeight - 24) / 2;
    final double itemWidth = size.width / 2;

    return( Container(
      padding: EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          OutlineButton(
            onPressed: getImage,
            child: Text('Choose Images'),
          ),
          SizedBox(
            height: 5.0,
          ),
          _images.length == 0
          ? Text('No image selected.')
           :
          GridView.count( shrinkWrap: true,  physics: NeverScrollableScrollPhysics(),
            primary: false,
            padding: const EdgeInsets.all(2),
            crossAxisSpacing: 10,
            mainAxisSpacing: 1,
            crossAxisCount: 3,
            children:  imagesWidget(),
         //childAspectRatio: (itemWidth / itemHeight),
          ),
        ],
      ),
    )
    );
}
  Widget buildDropdownButton(   items, String selectedValue) {
    return DropdownButton<String>(
      isExpanded: true,
      value: selectedValue,
        onChanged: (String newValue) {
               setState(() {
               var newContact;
               _category = newValue;
                //   state.didChange(newValue);
                              });
                            },
      items: items.map<DropdownMenuItem<String>>((  value1) {
        var a = value1['id'].toString();
        if(value1!=null)
          return DropdownMenuItem<String>(
          value: value1['id'].toString(),
          child: Text(value1['name'] ),
        );
      }).toList(),
    );
  }
}