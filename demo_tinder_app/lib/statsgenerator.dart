import 'dart:convert';

import 'package:demo_tinder_app/newpolitician.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatsGenerator {
  List<String> _collectionList;
  Map<String, double> _statsMap = new Map();
  List<String> _likedPoliticiansList = [];
  NewPolitician np = new NewPolitician();
  SharedPreferences prefs;

  StatsGenerator() {
    _collectionList = np.collectionList;
  }

  /// Method for generating the map with all of the liked politicians from each of the collections (parties).
  Future<bool> generateStatsMap() async {
    // Get the shared preference.
    prefs = await SharedPreferences.getInstance();
    // Counter for liked politicians.
    double counter = 0;

    // Find the collections to iterate over.
    for (int i = 0; i < _collectionList.length; i++) {
      if (prefs.getString(_collectionList[i] + "Map") == null ||
          prefs.getString(_collectionList[i] + "Map") == "" ||
          prefs.getString(_collectionList[i] + "Map") == {}) {
        print('STATSHOLDER: COLLECTION HAD NO LIKED PERSONS');
      } else {
        final _politicianMap = await json
                .decode(prefs.getString(_collectionList[i] + "Map") ?? "") ??
            {};

        // Take the values of the given collection and save it as a list for easier iteration.
        var _polList = _politicianMap.values.toList();

        // Iterate over the liked politicians.
        if (_polList.length != 0 || _polList.length != null || _polList != {}) {
          for (int j = 0; j < _polList.length; j++) {
            print('Value of politician is: ' + _polList[j].toString());
            if (_polList[j]) {
              counter++;
              _statsMap.update(_collectionList[i], (update) => counter,
                  ifAbsent: () => counter);

              print('Statsmap was added with: ' +
                  _collectionList[i] +
                  " with length of: " +
                  counter.toString());
            }
          }
          // Reset counter for use in next collection.
          counter = 0;
        } else {
          print('STATSHOLDER: no liked polticians');
        }
      }
    }
    print('MAP IS NOT EMPTY?: ' + _statsMap.isNotEmpty.toString());
    return true;
  }

  Future<bool> generateLikedPoliticianMap(String collection) async {
    // Get the shared preference.
    prefs = await SharedPreferences.getInstance();

    if (prefs.getString(collection + "Map") == null ||
        prefs.getString(collection + "Map") == "" ||
        prefs.getString(collection + "Map") == {}) {
      return false;
    }
    else{
      _likedPoliticiansList.clear(); // Clearing the _likedpolitcianList before adding new values.
      final _politicianMap = await json
          .decode(prefs.getString(collection + "Map") ?? "") ??
          {};

      var _polList = _politicianMap.values.toList();
      List<String> _idList = _politicianMap.keys.toList();

      for(int i = 0; i < _politicianMap.length; i++){
        if(_polList[i]){
          _likedPoliticiansList.add(_idList[i]);
          print('Liked politician was added to list: ' + _idList[i]);
        }
        else{
          print('Politician wasnt liked');
        }
      }
      return true;
    }
  }

  List<String> get likedPoliticiansList => _likedPoliticiansList;
  Map<String, double> get statsMap => _statsMap;
}
