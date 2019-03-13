import 'package:flutter/material.dart';
import 'package:flip_card/flip_card.dart';

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
              new Text(
                'Lars Løkke',
                style: new TextStyle(
                  fontSize: 20.0,
                ),
              ),
              Text('Venstre'),
              Divider(
                color: Colors.black,
              ),
              Text('Politiske præfferencer'),
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

