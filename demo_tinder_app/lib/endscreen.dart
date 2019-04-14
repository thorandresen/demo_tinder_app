import 'package:demo_tinder_app/webview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class EndScreenPage extends StatefulWidget{
  EndScreenPageState createState() => new EndScreenPageState();
}

class EndScreenPageState extends State<EndScreenPage> {
  MediaQueryData queryData;

  @override
  void initState(){
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    queryData = MediaQuery.of(context);
    return Scaffold(
        body: new Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                new Icon(Icons.update,
                    size: 15 * (queryData.size.width/100),
                    color: Colors.red),
                new Flexible(
                  child: new Text(
                    'Du har svipet igennem alle politikere!',
                    style: TextStyle(
                      fontSize: 6 * (queryData.size.width/100),
                      color: Colors.red,
                    ),
                  ),
                ),
                new Flexible(
                  child: new Text(
                    'Prøv igen senere eller reset dine likes.',
                    style: TextStyle(
                      fontSize: 4.5 * (queryData.size.width/100),
                    ),
                  ),
                ),
                new Flexible(
                  child: new Text('Husk at tjekke dine statistikker!',
                    style: TextStyle(
                      fontSize: 4.5 * (queryData.size.width/100),
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