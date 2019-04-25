import 'dart:async';
import 'dart:io';

import 'package:demo_tinder_app/drawermenu.dart';
import 'package:demo_tinder_app/statsgenerator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';

class StatisticsPage extends StatefulWidget {
  StatisticsPageState createState() => new StatisticsPageState();
}

class StatisticsPageState extends State<StatisticsPage> {
  StatsGenerator sh = new StatsGenerator();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Statistikker'),
      ),
      body: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('Partifordeling af likede politikkere'),
              chart(),
            ],
          )
        ],
      ),
      drawer: DrawerMenu().drawerMenu(context),
    );
  }

  Widget chart() {
    Map<String, double> map = sh.statsMap;
    print('MAP CONTAINS: ' + map.containsKey('Venstre').toString());

    return PieChart(
      dataMap: map,
      legendFontColor: Colors.blueGrey[900],
      legendFontSize: 14.0,
      legendFontWeight: FontWeight.w500,
      animationDuration: Duration(milliseconds: 800),
      chartLegendSpacing: 32.0,
      chartRadius: MediaQuery
          .of(context)
          .size
          .width / 1.8,
      showChartValuesInPercentage: false,
      showChartValues: true,
      chartValuesColor: Colors.blueGrey[900].withOpacity(0.9),
    );
  }
}
