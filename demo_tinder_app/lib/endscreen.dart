import 'package:demo_tinder_app/webview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class EndScreenPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              new Flexible(
                child: new Text(
                  'No more politicians! :-(',
                style: TextStyle(
                  fontSize: 35,
                  color: Colors.red,
                ),
              ),
              ),
              new Flexible(
                child: new Text(
                'Check back later or reset your likes.',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              ),
              new Flexible(
                 child: new Text('Remember to check out your statistics in the drawer menu!',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),
              ),
            ],
          )
        ],
      )
    );
  }
}