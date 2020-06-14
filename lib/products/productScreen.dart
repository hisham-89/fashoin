


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp3/general/colors.dart';
import 'package:flutterapp3/general/ganeral.dart';
import 'package:flutterapp3/products/productDetails.dart';
import 'package:flutterapp3/store/Like.dart';
import 'package:flutterapp3/store/user.dart';
import 'package:getflutter/components/carousel/gf_carousel.dart';
class ProductScreen extends StatefulWidget {

  var product;
  @override
  ProductScreenState createState() => ProductScreenState(this.product);
  ProductScreen({Key key, this.product}) : super(key: key);

}
class ProductScreenState extends State<ProductScreen>  {
  ProductScreenState(this.product);
  var product;
  var isliked=false;
  
  likeProduct() async{
    var followId='0';
    if(product['is_liked']!=null&&product['is_liked'].length>0 )
      followId=product['is_liked'][0]['id'].toString();
     var res= await Like().likeProduct({'product_id':product['id'] ,"user_id":User().getUserId()}, isliked,followId);
     setState(() {
      isliked=!isliked;
      product['is_liked']=res;
    });
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    if(product['is_liked']!=null && product['is_liked'].length>0 ){
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
                      Text("20.2k"),
                      //  SizedBox(width: 16.0,),
                      // Icon(Icons.comment),
                      //SizedBox(width: 5.0,),
                       Text("2.2k"),
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