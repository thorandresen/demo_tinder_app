import 'package:demo_tinder_app/drawermenu.dart';
import 'package:demo_tinder_app/statsholder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart';

class StatisticsPage extends StatefulWidget {
  StatisticsPageState createState() => new StatisticsPageState();
}

class StatisticsPageState extends State<StatisticsPage> {
  StatsHolder sh = new StatsHolder();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Statistikker'),
      ),
      body: new Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Row(
            children: <Widget>[
              Text('Partifordeling af likede politikkere'),
            ],
          )
        ],
      ),
      drawer: DrawerMenu().drawerMenu(context),
    );
  }
}
