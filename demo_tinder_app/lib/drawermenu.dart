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
            child: Text('Kend Din Politiker'),
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
          ),
          ListTile(
            title: Text('Gennemse politikere'),
            onTap: () {
              // Update the state of the app
              // ...
              // Close navigator menu after press.
              Navigator.pop(context);
            },
          ),
          ListTile(
            title: Text('Statistik'),
            onTap: () {
              // Update the state of the app
              // ...
              // Close navigator menu after press.
              Navigator.pop(context);
            },
          ),
        ],
      ),
    );
  }
}