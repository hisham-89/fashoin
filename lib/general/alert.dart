
import 'package:flutter/material.dart';
import 'package:flutterapp3/store/baseStore.dart';

class Alert{
     dynamic context;
     dynamic success;
     dynamic route;

  Alert(this.context,this.success,this.route){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(  success),
          actions: <Widget>[
            FlatButton(
              child: new Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => route)
                );
              },
            ),
          ],
        );
      },
    );
  }

  AlertBeforeDelete(obj,id){
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: new Text(  success),
          actions: <Widget>[
            FlatButton(
              child: new Text("OK"),
              onPressed: () {
                BaseStore(obj).delete(id);
                Navigator.of(context).pop();
                Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => route)
                );
              },
            ),   FlatButton(
              child: new Text("cancel"),
              onPressed: () {
                Navigator.of(context).pop(false);
              },
            )
          ],
        );
      },
    );
  }
}