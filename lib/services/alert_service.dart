import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AlertService {
  void showAlert (
      BuildContext context, String title, String desc, Function onCancel
      ) {
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) => new CupertinoAlertDialog (
          title: new Text("$title"),
          content: new Text("$desc"),
          actions: <Widget> [
            FlatButton(
              child: Text(
                "Done",
                style: TextStyle(
                  color: Colors.blue
                ),
              ),
              onPressed: onCancel,
            )
          ],
        )
    );
  }

  void showSignOut(BuildContext context, String title, String desc, Function onSignOut, Function onCancel){
    showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) => new CupertinoAlertDialog (
        title: new Text("$title"),
        content: new Text("$desc"),
        actions: <Widget>[
          FlatButton(
              onPressed: onSignOut,
              child: Text(
                "Yes",
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
          ),
          FlatButton(
              onPressed: onCancel,
              child: Text(
                "No",
                style: TextStyle(
                  color: Colors.blue,
                ),
              ),
          ),
        ],
      )
    );
  }
  void showWarning(
      BuildContext context, String title, String desc, Function onCancel
      ){
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) => new CupertinoAlertDialog(
            title: new Text("$title"),
            content: new Text("$desc"),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "Done",
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
                onPressed: onCancel,
              ),
            ]
        )
    );
  }

  void showSuccess(
      BuildContext context, String title, String desc, Function onCancel
      ){
    showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) => new CupertinoAlertDialog(
            title: new Text("$title"),
            content: new Text("$desc"),
            actions: <Widget>[
              FlatButton(
                child: Text(
                  "Done",
                  style: TextStyle(
                    color: Colors.blue,
                  ),
                ),
                onPressed: onCancel,
              ),
            ]
        )
    );
  }

}