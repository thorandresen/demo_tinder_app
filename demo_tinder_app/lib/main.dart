import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/rendering.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:fit_image/fit_image.dart';
import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

void main() => runApp(MyApp());

String selectedUrl = 'https://flutter.io';
const kAndroidUserAgent =
    'Mozilla/5.0 (Linux; Android 6.0; Nexus 5 Build/MRA58N) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/62.0.3202.94 Mobile Safari/537.36';

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tinder demo',
      theme: ThemeData(
        primarySwatch: Colors.grey,
      ),
      home: WebViewPage(),
    );
  }
}

class HomePageState extends State<HomePage>{
  ScrollController _controller; // Scroll controller
  bool _hideFAB; //

  @override
  void initState(){
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
        body: NestedScrollView(
        controller: _controller,
                  headerSliverBuilder: (BuildContext context, bool innerBoxScrolled){
                      return <Widget>[
                        SliverAppBar(
                          floating: false,
                          pinned: true,
                          expandedHeight: 235,
                          backgroundColor: Color.fromARGB(255, 74, 104, 153),
                          centerTitle: true,
                          flexibleSpace: FlexibleSpaceBar(
                              title:  new Text('Lars Løkke (V)',
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
                                                  "https://pbs.twimg.com/profile_images/610120554738266112/I4pl2ygE_400x400.jpg")
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
                      ];
                  },
                  body:SingleChildScrollView(
                    /// TODO: FIX SO THAT FAB SHOWS WHEN SCROLLING BOTH VIEWS.
                  child: new Column(
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

                          // Politik
                          new Text('Politik',
                            style: new TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          new LinearPercentIndicator(
                            width: MediaQuery.of(context).size.width - 100,
                            alignment: MainAxisAlignment.center,
                            animation: true,
                            lineHeight: 20.0,
                            animationDuration: 2500,
                            percent: 0.9,
                            center: Text("9/10"),
                            linearStrokeCap: LinearStrokeCap.roundAll,
                            padding: EdgeInsets.symmetric(),
                            progressColor: Colors.blue,
                          ),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              new Flexible(child: Text('Socialisme')),
                              new Flexible(child: Text('')),
                              new Flexible(child: Text('Sociallib.')),
                              new Flexible(child: Text('')),
                              new Flexible(child: Text('Liberalisme')),
                            ],
                          ),

                          // Udlændinge politik
                          Text(''),
                          new Text('Udlændinge politik',
                            style: new TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          new LinearPercentIndicator(
                            width: MediaQuery.of(context).size.width - 100,
                            alignment: MainAxisAlignment.center,
                            animation: true,
                            lineHeight: 20.0,
                            animationDuration: 2500,
                            percent: 0.9,
                            center: Text("9/10"),
                            linearStrokeCap: LinearStrokeCap.roundAll,
                            padding: EdgeInsets.symmetric(),
                            progressColor: Colors.red,
                          ),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              new Flexible(child: Text('Lempelig')),
                              new Flexible(child: Text('')),
                              new Flexible(child: Text('')),
                              new Flexible(child: Text('')),
                              new Flexible(child: Text('')),
                              new Flexible(child: Text('Stram')),
                            ],
                          ),

                          // MILJØ
                          Text(''),
                          new Text('Miljøpolitik',
                            style: new TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          new LinearPercentIndicator(
                            width: MediaQuery.of(context).size.width - 100,
                            alignment: MainAxisAlignment.center,
                            animation: true,
                            lineHeight: 20.0,
                            animationDuration: 2500,
                            percent: 0.7,
                            center: Text("7/10"),
                            linearStrokeCap: LinearStrokeCap.roundAll,
                            padding: EdgeInsets.symmetric(),
                            progressColor: Colors.lightGreen,
                          ),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              new Flexible(child: Text('Fossil')),
                              new Flexible(child: Text('')),
                              new Flexible(child: Text('')),
                              new Flexible(child: Text('')),
                              new Flexible(child: Text('')),
                              new Flexible(child: Text('Grøn')),
                            ],
                          ),

                          // SKATTEPOLITIK
                          Text(''),
                          new Text('Privat skattepolitik',
                            style: new TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          new LinearPercentIndicator(
                            width: MediaQuery.of(context).size.width - 100,
                            alignment: MainAxisAlignment.center,
                            animation: true,
                            lineHeight: 20.0,
                            animationDuration: 2500,
                            percent: 0.3,
                            center: Text("3/10"),
                            linearStrokeCap: LinearStrokeCap.roundAll,
                            padding: EdgeInsets.symmetric(),
                            progressColor: Colors.blue,
                          ),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              new Flexible(child: Text('Lav')),
                              new Flexible(child: Text('')),
                              new Flexible(child: Text('')),
                              new Flexible(child: Text('')),
                              new Flexible(child: Text('')),
                              new Flexible(child: Text('Høj')),
                            ],
                          ),


                          // SKATTELETTELSER
                          Text(''),
                          new Text('Skattelettelser for erhverv',
                            style: new TextStyle(
                              fontSize: 15,
                            ),
                          ),
                          new LinearPercentIndicator(
                            width: MediaQuery.of(context).size.width - 100,
                            alignment: MainAxisAlignment.center,
                            animation: true,
                            lineHeight: 20.0,
                            animationDuration: 2500,
                            percent: 1,
                            center: Text("10/10"),
                            linearStrokeCap: LinearStrokeCap.roundAll,
                            padding: EdgeInsets.symmetric(),
                            progressColor: Colors.blue,
                          ),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              new Flexible(child: Text('Imod')),
                              new Flexible(child: Text('')),
                              new Flexible(child: Text('')),
                              new Flexible(child: Text('')),
                              new Flexible(child: Text('')),
                              new Flexible(child: Text('For')),
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
                               /// TODO: ADD INFO BANNER AND WHEN TOUCHED FOR ALL BELOW ALSO
                             },
                             child:  new Image(image: AssetImage('graphics/about_male_version_4.png'),fit: BoxFit.fill),
                           ),
                           GestureDetector(
                             onTap: () {
                               /// TODO: ADD INFO
                             },
                             child:  new Image(image: AssetImage('graphics/website_thumbnail.png'),fit: BoxFit.fill),
                           ),
                         ],
                     )
                    ],
                  ),
                  ),
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
}

class HomePage extends StatefulWidget {
  HomePageState createState() => new HomePageState();
}


/// WEBVIEW PAGE
///
class WebViewPageState extends State<WebViewPage>{
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        routes: {
          "/": (_) => new WebviewScaffold(
            url: 'https://stackoverflow.com/jobs/239220/senior-java-kotlin-engineer-retail-operations-zalando-se?med=clc',
            appBar: new AppBar(
              title: new Text("Widget webview"),
              centerTitle: true,
              backgroundColor: Color.fromARGB(255, 74, 104, 153),
            ),
            withJavascript: true,
            withZoom: true,
          ),
        },
      );
  }
}

class WebViewPage extends StatefulWidget{
  WebViewPageState createState() => new WebViewPageState();
}

