import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:percent_indicator/percent_indicator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tinder demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('HomePage'),
      ),
      body:
      FlipCard(
                direction: FlipDirection.HORIZONTAL, // default
                front: Container(
                  decoration: new BoxDecoration(
                    border: new Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  margin: EdgeInsets.all(10.0),
                  child: new Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      new Column(
                        children: <Widget>[
                          new Container(
                              margin: EdgeInsets.all(10),
                              width: 190.0,
                              height: 190.0,
                              decoration: new BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: new Border.all(color: Colors.black),
                                  image: new DecorationImage(
                                      fit: BoxFit.fill,
                                      image: new NetworkImage(
                                          "https://pbs.twimg.com/profile_images/610120554738266112/I4pl2ygE_400x400.jpg")
                                  )
                              )
                          ),
                          new Text('Lars Løkke',
                            style: new TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
                          new Text('Venstre',
                            style: new TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ],
                      ),
                      new Column( // Politiske præfferencer
                        children: <Widget>[
                          Divider(
                            color: Colors.black,
                          ),
                          new Text('Kerne principper',
                            style: new TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
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
                            progressColor: Colors.green,
                          ),
                          new Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: <Widget>[
                              new Flexible(child: Text('Kul')),
                              new Flexible(child: Text('')),
                              new Flexible(child: Text('')),
                              new Flexible(child: Text('')),
                              new Flexible(child: Text('')),
                              new Flexible(child: Text('Grøn')),
                            ],
                          ),
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
                              new Flexible(child: Text('Åben')),
                              new Flexible(child: Text('')),
                              new Flexible(child: Text('')),
                              new Flexible(child: Text('')),
                              new Flexible(child: Text('')),
                              new Flexible(child: Text('Stram')),
                            ],
                          )
                        ],
                      )
                    ],
                  ),
                ),
                back: Container(
                  decoration: new BoxDecoration(
                    border: new Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  margin: EdgeInsets.all(10.0),
                  child: Text('Back'),
                ),
              ),
    );
  }

}

class HomePage extends StatefulWidget {
  HomePageState createState() => new HomePageState();
}

