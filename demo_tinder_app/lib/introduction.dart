import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'drawermenu.dart';

class IntroductionPage extends StatefulWidget {
  IntroductionPageState createState() => new IntroductionPageState();
}

class IntroductionPageState extends State<StatefulWidget> {
  String _longString =
      "Konceptet er simpelt. Swipe dig igennem de forskellige politikere fra Østjyllands storkreds.";

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Hjælp'),
        centerTitle: true,
      ),
      body: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Column(
            children: <Widget>[
              Text(''),
              Text(
                'Velkommen til Politikr!',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 7 * (queryData.size.width / 100),
                ),
              ),

              Text(''),

              Container(
                constraints: new BoxConstraints(
                  minWidth: 50,
                  maxWidth: MediaQuery.of(context).size.width - 10
                ),
                child: Text(
                  _longString,
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  softWrap: true,
                  style: TextStyle(fontSize: 4 * (queryData.size.width / 100)),
                  maxLines: 4,
                ),
              ),

              Text(''),

              Container(
                constraints: new BoxConstraints(
                    minWidth: 50,
                    maxWidth: MediaQuery.of(context).size.width - 10
                ),
                child: Text(
                  'Swipe til venstre for at like og gemme en politiker!',
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  softWrap: true,
                  style: TextStyle(fontSize: 4 * (queryData.size.width / 100)),
                  maxLines: 4,
                ),
              ),

              new Icon(
                Icons.arrow_back,
                size: 10 * (queryData.size.width / 100),
              )
            ],
          ),
        ],
      ),
      drawer: DrawerMenu().drawerMenu(context),
    );
  }
}
