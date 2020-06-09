


import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp3/general/colors.dart';
import 'package:flutterapp3/general/ganeral.dart';
import 'package:flutterapp3/products/productDetails.dart';

class ProductScreen  {
  ProductScreen(){

  }
  Widget showProduct(item,context ){
    return(
        Container(color: MYColors.grey2(),margin: EdgeInsets.only(bottom: 20),
          child: Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  InkWell(onTap: (){ Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ProductsDetailsScreen(  id:item['id'].toString(),product:item )
                      ));
                  },child:  Container(
                    height: 350,
                    width: double.infinity,
                decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                         image:  item['images']!=null&&item['images'].length==1?DecorationImage(
                            image:  General.mediaUrl(item['images'][0]['name'])  ,
                            fit: BoxFit.contain
                        ):null
                    ) ,
                   //  child:item['images']!=null && item['images'].length>0? imageSlider(item['images'],item['id'].toString(), item ):Container(),
                  )),

                ],
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 4.0, bottom: 16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Row(children: <Widget>[
                      Expanded(child: Text( General.getDate(item['created_at'],time:true)),),
                      IconButton(icon: Icon(Icons.share), onPressed: (){},)
                      ,  IconButton(icon: Icon( Icons.favorite   ,size: 30 ),onPressed: (){},) ,

                    ],),
                    Text(item['name'].toString() , style: Theme.of(context).textTheme.title,),
                    Divider(),
                    SizedBox(height: 10.0,),
                    Row(children: <Widget>[
                      Icon(Icons.favorite_border),
                      SizedBox(width: 5.0,),
                      Text("20.2k"),
                      //  SizedBox(width: 16.0,),
                      // Icon(Icons.comment),
                      //SizedBox(width: 5.0,),
                      // Text("2.2k"),
                    ],),
                    SizedBox(height: 10.0,),
                    Text(item['details'] == null ? '':item['details'].length>20? item['details'].substring(0,20)+"..." :item['details'], textAlign: TextAlign.justify,)
                  ],
                ),
              ),
            ],
          ),
        )
    );
  }
}