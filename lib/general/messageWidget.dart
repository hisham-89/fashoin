import 'package:bubble/bubble.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutterapp3/MessageDetails.dart';
import 'package:flutterapp3/general/ganeral.dart';

class ChatList extends StatelessWidget {
    List<MessageWidget> children;
  final msgController    = TextEditingController();
   send(item){
     var msg ;
     msg=new MessageWidget( content:   msgController.text,time: General.getTime( DateTime.now().toString()),
       ownerType: OwnerType.sender,
       ownerName:  "Me", );
     children.add(msg);

   }
  ChatList({this.children = const <MessageWidget>[]});
  var msg=new MessageDetails();
  Widget build(context) {
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
            child: Row(   mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              Expanded(
              flex: 9,
             child: Container(
                  padding: EdgeInsets.all(15.0),
                  child: TextField(
                    autocorrect: true,
                    decoration: InputDecoration(hintText: 'Enter Your Message' ,),
               controller:msgController ,
                  )
              ),

              ),
          Expanded(
            flex: 1,
            child: Container(
                padding: EdgeInsets.fromLTRB(0,0,10,0),
                margin: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child:
               new IconButton(
                 icon: new Icon(Icons.send ,size: 24.0,   color: Colors.pink,
                   semanticLabel: 'send  ',),
                   onPressed:(){send(' hhhh');} ,
                ),
              ),
          )
           ],
         ),flex: 1,
        )

      ],
    );
  }
}
class MessageWidget extends StatefulWidget {
  final String content;
  final String time;
  final String fontFamily;
  final double fontSize;
  final Color textColor;
  final OwnerType ownerType;
  final String ownerName;

  MessageWidget(
      {this.content,
        this.fontFamily,
        this.fontSize,
        this.textColor,
        this.ownerType,
        this.time,
        this.ownerName});

  @override
  _MessageWidgetState createState() => _MessageWidgetState();
}

class _MessageWidgetState extends State<MessageWidget>
    implements IMessageWidget {
  String get senderInitials {
    if (widget.ownerName == null || widget.ownerName.isEmpty) return 'ME';

    try {
      if (widget.ownerName.lastIndexOf(' ') == -1) {
        return widget.ownerName[0];
      } else {
        var lastInitial =
        widget.ownerName.substring(widget.ownerName.lastIndexOf(' ') + 1);

        return widget.ownerName[0] + lastInitial[0];
      }
    } catch (e) {
      print(e);
      return 'ME';
    }
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.ownerType) {
      case OwnerType.receiver:
        return buildReceiver();
      case OwnerType.sender:
      default:
        return buildSender();
    }
  }

  @override
  Widget buildReceiver() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        _buildCircleAvatar(),
        Flexible(
          child: Bubble(
              margin: BubbleEdges.fromLTRB(10, 10, 30, 0),
              stick: true,
              nip: BubbleNip.leftTop,
              color: Color.fromRGBO(233, 232, 252, 10),
              alignment: Alignment.topLeft,
              child: _buildContentText(TextAlign.left)),
        ),
      ],
    );
  }

  @override
  Widget buildSender() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[
        Flexible(
          child: Bubble(
              margin: BubbleEdges.fromLTRB(30, 10, 10, 0),
              stick: true,
              nip: BubbleNip.rightTop,
              color: Colors.white,
              alignment: Alignment.topRight,
              child: _buildContentText(TextAlign.right)),
        ),
        _buildCircleAvatar()
      ],
    );
  }

  Widget _buildContentText(TextAlign align) {
    return
      Column( crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          Text(
            widget.content,
            textAlign: align,
            style: TextStyle(
                fontSize: widget.fontSize ?? 16.0,
                color: widget.textColor ?? Colors.black,
                fontFamily: widget.fontFamily ??
                    DefaultTextStyle.of(context).style.fontFamily),
          ),
          Text(
            widget.time,
            textAlign: align,
            style: TextStyle(
                fontSize:  12.0,
                color: widget.textColor ?? Colors.grey,
                fontFamily: widget.fontFamily ??
                    DefaultTextStyle.of(context).style.fontFamily),
          )
        ],
      );

  }

  Widget _buildCircleAvatar() {
    return CircleAvatar(
        radius: 12,
        child: Text(
          senderInitials ?? "",
          style: TextStyle(fontSize: 9),
        ));
  }
}

abstract class IMessageWidget {
  Widget buildReceiver();
  Widget buildSender();
}

enum OwnerType { receiver, sender }
