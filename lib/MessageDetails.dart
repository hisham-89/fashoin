import 'package:date_util/date_util.dart';
import 'package:flutter/material.dart';
import 'package:flutterapp3/general/colors.dart';
import 'package:flutterapp3/general/ganeral.dart';

import 'package:flutterapp3/general/messageWidget.dart';
import 'package:flutterapp3/likes.dart';
import 'package:flutterapp3/store/message.dart';
import 'package:flutterapp3/store/user.dart';
import 'package:intl/intl.dart';

class MessageDetails extends StatelessWidget {
  // This widget is the root of your application.
  dynamic id;

  MessageDetails({Key key, @required this.id}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ChatList',
      debugShowCheckedModeBanner: false,
      theme: ThemeData( primaryColor:     MYColors.primaryColor(),
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Chat List '+ id.toString(),id:id.toString() ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  String id;
  MyHomePage({Key key,@required this.id, this.title }) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState(id);
}

class _MyHomePageState extends State<MyHomePage> {
  String id;
  List<MessageWidget>  data=[];
  List<MessageWidget> _messageList=[];
  var message=new Message();
  _MyHomePageState(mid){
    id=mid;
    getJSONData();
  }
  final msgController    = TextEditingController();

  send(item) async {
    var msg ;
    if(msgController.text=='')
      return;
    msg=new MessageWidget( content:   msgController.text,time: General.getDate( DateTime.now().toString()),
      ownerType: OwnerType.sender,
      ownerName:  "Me", );
    _messageList.insert(0,msg);
    setState(() {
      // Get the JSON data
      data = _messageList  ;//json.decode(response.body);
    });

    var messageDet = {
      'content':  msgController.text ,
      'sender_user_id':new User().getUserId(),
      'parent_id': id.toString(),
      'reply':1,
      'receiver_user_id':  0,//the receiverid will be saved in backend
    };
    var response1=  await message.sendMessage( messageDet ,1 );
    msgController.text='';
  }
  getTime(date){
    var dateUtility = new DateUtil();
    var moonLanding = DateTime.parse( date);
    return  moonLanding.hour.toString() + ":" + moonLanding.minute.toString();

  }
  addToList(item)
  {
    var msg ;
    msg=new MessageWidget( content:  item['content'],time: General.getDate(item['created_at']),
      ownerType:item['me']==1? OwnerType.sender:OwnerType.receiver,
      ownerName: item['me']==0? "Me": "", );
    _messageList.add(msg);


  }

  Future<String> getJSONData() async {


    var response1= await message.getMessagesDetails( id  );
    var r=1;
    for(int i=0;i<response1.length;i++)
    {
      addToList(response1[i]);
    }

    setState(() {
      // Get the JSON data
      data = _messageList  ;//json.decode(response.body);
    });
    return "Successfull";
  }
//  final List<MessageWidget> _messageList1 = [
//    MessageWidget(
//        content: "Hi, Bill! This is the simplest example ever.",
//        ownerType: OwnerType.sender,
//        ownerName: "Higor Lapa"),
//    MessageWidget(
//        content:
//        "Let's make it better , Higor. Custom font size and text color",
//        textColor: Colors.black38,
//        fontSize: 18.0,
//        ownerType: OwnerType.receiver,
//        ownerName: "Bill Gates"),
//    MessageWidget(
//        content: "Bill, we have to talk about business",
//        fontSize: 12.0,
//        ownerType: OwnerType.sender,
//        ownerName: "Higor"),
//    MessageWidget(
//        content: "Wow, I like it. Tell me what I can do for you, pal.",
//        ownerType: OwnerType.receiver,
//        ownerName: "Bill Gates"),
//  ];


  Widget buildWidget(context,children) {
    var msg=new MessageDetails();
    return Column(
      mainAxisSize: MainAxisSize.max,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            shrinkWrap: true,reverse: true,
            padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
            itemCount: children.length,
            itemBuilder: (BuildContext buildContext, int index) {
              return children[index];
            },
          ),
          flex: 9,
        ),
        Expanded(
          child: Row(   mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Expanded(
                flex: 9,
                child: Container(

                    padding: EdgeInsets.fromLTRB(13,17,10,2),
                    child: TextField(
                      autocorrect: true,
                      decoration: InputDecoration(hintText: 'Enter Your Message' ,),
                      controller:msgController ,
                    )
                ),

              ),
              Container(
                  width: 50,height: 25,
                  decoration: BoxDecoration(
                    //   color: Colors.grey,
                    borderRadius: BorderRadius.all(new Radius.circular(40)),
                  ), //color: Colors.grey,

                  padding: EdgeInsets.fromLTRB(0,0,0,0),
                  margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  child:
                  Center(child: new IconButton(
                    icon: new Icon(Icons.send ,size: 32.0,   color: Colors.pink,
                      semanticLabel: 'send  ',),
                    onPressed:(){send(' hhhh');} ,
                  ),

                  )

              ),

            ],
          ),flex: 1,
        )
        ,SizedBox(
          width: 10,height: 15,
        )
      ],
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: new IconButton(
            icon: new Icon(Icons.arrow_back),
            onPressed: () =>  Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => Likes( ))
            ),
          ),
          title: Text(widget.title),
        ),resizeToAvoidBottomPadding: false,
        body: Center(child:buildWidget(context, data!=null? data:[])
          // ChatList(children:_messageList!=null? _messageList:[])
        )
    );
  }
}
//Column(
//crossAxisAlignment: CrossAxisAlignment.end,
//children:<Widget>[
//ChatList(children:_messageList!=null? _messageList:[])
//,TextField(
//decoration: InputDecoration(
//border: InputBorder.none,
//hintText: 'Enter a search term'
//),
//)
//],


