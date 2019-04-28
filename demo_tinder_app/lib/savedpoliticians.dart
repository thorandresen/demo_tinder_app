import 'package:demo_tinder_app/drawermenu.dart';
import 'package:demo_tinder_app/statsgenerator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SavedPoliticiansPage extends StatefulWidget{
  SavedPoliticiansPageState createState() => new SavedPoliticiansPageState();
}

class SavedPoliticiansPageState extends State<SavedPoliticiansPage> {
  StatsGenerator sh = new StatsGenerator();
  String _selectedCollection;
  List<String> _collections = [];

  @override
  Widget build(BuildContext context) {
    _calculator();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Gemte politikere'),
      ),
      body: new Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          new FutureBuilder(
            future: _calculator(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data != null) {
                return _buildList('Venligst vælg et parti');
              }
              else{
                return _buildList('Ingen politikere liket endnu');
              }
            }
          ),
        ],
      ),
      drawer: DrawerMenu().drawerMenu(context),
    );
  }

  Future<void> _calculator() async {
    bool test = await sh.generateStatsMap();
    _collections = sh.statsMap.keys.toList();

    if(test && _collections.isNotEmpty){
      return _collections;
    }
    else{
      return null;
    }

  }

  Widget _buildList(String hint){
    return DropdownButton(
      hint: Text(hint), // Not necessary for Option 1
      value: _selectedCollection,
      onChanged: (newValue) {
        setState(() {
          _selectedCollection = newValue;
        });
      },
      items: _collections.map((location) {
        return DropdownMenuItem(
          child: new Text(location),
          value: location,
        );
      }).toList(),
    );
  }
}