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

  /// THERE IS NEED FOR ITERATING OVER THE SPECIFIC MAP AND RETRIEVING ONLY THE LIKED POLITICIANS IN THIS METHOD INSTEAD OF ALL POLITICIANS.
  void _generateStatsMap() async {
    // Get the shared preference.
    prefs = await SharedPreferences.getInstance();
    int counter = 0;

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

        var _polList = _politicianMap.values.toList();

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
            } else {
              print('Poltician was not liked!');
            }
          }
          counter = 0;
        } else {
          print('STATSHOLDER: no liked polticians');
        }
      }
    }
  }
}
