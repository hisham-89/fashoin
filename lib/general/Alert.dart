
import 'package:flutter/material.dart';

class Alert{

  Alert(context,success,route){
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
}