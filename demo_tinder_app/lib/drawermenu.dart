import 'dart:async';

import 'package:demo_tinder_app/homepage.dart';
import 'package:demo_tinder_app/newpolitician.dart';
import 'package:demo_tinder_app/savedpoliticians.dart';
import 'package:demo_tinder_app/settings.dart';
import 'package:demo_tinder_app/statistics.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DrawerMenu {

  Widget drawerMenu(BuildContext context) {
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Container(
                margin: EdgeInsets.all(10),
                width: 80,
                height: 80,
                decoration: new BoxDecoration(
                    shape: BoxShape.circle,
                    image: new DecorationImage(
                        fit: BoxFit.fill,
                        image: new NetworkImage(
                           'https://png2.kisspng.com/sh/9339e7b64a97349a5bdbd4f58f165e36/L0KzQYm3U8I5N5R2j5H0aYP2gLBuTfNqepRxfZ91b3fyPcTCjfJwdF5rh9D9LYTofcHzggRme146edRrZkm4R7a9hMZjOF85T6Y5NkS8QIK8UsIzPmk6SKUENEW4PsH1h5==/kisspng-circle-logo-symbol-font-templates-5abbf957e6d6b0.4740649015222685039455.png')))),
      Text('Kend Din Politiker',style: TextStyle(
        fontSize: 18.0,
      ),),
        ],
      ),
            decoration: BoxDecoration(
              color: Colors.deepOrange,
            ),
          ),
          ListTile(
            title: new Row(
              children: <Widget>[
                new Icon(Icons.forward),
                Text('   '),
                Text('Gennemse politikere', style: TextStyle(
                  fontSize: 15
                ),),
              ],
            ),
            onTap: () {
              NewPolitician np = new NewPolitician();
              new Timer(const Duration(seconds: 1), ()=> np.performPolitician(false, context, 'gwa', 'gwa'));
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: new Row(
              children: <Widget>[
                new Icon(Icons.account_circle),
                Text('   '),
                Text('Gemte politikere', style: TextStyle(
                    fontSize: 15
                ),),
              ],
            ),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (BuildContext _context) => SavedPoliticiansPage()));
            },
          ),
          ListTile(
            title: new Row(
              children: <Widget>[
                new Icon(Icons.assessment),
                Text('   '),
                Text('Statistik', style: TextStyle(
                    fontSize: 15
                ),),
              ],
            ),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (BuildContext _context) => StatisticsPage()));
            },
          ),
          ListTile(
            title: new Row(
              children: <Widget>[
                new Icon(Icons.settings),
                Text('   '),
                Text('Indstillinger', style: TextStyle(
                    fontSize: 15
                ),),
              ],
            ),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (BuildContext _context) => SettingsPage()));
            },
          ),
        ],
      ),
    );
  }
}