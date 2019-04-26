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
  Map<String, double> map;

  @override
  Widget build(BuildContext context) {
    map = sh.statsMap;
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
              Text(
                'Fordeling af likede politikkere',
                style: TextStyle(fontSize: 20.0),
              ),
              new FutureBuilder<void>(
                // Future builder for making sure that u piechart is only shown when it needs to.
                future: _calculator(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if (snapshot.data != null) {
                    return chart();
                  } else {
                    return new Container(
                        child: Column(
                      children: <Widget>[
                        Text(''),
                        new CircularProgressIndicator(),
                        Text(''),
                        new Text(
                          'Ingen politkkere er liket endnu...',
                          style: TextStyle(
                            fontSize: 18.0,
                          ),
                        ),
                      ],
                    ));
                  }
                },
              ),
              Text(''),
              Text(''),
              Text(
                'Flere stastikker på vej...',
                style: TextStyle(
                  color: Colors.grey,
                ),
              )
            ],
          )
        ],
      ),
      drawer: DrawerMenu().drawerMenu(context),
    );
  }

  /// Method for calculating whether it should show the chart.
  Future<void> _calculator() async {
    bool test = await sh.generateStatsMap();
    map = sh.statsMap;

    if (test && map.isNotEmpty) {
      print('I am working!');
      return map;
    } else {
      print('I am not working!');
      return null;
    }
  }

  /// Method for returning the piechart for showing amount of liked politicians in different parties.
  Widget chart() {
    return PieChart(
      dataMap: map,
      legendFontColor: Colors.blueGrey[900],
      legendFontSize: 14.0,
      legendFontWeight: FontWeight.w500,
      animationDuration: Duration(milliseconds: 800),
      chartLegendSpacing: 32.0,
      chartRadius: MediaQuery.of(context).size.width / 3,
      showChartValuesInPercentage: false,
      showChartValues: true,
      chartValuesColor: Colors.blueGrey[900].withOpacity(0.9),
    );
  }
}
