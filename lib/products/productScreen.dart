


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp3/general/colors.dart';
import 'package:flutterapp3/general/ganeral.dart';
import 'package:flutterapp3/products/productDetails.dart';
import 'package:flutterapp3/store/Like.dart';
import 'package:flutterapp3/store/product.dart';
import 'package:flutterapp3/store/user.dart';
import 'package:getflutter/components/carousel/gf_carousel.dart';
class ProductScreen extends StatefulWidget {

  var product;
  String id;
  @override
  ProductScreenState createState() => ProductScreenState(this.product ,this.id);
  ProductScreen({Key key, this.product ,this.id}) : super(key: key);

}
class ProductScreenState extends State<ProductScreen>  {
  ProductScreenState(this.product, this.id);
  var product;
  String id;
  var isliked=false;
  
  likeProduct() async{
    setState(() {
      isliked=!isliked;
    });
     var res= await Like().likeProduct({'product_id':product['id'] ,"user_id":User().getUserId()}, isliked,product['id'].toString());
  }
  // Function to get the JSON data
  Future<String> getJSONData() async {

    var response = await  Product().getProductsDetails(this.id);
    setState(() {
      // Get the JSON data
      product  = response;

    });
    return "Successfull";
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if (product == null){
      this.getJSONData();
    }else
    {
      this.id=product['id'].toString();
    }
    if(product !=null && product['is_liked'].length>0 ){
      setState(() {
        isliked=true;
      });}

  }
  Widget imageSlider(imageList,product_id,product){
    return(
        GFCarousel(height: 350,pagination: true, aspectRatio: 0.5,
          items: imageList.map<Widget>(
                (url) {
              if(url['name']!=null)
                return
                      Container(
                                child:Image(image:  General.mediaUrl(url['name']) ,fit:BoxFit.cover,)
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
  @override
  Widget build(BuildContext context) {

    return(
        Container(
          color: MYColors.grey2(),margin: EdgeInsets.only(bottom: 30),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  InkWell(onTap: (){ Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProductsDetailsScreen(  id:product['id'].toString(),product:product )
                      ));
                  },child:  Container(
                    //height: 350,
                    width: double.infinity,
//                decoration: BoxDecoration(
//                        borderRadius: BorderRadius.circular(10.0),
//                         image:  product['images']!=null&&product['images'].length==1?DecorationImage(
//                            image: CachedNetworkImageProvider(General.mediaUrl(product['images'][0]['name'])),
//                            fit: BoxFit.contain
//                        ):null
//                    ) ,
                    child:product['images']!=null && product['images'].length>0? imageSlider(product['images'],product['id'].toString(), product ):Container(),
                  )),

                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 4.0, bottom: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(children: <Widget>[
                      Expanded(child: Text( General.getDate(product['created_at'],time:true)),),
                      IconButton(icon: Icon(Icons.share), onPressed: (){},)
                      ,  IconButton(icon: Icon(isliked? Icons.favorite:Icons.favorite_border  ,size: 30 ),onPressed: (){likeProduct();},) ,

                    ],),
                    Text(product['name'].toString() , style: Theme.of(context).textTheme.title,),
                    Divider(),
                    SizedBox(height: 10.0,),
                    Row(children: <Widget>[
                      Icon(Icons.favorite_border),
                      SizedBox(width: 5.0,),
                    //  Text(product['likes_count']),
                      //  SizedBox(width: 16.0,),
                      // Icon(Icons.comment),
                      //SizedBox(width: 5.0,),
                      Text( Product().getLikesCount( product['likes_count'] )),
                    ],),
                    SizedBox(height: 10.0,),
                    Text(product['details'] == null ? '':product['details'].length>20? product['details'].substring(0,20)+"..." :product['details'], textAlign: TextAlign.justify,)
                  ],
                ),
              ),
            ],
          ),
        )
    );
     

  }
}