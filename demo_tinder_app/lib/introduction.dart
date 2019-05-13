import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'credit.dart';
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
      body:
      SingleChildScrollView(
        child: new Row(
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

              /*Text(''),

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
              ),*/

              Text(''),

              Container(
                constraints: new BoxConstraints(
                    minWidth: 50,
                    maxWidth: MediaQuery.of(context).size.width - 20
                ),
                child: Text(
                  'Swipe til højre for at like og gemme en politiker!',
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  softWrap: true,
                  style: TextStyle(fontSize: 4 * (queryData.size.width / 100)),
                  maxLines: 4,
                ),
              ),

              new Icon(
                Icons.arrow_forward,
                size: 10 * (queryData.size.width / 100),
                color: Colors.green,
              ),

              Text(''),
              Text(''),

              Container(
                constraints: new BoxConstraints(
                    minWidth: 50,
                    maxWidth: MediaQuery.of(context).size.width - 20
                ),
                child: Text(
                  'Swipe til venstre for at dislike.',
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
                color: Colors.red,
              ),

              Text(''),
              Text(''),

              Container(
                constraints: new BoxConstraints(
                    minWidth: 50,
                    maxWidth: MediaQuery.of(context).size.width - 20
                ),
                child: Text(
                  'Knapperne kan bruges til like og dislike.',
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  softWrap: true,
                  style: TextStyle(fontSize: 4 * (queryData.size.width / 100)),
                  maxLines: 4,
                ),
              ),

              new Row(
                children: <Widget>[
                  new Icon(
                    Icons.thumb_down,
                    size: 10 * (queryData.size.width / 100),
                    color: Colors.red,
                  ),
                  Text('   '),

                  new Icon(
                    Icons.thumb_up,
                    size: 10 * (queryData.size.width / 100),
                    color: Colors.green,
                  ),
                ],
              ),

              Text(''),
              Text(''),

              Container(
                constraints: new BoxConstraints(
                    minWidth: 50,
                    maxWidth: MediaQuery.of(context).size.width - 20
                ),
                child: Text(
                  'Se alle gemte politikere under likede politikere i menuen.',
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  softWrap: true,
                  style: TextStyle(fontSize: 4 * (queryData.size.width / 100)),
                  maxLines: 4,
                ),
              ),

              new Icon(
                Icons.account_circle,
                size: 10 * (queryData.size.width / 100),
              ),

              Text(''),
              Text(''),

              Container(
                constraints: new BoxConstraints(
                    minWidth: 50,
                    maxWidth: MediaQuery.of(context).size.width - 20
                ),
                child: Text(
                  'Statistikker omkring likede politikere og partier kan ses under statistikker i menuen.',
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  softWrap: true,
                  style: TextStyle(fontSize: 4 * (queryData.size.width / 100)),
                  maxLines: 4,
                ),
              ),

              new Icon(
                Icons.assessment,
                size: 10 * (queryData.size.width / 100),
              ),

          Text(''),
          Text(''),

          GestureDetector(
            child: Container(
              constraints: new BoxConstraints(
                  minWidth: 50,
                  maxWidth: MediaQuery
                      .of(context)
                      .size
                      .width - 20
              ),
              child: Text(
                'Tryk her for credits.',
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.left,
                softWrap: true,
                style: TextStyle(
                    fontSize: 4 * (queryData.size.width / 100)),
                maxLines: 4,
              ),
            ),
            onTap: () {
              _creditTab();
            },
          ),

          Divider(
            color: Colors.black,
            height: 5.0,
          ),

          GestureDetector(
            child: new Icon(
              Icons.supervisor_account,
              size: 10 * (queryData.size.width / 100),
            ),
            onTap: (){
              _creditTab();
            },
          ),

              Text(''),

              Container(
                constraints: new BoxConstraints(
                    minWidth: 50,
                    maxWidth: MediaQuery.of(context).size.width - 20
                ),
                child: Text(
                  'Ved yderligere spørgsmål og henvendelser, skriv på mail: Politikrapp@gmail.com',
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.left,
                  softWrap: true,
                  style: TextStyle(fontSize: 4 * (queryData.size.width / 100)),
                  maxLines: 4,
                ),
              ),




            ],
          ),
        ],
      ),
      ),
      drawer: DrawerMenu().drawerMenu(context),
    );
  }

  /// Method for changing to credit tab.
  void _creditTab(){
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CreditPage())
    );
  }
}
