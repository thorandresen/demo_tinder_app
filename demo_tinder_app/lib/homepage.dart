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
import 'newpolitician.dart';

/// Homepage which has the swiping of politicians.
/// @author Thor Garske Andresen
///
/// Date: 08/04/19
class HomePageState extends State<HomePage> {
  // VARIABLES.
  ScrollController _controller;
  bool _hideFAB; //
  int _politicianNo = 0;
  String _collectionName;
  String _partyName;
  String _politikPrincip = 'Politik';
  NewPolitician _newPolitician = new NewPolitician();
  List<DocumentSnapshot> item;

  /// Method that inits shit when starting.
  @override
  void initState() {
    _controller = ScrollController();
    _controller.addListener(_scrollListener);
    _hideFAB = false;
    _collectionName = _newPolitician.collection();
    super.initState();
  }

  /// The widget for building the whole card.
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomPadding: false,
      body: Dismissible(
        key: ValueKey(_politicianNo.toString() + _collectionName),
        background: Container(
          color: Colors.red,
          child: Icon(
            Icons.thumb_down,
            color: Colors.white,
            size: 150.0,
          ),
        ),
        secondaryBackground: Container(
          color: Colors.green,
          child: Icon(
            Icons.thumb_up,
            color: Colors.white,
            size: 150.0,
          ),
        ),
        onDismissed: (direction) {
          if (direction == DismissDirection.endToStart) {
            setState(() {
              _newPolitician.performPolitician(true, context, item[_politicianNo]['id']);
            });
          } else {
            setState(() {
              _newPolitician.performPolitician(false, context, item[_politicianNo]['id']);
            });
          }
        },
        child: StreamBuilder(
            stream: Firestore.instance.collection(_collectionName).snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return new Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircularProgressIndicator(),
                      ],
                    )
                  ],
                );
              } else {
                item = snapshot
                    .data.documents; // Gets the item for the given snapshot.
                _partyName = item[_politicianNo]['partiName'];

                return CustomScrollView(
                  controller: _controller,
                  slivers: <Widget>[
                   _sliverAppWidget(),
                    SliverList(
                      delegate: SliverChildListDelegate(
                        [
                          new Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              /// FØRSTE PRINCIP
                              _firstPrincipleWidget(),
                              /// ANDET PRNCIP
                             _secondPrincipleWidget(),
                              /// TREDJE PRINCIP
                              _thirdPrincipleWidget(),
                              /// FJERDE PRINCIP
                              _fourthPrincipleWidget(),
                              /// FEMTE PRINCIP
                              _fifthPrincipleWidget(),

                              new GridView.count(
                                crossAxisCount: 2,
                                shrinkWrap: true,
                                childAspectRatio: 1.0,
                                padding: const EdgeInsets.all(4.0),
                                mainAxisSpacing: 4.0,
                                crossAxisSpacing: 4.0,
                                physics: ScrollPhysics(),
                                children: <Widget>[
                                  /// MORE INFO
                                  _moreInfGestureDetectorWidget(),
                                  /// ABOUT PARTY
                                  _aboutPartyGestureDetectorWidget(),
                                  /// SOCIAL MEDIA
                                  _socialMediaGestureDetectorWidget(),
                                  /// RELAVENT INFO
                                 _relevantGestureDetectorWidget(),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }
            }),
      ),

      /// FAB
      floatingActionButton: _fabWidget(),
    );
  }

  /// ## ---- WIDGETS ---- ## ///

  /// Widget for showing the SliverAppBar
  Widget _sliverAppWidget() {
    return SliverAppBar(
        floating: false,
        pinned: true,
        expandedHeight: 235,
        backgroundColor: Color(int.parse(
            item[_politicianNo]['appBackgroundColor'])),
        centerTitle: true,
        flexibleSpace: FlexibleSpaceBar(
          title: new Text(
            item[_politicianNo]['name'],
            style: new TextStyle(
              fontSize: 20.0,
              color: Colors.white,
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
                                item[_politicianNo]['pb'])))),
              ],
            ),
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage(_newPolitician.background(item[_politicianNo]['backgroundImage'])),
                    fit: BoxFit.fill)),
          ),
        )
    );
  }

  /// Widget for showing the first principle.
  Widget _firstPrincipleWidget() {
    return new Column(
      children: <Widget>[
        Text(''),
        new Text(
          'Kerne principper',
          style: new TextStyle(
            fontSize: 20.0,
          ),
        ),

        /// Politik
        new Text(
          _politikPrincip,
          style: new TextStyle(
            fontSize: 15,
          ),
        ),
        new LinearPercentIndicator(
          width:
          MediaQuery.of(context).size.width - 100,
          alignment: MainAxisAlignment.center,
          animation: true,
          lineHeight: 20.0,
          animationDuration: 2500,
          percent: item[_politicianNo]
          ['politikPrincipPercent']
              .toDouble(),
          center: Text((item[_politicianNo]
          ['politikPrincipPercent'] *
              10)
              .toStringAsFixed(0) +
              "/10"),
          linearStrokeCap: LinearStrokeCap.roundAll,
          padding: EdgeInsets.symmetric(),
          progressColor: Color(int.parse(
              item[_politicianNo]['politikColor'])),
        ),
        new Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Flexible(child: Text('Socialisme')),
            new Flexible(child: Text('')),
            new Flexible(child: Text('Sociallib.')),
            new Flexible(child: Text('')),
            new Flexible(child: Text('Liberalisme')),
          ],
        ),
      ],
    );
  }

  /// Widget for showing the second principle.
  Widget _secondPrincipleWidget() {
    return new Column(
      children: <Widget>[
        Text(''),
        new Text(
          item[_politicianNo]['andetPrincipName'],
          style: new TextStyle(
            fontSize: 15,
          ),
        ),
        new LinearPercentIndicator(
          width:
          MediaQuery.of(context).size.width - 100,
          alignment: MainAxisAlignment.center,
          animation: true,
          lineHeight: 20.0,
          animationDuration: 2500,
          percent: item[_politicianNo]
          ['andetPrincipPercent']
              .toDouble(),
          center: Text((item[_politicianNo]
          ['andetPrincipPercent'] *
              10)
              .toStringAsFixed(0) +
              "/10"),
          linearStrokeCap: LinearStrokeCap.roundAll,
          padding: EdgeInsets.symmetric(),
          progressColor: Color(int.parse(
              item[_politicianNo]
              ['andetPrincipColor'])),
        ),
        new Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Flexible(
                child: Text(item[_politicianNo]
                ['andetPrincipLeft'])),
            new Flexible(child: Text('')),
            new Flexible(child: Text('')),
            new Flexible(child: Text('')),
            new Flexible(child: Text('')),
            new Flexible(
                child: Text(item[_politicianNo]
                ['andetPrincipRight'])),
          ],
        ),
      ],
    );
  }

  /// Widget for showing the third principle.
  Widget _thirdPrincipleWidget() {
    return new Column(
      children: <Widget>[
        Text(''),
        new Text(
          item[_politicianNo]['tredjePrincipName'],
          style: new TextStyle(
            fontSize: 15,
          ),
        ),
        new LinearPercentIndicator(
          width:
          MediaQuery.of(context).size.width - 100,
          alignment: MainAxisAlignment.center,
          animation: true,
          lineHeight: 20.0,
          animationDuration: 2500,
          percent: item[_politicianNo]
          ['tredjePrincipPercent']
              .toDouble(),
          center: Text((item[_politicianNo]
          ['tredjePrincipPercent'] *
              10)
              .toStringAsFixed(0) +
              "/10"),
          linearStrokeCap: LinearStrokeCap.roundAll,
          padding: EdgeInsets.symmetric(),
          progressColor: Color(int.parse(
              item[_politicianNo]
              ['tredjePrincipColor'])),
        ),
        new Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Flexible(
                child: Text(item[_politicianNo]
                ['tredjePrincipLeft'])),
            new Flexible(child: Text('')),
            new Flexible(child: Text('')),
            new Flexible(child: Text('')),
            new Flexible(child: Text('')),
            new Flexible(
                child: Text(item[_politicianNo]
                ['tredjePrincipRight'])),
          ],
        ),
      ],
    );
  }

  /// Widget for showing the fourth principle.
  Widget _fourthPrincipleWidget() {
    return new Column(
      children: <Widget>[
        Text(''),
        new Text(
          item[_politicianNo]['fjerdePrincipName'],
          style: new TextStyle(
            fontSize: 15,
          ),
        ),
        new LinearPercentIndicator(
          width:
          MediaQuery.of(context).size.width - 100,
          alignment: MainAxisAlignment.center,
          animation: true,
          lineHeight: 20.0,
          animationDuration: 2500,
          percent: item[_politicianNo]
          ['fjerdePrincipPercent']
              .toDouble(),
          center: Text((item[_politicianNo]
          ['fjerdePrincipPercent'] *
              10)
              .toStringAsFixed(0) +
              "/10"),
          linearStrokeCap: LinearStrokeCap.roundAll,
          padding: EdgeInsets.symmetric(),
          progressColor: Color(int.parse(
              item[_politicianNo]
              ['fjerdePrincipColor'])),
        ),
        new Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Flexible(
                child: Text(item[_politicianNo]
                ['fjerdePrincipLeft'])),
            new Flexible(child: Text('')),
            new Flexible(child: Text('')),
            new Flexible(child: Text('')),
            new Flexible(child: Text('')),
            new Flexible(
                child: Text(item[_politicianNo]
                ['fjerdePrincipRight'])),
          ],
        ),
      ],
    );
  }

  /// Widget for showing the fifth principle.
  Widget _fifthPrincipleWidget() {
    return new Column(
      children: <Widget>[
        Text(''),
        new Text(
          item[_politicianNo]['femtePrincipName'],
          style: new TextStyle(
            fontSize: 15,
          ),
        ),
        new LinearPercentIndicator(
          width:
          MediaQuery.of(context).size.width - 100,
          alignment: MainAxisAlignment.center,
          animation: true,
          lineHeight: 20.0,
          animationDuration: 2500,
          percent: item[_politicianNo]
          ['femtePrincipPercent']
              .toDouble(),
          center: Text((item[_politicianNo]
          ['femtePrincipPercent'] *
              10)
              .toStringAsFixed(0) +
              "/10"),
          linearStrokeCap: LinearStrokeCap.roundAll,
          padding: EdgeInsets.symmetric(),
          progressColor: Color(int.parse(
              item[_politicianNo]
              ['femtePrincipColor'])),
        ),
        new Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            new Flexible(
                child: Text(item[_politicianNo]
                ['femtePrincipLeft'])),
            new Flexible(child: Text('')),
            new Flexible(child: Text('')),
            new Flexible(child: Text('')),
            new Flexible(child: Text('')),
            new Flexible(
                child: Text(item[_politicianNo]
                ['femtePrincipRight'])),
          ],
        ),
        Text(''),
        new Text(
          'Mere information',
          style: new TextStyle(fontSize: 20),
        ),
      ],
    );
  }

  /// Widget with the gesturedetector for getting more info on the politician.
  Widget _moreInfGestureDetectorWidget() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WebViewPage(
                  item[_politicianNo]['name'],
                  item[_politicianNo]['aboutURL'],
                  item[_politicianNo]['appBackgroundColor'])),
        );
      },
      child: new Image(
          image: AssetImage('graphics/about_male_version_4.png'),
          fit: BoxFit.fill),
    );
  }

  /// Widget with the GestureDetector for getting WebView about party.
  Widget _aboutPartyGestureDetectorWidget() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => WebViewPage(
                  _partyName,
                  item[_politicianNo]['partiURL'],
                  item[_politicianNo]['appBackgroundColor'])),
        );
      },
      child: new Image(
          image: AssetImage('graphics/website_thumbnail.png'),
          fit: BoxFit.fill),
    );
  }

  /// Widget for showing the GestureDetector that shows social media logos.
  Widget _socialMediaGestureDetectorWidget() {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: new Text(
                'Vælg medie',
                textAlign: TextAlign.center,
              ),
              content: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new Container(
                      margin: EdgeInsets.all(10),
                      width: 50.0,
                      height: 50.0,
                      decoration: new BoxDecoration(
                          image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: new AssetImage("graphics/fb_logo.png")))),
                  new Container(
                      margin: EdgeInsets.all(10),
                      width: 50.0,
                      height: 50.0,
                      decoration: new BoxDecoration(
                          image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: new AssetImage(
                                  "graphics/twitter_logo.png")))),
                  new Container(
                      margin: EdgeInsets.all(10),
                      width: 50.0,
                      height: 50.0,
                      decoration: new BoxDecoration(
                          image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: new AssetImage(
                                  "graphics/instagram_logo.png")))),
                  new Container(
                      margin: EdgeInsets.all(10),
                      width: 50.0,
                      height: 50.0,
                      decoration: new BoxDecoration(
                          image: new DecorationImage(
                              fit: BoxFit.fill,
                              image: new AssetImage(
                                  "graphics/linkedIn_logo.png")))),
                ],
              ),
            );
          },
        );
      },
      child: new Image(
          image: AssetImage('graphics/sociale_medier.png'), fit: BoxFit.fill),
    );
  }

  /// Widget for showing relevant info GestureDetector.
  Widget _relevantGestureDetectorWidget(){
    return GestureDetector(
      onTap: () {},
      child: new Image(
          image: AssetImage(
              'graphics/About_cases.png'),
          fit: BoxFit.fill),
    );
  }

  /// Widget for showing the two FAB's.
  Widget _fabWidget(){
    return new AnimatedOpacity(
      opacity: _hideFAB ? 0.0 : 1.0,
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
              onPressed: () {
                if (!_hideFAB) {
                  _newPolitician.performPolitician(false, context, item[_politicianNo]['id']);
                }
              },
              backgroundColor: Colors.white,
              child: Icon(Icons.thumb_down, color: Colors.red, size: 40.0),
            ),
          ),
          Text(''),
          Container(
              height: 80,
              width: 80,
              child: FloatingActionButton(
                heroTag: "btn2",
                onPressed: () {
                  if (!_hideFAB) {
                    _newPolitician.performPolitician(true, context, item[_politicianNo]['id']);
                  }
                },
                backgroundColor: Colors.white,
                child: Icon(Icons.thumb_up, color: Colors.green, size: 40.0),
              )),
        ],
      ),
    );
  }

  /// ## ---- REGULAR METHODS ---- ## ///

  /// Method for listening to scroll by the user.
  void _scrollListener() {
    if (_controller.position.userScrollDirection == ScrollDirection.reverse) {
      setState(() {
        _hideFAB = true;
      });
    }

    if (_controller.position.userScrollDirection == ScrollDirection.forward) {
      setState(() {
        _hideFAB = false;
      });
    }
  }
}


/// The stateful class.
class HomePage extends StatefulWidget {
  HomePageState createState() => new HomePageState();
}
