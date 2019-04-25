import 'dart:convert';

import 'package:demo_tinder_app/newpolitician.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatsHolder {
  List<String> _collectionList;
  Map<String, int> _statsMap = new Map();
  NewPolitician np = new NewPolitician();
  SharedPreferences prefs;

  StatsHolder() {
    _collectionList = np.collectionList;
    _generateStatsMap();
  }

  /// Method for generating the map with all of the liked politicians from each of the collections (parties).
  void _generateStatsMap() async {
    // Get the shared preference.
    prefs = await SharedPreferences.getInstance();
    // Counter for liked politicians.
    int counter = 0;

    // Find the collections to iterate over.
    for (int i = 0; i < _collectionList.length; i++) {
      if (prefs.getString(_collectionList[i] + "Map") == null ||
          prefs.getString(_collectionList[i] + "Map") == "" ||
          prefs.getString(_collectionList[i] + "Map") == {}) {
        print('STATSHOLDER: COLLECTION HAD NO LIKED PERSONS');
        return;
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
  }
}
