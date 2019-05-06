import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:demo_tinder_app/drawermenu.dart';
import 'package:demo_tinder_app/homepage.dart';
import 'package:demo_tinder_app/statsgenerator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SavedPoliticiansPage extends StatefulWidget {
  SavedPoliticiansPageState createState() => new SavedPoliticiansPageState();
}

class SavedPoliticiansPageState extends State<SavedPoliticiansPage> {
  StatsGenerator sh = new StatsGenerator();
  String _selectedCollection;
  List<String> _collections = [];
  List<int> _likedPoliticans = [];

  @override
  Widget build(BuildContext context) {
    _calculator();
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Likede politikere'),
      ),
      body: new Container(
        child: new Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Expanded(
              child: new Column(
                children: <Widget>[
                  /// Dropdown menu
                  new FutureBuilder(
                      future: _calculator(),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.data != null) {
                          return _buildMenu('Venligst vælg et parti');
                        } else {
                          return _buildMenu('Ingen politikere liket endnu');
                        }
                      }),

                  /// Listview
                  new FutureBuilder(
                    future: _retrievePoliticians(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.data != null) {
                        return _buildList();
                      } else {
                        return Text('');
                      }
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      drawer: DrawerMenu().drawerMenu(context),
    );
  }

  /// Method used with the future builder for returning correct hint for the dropdown menu.
  Future<void> _calculator() async {
    bool test = await sh.generateStatsMap();
    _collections = sh.statsMap.keys
        .toList(); // Retrieve all the collections with liked politicians.
    if (test && _collections.isNotEmpty) {
      return _collections;
    } else {
      return null;
    }
  }

  /// The method that retrieves the firestore number for all the correct politicians. This puts all the correct ints into the _likedPoliticans list.
  Future<bool> _retrievePoliticians() async {
    bool test = await sh.generateLikedPoliticianMap(_selectedCollection);
    if (test) {
      _likedPoliticans.clear(); // Clearing the liked politician.

      List<String> _likedPoliticansString = sh.likedPoliticiansList;

      for (int i = 0; i < _likedPoliticansString.length; i++) {
        String cutString = _likedPoliticansString[i].substring(0, 1);
        int correctNumber = int.parse(cutString) - 1;
        _likedPoliticans.add(correctNumber);
        print('This number was added to the list: ' + correctNumber.toString());
      }
      if (_likedPoliticans.length > 0) {
        return true;
      }
    } else {
      print('Something went wrong in getting liked politcians.');
      return false;
    }
  }

  /// The method that actually builds the dropdown menu.
  Widget _buildMenu(String hint) {
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

  /// For building the list.
  Widget _buildList() {
    return new StreamBuilder(
        stream: Firestore.instance.collection(_selectedCollection).snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) return new CircularProgressIndicator();
          return new ListView.builder(
              shrinkWrap: true,
              itemCount: _likedPoliticans.length,
              itemBuilder: (BuildContext context, int index) {
                List<DocumentSnapshot> item = snapshot.data.documents;
                return new ListTile(
                  title: Text(item[_likedPoliticans[index]]['name']),
                  subtitle: Text(item[_likedPoliticans[index]]['partiName']),
                  trailing: new Icon(Icons.arrow_forward_ios),
                  onTap: () {
                      print('Index of this politician is: $index' + ' and number of politician in array is: ' + _likedPoliticans[index].toString());
                      change(index);
                  },
                );
              });
        });
  }

  void change(int index){
    Navigator.push(context,
        MaterialPageRoute(builder: (BuildContext _context) => HomePage(_selectedCollection, (_likedPoliticans[index]+1).toString(), false)));
  }
}
