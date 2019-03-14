import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:fit_image/fit_image.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Tinder demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: HomePage(),
    );
  }
}

class HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
    backgroundColor: Colors.white,
      body: Container(
                  child: new Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      DecoratedBox(
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
                          Text(''),
                        ],
                      ),
             decoration: BoxDecoration(
               image: DecorationImage(
                image: NetworkImage(
                  "https://i.imgur.com/ijQ7mNU.png"),
                      fit: BoxFit.fill)
                      ),
                      ),
                      new Column( // Politiske præfferencer
                        children: <Widget>[
                          Text(''),
                          new Text('Kerne principper',
                            style: new TextStyle(
                              fontSize: 20.0,
                            ),
                          ),
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
                          ),
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
                              new Flexible(child: Text('Kul')),
                              new Flexible(child: Text('')),
                              new Flexible(child: Text('')),
                              new Flexible(child: Text('')),
                              new Flexible(child: Text('')),
                              new Flexible(child: Text('Grøn')),
                            ],
                          ),

                        ],
                      ),
                      Text(''),
                      new Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Container(
                            height: 70,
                            width: 70,
                            child: FloatingActionButton(
                              onPressed: () {},
                              backgroundColor: Colors.white,
                              child: Icon(Icons.favorite, color: Colors.green,size: 35.0),
                            ),
                          ),
                          Container(
                              height: 70,
                              width: 70,
                              child:
                              FloatingActionButton(
                                onPressed: () {},
                                backgroundColor: Colors.white,
                                child: Icon(Icons.cancel, color: Colors.red,size: 35.0),
                              )
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
    );
  }

}

class HomePage extends StatefulWidget {
  HomePageState createState() => new HomePageState();
}

