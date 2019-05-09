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
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
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
                  maxWidth: MediaQuery.of(context).size.width - 10),

                child: Text(
                  _longString,
                  overflow: TextOverflow.ellipsis,
                  softWrap: true,
                  style: TextStyle(fontSize: 4 * (queryData.size.width / 100)),
                  maxLines: 4,
                ),
              ),

            ],
          )
        ],
      ),
      drawer: DrawerMenu().drawerMenu(context),
    );
  }
}
