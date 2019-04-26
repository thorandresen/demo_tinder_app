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
                future: _calculator(),
                builder: (BuildContext context, AsyncSnapshot snapshot) {
                  if(snapshot.data != null) {
                    return chart();
                  }
                  else {
                    return new Container(
                      child: Column(
                        children: <Widget>[
                          Text(''),
                          new CircularProgressIndicator(),
                          Text(''),
                        new Text('Ingen politkkere er liket endnu... Back to swiping!', style: TextStyle(
                        fontSize: 18.0,
                      ),),
                        ],
                      )
                    );
                  }
                },
              ),
              Text(''),
              Text(''),
              Text('Flere stastikker på vej...', style: TextStyle(
                color: Colors.grey,
              ),)
            ],
          )
        ],
      ),
      drawer: DrawerMenu().drawerMenu(context),
    );
  }

  Future<void> _calculator() async {
    bool test = await sh.generateStatsMap();
    map = sh.statsMap;

    if (test && map.isNotEmpty) {
      print('I am working!');
      return map;
    }
    else{
      print('I am not working!');
      return null;
    }
  }



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
