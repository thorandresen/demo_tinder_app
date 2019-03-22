import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/rendering.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:fit_image/fit_image.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'webview.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePageState extends State<HomePage>{
  ScrollController _controller; // Scroll controller
  bool _hideFAB; //
  int _politicianNo = 0;

  // Variable strings used.
  String _name = 'Lars Løkke (V)';
  String _partyName = 'Venstre';
  String _aboutURL = 'https://www.venstre.dk/personer/formanden';
  String _partyURL = 'https://www.venstre.dk/';
  // -- FØRSTE KERNEPRINCIP --
  String _politikPrincip = 'Politik';
  static double _politikPrincipPercent = 0.9;
  String _politikPrincipPercentText = (_politikPrincipPercent*10).toStringAsFixed(0)+"/10";
  Color _politikColor = Colors.blue;
  // -- ANDET KERNEPRINCIP --
  String _andetPrincipName = 'Udlændinge politik';
  static double _andetPrincipPercent = 0.9;
  String _andetPrincipPercentText = (_andetPrincipPercent*10).toStringAsFixed(0)+"/10";
  String _andetPrincipLeft = 'Lempelig';
  String _andetPrincipRight = 'Stram';
  Color _andetColor = Colors.red;
  // -- TREDJE KERNEPRINCIP --
  String _trejdePrincipName = 'Miljøpolitik';
  static double _tredjePrincipPercent = 0.7;
  String _tredjePrincipPercentText = (_tredjePrincipPercent*10).toStringAsFixed(0)+"/10";
  String _tredjePrincipLeft = 'Fossil';
  String _tredjePrincipRight = 'Grøn';
  Color _trejdeColor = Colors.green;
  // -- FJERDE KERNEPRINCIP --
  String _fjerdePrincipName = 'Privat skattepolitik';
  static double _fjerdePrincipPercent = 0.3;
  String _fjerdePrincipPercentText = (_fjerdePrincipPercent*10).toStringAsFixed(0)+"/10";
  String _fjerdePrincipLeft = 'Lav';
  String _fjerdePrincipRight = 'Høj';
  Color _fjerdeColor = Colors.blue;
  // -- FEMTE KERNEPRINCIP --
  String _femtePrincipName = 'Skattelettelser for erhverv';
  static double _femtePrincipPercent = 0;
  String _femtePrincipPercentText = (_femtePrincipPercent*10).toStringAsFixed(0)+"/10";
  String _femtePrincipLeft = 'Lav';
  String _femtePrincipRight = 'Høj';
  Color _femteColor = Colors.blue;

  /// Method that inits shit when starting.
  @override
  void initState(){
    retrieveFireStore();
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    _hideFAB = false;
    super.initState();
  }

  /// The widget for building the whole card.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body: StreamBuilder(
          stream: Firestore.instance.collection('Venstre').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
                     return new LinearProgressIndicator(
                     );
            }
            else {
              List<DocumentSnapshot> item = snapshot.data.documents; // Gets the item for the given snapshot.
              return Card(
                elevation: 10,
                child: CustomScrollView(
                  controller: _controller,
                  slivers: <Widget>[
                    SliverAppBar(
                        floating: false,
                        pinned: true,
                        expandedHeight: 235,
                        backgroundColor: Color.fromARGB(255, 74, 104, 153),
                        centerTitle: true,
                        flexibleSpace: FlexibleSpaceBar(
                          title: new Text(item[_politicianNo]['name'],
                            style: new TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                          centerTitle: true,
                          background: DecoratedBox(
                            child: new Column(
                              children: <Widget>[
                                new Container(
                                    margin: EdgeInsets.all(10),
                                    width: 190.0,
                                    height: 190.0,
                                    decoration: new BoxDecoration(
                                        shape: BoxShape.circle,
                                        image: new DecorationImage(
                                            fit: BoxFit.fill,
                                            image: new NetworkImage(
                                                item[_politicianNo]['pb'])
                                        )
                                    )
                                ),
                              ],
                            ),
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: NetworkImage(
                                        "https://i.imgur.com/ijQ7mNU.png"),
                                    fit: BoxFit.fill)
                            ),
                          ),
                        )
                    ),

                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          new Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [

                              // Politiske præfferencer
                              new Column(
                                children: <Widget>[
                                  Text(''),
                                  new Text('Kerne principper',
                                    style: new TextStyle(
                                      fontSize: 20.0,
                                    ),
                                  ),

                                  /// Politik
                                  new Text(_politikPrincip,
                                    style: new TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  new LinearPercentIndicator(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width - 100,
                                    alignment: MainAxisAlignment.center,
                                    animation: true,
                                    lineHeight: 20.0,
                                    animationDuration: 2500,
                                    percent: _politikPrincipPercent,
                                    center: Text(_politikPrincipPercentText),
                                    linearStrokeCap: LinearStrokeCap.roundAll,
                                    padding: EdgeInsets.symmetric(),
                                    progressColor: _politikColor,
                                  ),
                                  new Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceEvenly,
                                    children: <Widget>[
                                      new Flexible(child: Text('Socialisme')),
                                      new Flexible(child: Text('')),
                                      new Flexible(child: Text('Sociallib.')),
                                      new Flexible(child: Text('')),
                                      new Flexible(child: Text('Liberalisme')),
                                    ],
                                  ),

                                  /// ANDET PRNCIP
                                  Text(''),
                                  new Text(item[_politicianNo]['andetPrincipName'],
                                    style: new TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  new LinearPercentIndicator(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width - 100,
                                    alignment: MainAxisAlignment.center,
                                    animation: true,
                                    lineHeight: 20.0,
                                    animationDuration: 2500,
                                    percent: item[_politicianNo]['andetPrincipPercent'],
                                    center: Text((item[_politicianNo]['andetPrincipPercent']*10).toStringAsFixed(0)+"/10"),
                                    linearStrokeCap: LinearStrokeCap.roundAll,
                                    padding: EdgeInsets.symmetric(),
                                    progressColor: _andetColor,
                                  ),
                                  new Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceEvenly,
                                    children: <Widget>[
                                      new Flexible(
                                          child: Text(_andetPrincipLeft)),
                                      new Flexible(child: Text('')),
                                      new Flexible(child: Text('')),
                                      new Flexible(child: Text('')),
                                      new Flexible(child: Text('')),
                                      new Flexible(
                                          child: Text(_andetPrincipRight)),
                                    ],
                                  ),

                                  /// TREDJE PRINCIP
                                  Text(''),
                                  new Text(_trejdePrincipName,
                                    style: new TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  new LinearPercentIndicator(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width - 100,
                                    alignment: MainAxisAlignment.center,
                                    animation: true,
                                    lineHeight: 20.0,
                                    animationDuration: 2500,
                                    percent: _tredjePrincipPercent,
                                    center: Text(_tredjePrincipPercentText),
                                    linearStrokeCap: LinearStrokeCap.roundAll,
                                    padding: EdgeInsets.symmetric(),
                                    progressColor: _trejdeColor,
                                  ),
                                  new Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceEvenly,
                                    children: <Widget>[
                                      new Flexible(
                                          child: Text(_tredjePrincipLeft)),
                                      new Flexible(child: Text('')),
                                      new Flexible(child: Text('')),
                                      new Flexible(child: Text('')),
                                      new Flexible(child: Text('')),
                                      new Flexible(
                                          child: Text(_tredjePrincipRight)),
                                    ],
                                  ),

                                  /// FJERDE PRINCIP
                                  Text(''),
                                  new Text(_fjerdePrincipName,
                                    style: new TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  new LinearPercentIndicator(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width - 100,
                                    alignment: MainAxisAlignment.center,
                                    animation: true,
                                    lineHeight: 20.0,
                                    animationDuration: 2500,
                                    percent: _fjerdePrincipPercent,
                                    center: Text(_fjerdePrincipPercentText),
                                    linearStrokeCap: LinearStrokeCap.roundAll,
                                    padding: EdgeInsets.symmetric(),
                                    progressColor: _fjerdeColor,
                                  ),
                                  new Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceEvenly,
                                    children: <Widget>[
                                      new Flexible(
                                          child: Text(_fjerdePrincipLeft)),
                                      new Flexible(child: Text('')),
                                      new Flexible(child: Text('')),
                                      new Flexible(child: Text('')),
                                      new Flexible(child: Text('')),
                                      new Flexible(
                                          child: Text(_fjerdePrincipRight)),
                                    ],
                                  ),

                                  /// FEMTE PRINCIP
                                  Text(''),
                                  new Text(_femtePrincipName,
                                    style: new TextStyle(
                                      fontSize: 15,
                                    ),
                                  ),
                                  new LinearPercentIndicator(
                                    width: MediaQuery
                                        .of(context)
                                        .size
                                        .width - 100,
                                    alignment: MainAxisAlignment.center,
                                    animation: true,
                                    lineHeight: 20.0,
                                    animationDuration: 2500,
                                    percent: _femtePrincipPercent,
                                    center: Text(_femtePrincipPercentText),
                                    linearStrokeCap: LinearStrokeCap.roundAll,
                                    padding: EdgeInsets.symmetric(),
                                    progressColor: _femteColor,
                                  ),
                                  new Row(
                                    mainAxisAlignment: MainAxisAlignment
                                        .spaceEvenly,
                                    children: <Widget>[
                                      new Flexible(
                                          child: Text(_femtePrincipLeft)),
                                      new Flexible(child: Text('')),
                                      new Flexible(child: Text('')),
                                      new Flexible(child: Text('')),
                                      new Flexible(child: Text('')),
                                      new Flexible(
                                          child: Text(_femtePrincipRight)),
                                    ],
                                  ),

                                  Text(''),
                                  new Text('Mere information',
                                    style: new TextStyle(
                                        fontSize: 20
                                    ),
                                  ),

                                ],
                              ),
                              new GridView.count(
                                crossAxisCount: 2,
                                shrinkWrap: true,
                                childAspectRatio: 1.0,
                                padding: const EdgeInsets.all(4.0),
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 4.0,
                                physics: ScrollPhysics(),
                                children: <Widget>[
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) =>
                                            WebViewPage(item[_politicianNo]['name'], item[_politicianNo]['aboutURL'])),
                                      );
                                    },
                                    child: new Image(image: AssetImage(
                                        'graphics/about_male_version_4.png'),
                                        fit: BoxFit.fill),
                                  ),

                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) =>
                                            WebViewPage(_partyName, item[_politicianNo]['partiURL'])),
                                      );
                                    },
                                    child: new Image(image: AssetImage(
                                        'graphics/website_thumbnail.png'),
                                        fit: BoxFit.fill),
                                  ),

                                  GestureDetector(
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          return AlertDialog(
                                            title: new Text('Vælg medie',
                                              textAlign: TextAlign.center,),
                                            content: new Row(
                                              mainAxisAlignment: MainAxisAlignment
                                                  .spaceEvenly,
                                              children: <Widget>[
                                                new Container(
                                                    margin: EdgeInsets.all(10),
                                                    width: 50.0,
                                                    height: 50.0,
                                                    decoration: new BoxDecoration(
                                                        image: new DecorationImage(
                                                            fit: BoxFit.fill,
                                                            image: new AssetImage(
                                                                "graphics/fb_logo.png")
                                                        )
                                                    )
                                                ),


                                                new Container(
                                                    margin: EdgeInsets.all(10),
                                                    width: 50.0,
                                                    height: 50.0,
                                                    decoration: new BoxDecoration(
                                                        image: new DecorationImage(
                                                            fit: BoxFit.fill,
                                                            image: new AssetImage(
                                                                "graphics/twitter_logo.png")
                                                        )
                                                    )
                                                ),

                                                new Container(
                                                    margin: EdgeInsets.all(10),
                                                    width: 50.0,
                                                    height: 50.0,
                                                    decoration: new BoxDecoration(
                                                        image: new DecorationImage(
                                                            fit: BoxFit.fill,
                                                            image: new AssetImage(
                                                                "graphics/instagram_logo.png")
                                                        )
                                                    )
                                                ),


                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    child: new Image(image: AssetImage(
                                        'graphics/sociale_medier.png'),
                                        fit: BoxFit.fill),
                                  ),

                                  GestureDetector(
                                    onTap: () {

                                    },
                                    child: new Image(image: AssetImage(
                                        'graphics/placeholder.png'),
                                        fit: BoxFit.fill),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],

                ),
              );
            }
          }
  ),
      /// FAB
      floatingActionButton:
      new AnimatedOpacity(opacity: _hideFAB ? 0.0 : 1.0,
        duration: Duration(milliseconds: 200),
        child: new Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text(''),
            Container(
              height: 80,
              width: 80,
              child: FloatingActionButton(
                heroTag: "btn1",
                onPressed: () {},
                backgroundColor: Colors.white,
                child: Icon(Icons.thumb_down, color: Colors.red,size: 40.0),
              ),
            ),
            Text(''),
            Container(
                height: 80,
                width: 80,
                child: FloatingActionButton(
                  heroTag: "btn2",
                  onPressed: () {},
                  backgroundColor: Colors.white,
                  child: Icon(Icons.thumb_up, color: Colors.green,size: 40.0),

                )
            ),
          ],
        ),
      ),
      );
  }

  /// Method for listening to scroll by the user.
  void _scrollListener() {
    if(_controller.position.userScrollDirection == ScrollDirection.reverse){
      setState(() {
        _hideFAB = true;
      });
    }

    if(_controller.position.userScrollDirection == ScrollDirection.forward){
      setState((){
        _hideFAB = false;
      });
    }
  }

  void retrieveFireStore(){

  }

}

class HomePage extends StatefulWidget {
  HomePageState createState() => new HomePageState();
}