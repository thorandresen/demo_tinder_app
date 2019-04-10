import 'dart:math';
import 'package:demo_tinder_app/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class NewPolitician {
  List<String> _collectionList = new List(2);
  List<String> _backgroundList = new List(2);

// Json files.
  String fileName = "politicalData.json";
  bool fileExists = false;
  Map<String, String> fileContent;
  int i = 0;


  NewPolitician() {
    // COLLECTION LIST
    _collectionList[0] = "Venstre";
    _collectionList[1] = "SocialDemokraterne";

    // BACKGROUND LIST
    _backgroundList[0] = "graphics/Venstre_background.png";
    _backgroundList[1] = "graphics/SD_background.png";
  }

  /// Method for chosing what collection to look into.
  String collection() {
    Random random = new Random();

    return _collectionList.elementAt(random.nextInt(_collectionList.length));
  }

  /// Method for chosing what collection to look into.
  String background(int bg) {
    return _backgroundList.elementAt(bg);
  }

  /// The method for calculating what to do with liked politician
  void performPolitician(bool isLiked, BuildContext context, String id) {
    print("ID: " + id + " is liked : " + isLiked.toString());
    _savePolitician(id, isLiked);

    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext _context) => HomePage()));
  }


  void _savePolitician(String id, bool isLiked) async {
    // Get the shared preference.
    final prefs = await SharedPreferences.getInstance();

    /**/

    // IF DOESN'T EXIST
    if (prefs.getString("politicianMap") == null || prefs.getString("politicianMap") == "" || prefs.getString("politicianMap") == {}) {
      Map<String, dynamic> _politicianMapLocal = Map();
      _politicianMapLocal.update(
          id,
              (update) => isLiked,
          ifAbsent: () => isLiked
      );

      await prefs.setString("politicianMap", jsonEncode(_politicianMapLocal));
      print("POLITICIAN WAS FOUND IN SHAREDPREFERNECES: " +_politicianMapLocal.containsKey(id).toString());
    }
    else {
      final _politicianMap = json.decode(
          prefs.getString("politicianMap") ?? "") ?? {};
      // Add the new politician to the map and to the shared preference.
      _politicianMap.update(
          id,
              (update) => isLiked,
          ifAbsent: () => isLiked
      );

      await prefs.setString("politicianMap", jsonEncode(_politicianMap));
      print("POLITICIAN WAS FOUND IN SHAREDPREFERNECES ELSE: " +_politicianMap.containsKey(id).toString());
    }


  }
}