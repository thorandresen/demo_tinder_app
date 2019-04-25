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

  void _generateStatsMap() async {
    // Get the shared preference.
    prefs = await SharedPreferences.getInstance();

    for (int i = 0; i < _collectionList.length; i++){
      if (prefs.getString(_collectionList[i] + "Map") == null || prefs.getString(_collectionList[i] + "Map") == "" || prefs.getString(_collectionList[i] + "Map") == {}){
        print('STATSHOLDER: COLLECTION HAD NO LIKED PERSONS');
        return;
      }
      else{
        final _politicianMap = await json.decode(
            prefs.getString(_collectionList[i] + "Map") ?? "") ?? {};
        
        _statsMap.update(
            _collectionList[i],
            (update) =>  _politicianMap.length,
          ifAbsent: () => _politicianMap.length
        );
        print('Statsmap was added with: ' + _collectionList[i] + " with length of: " + _politicianMap.length.toString());
      }
    }
  }
}