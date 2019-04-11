import 'dart:math';
import 'package:demo_tinder_app/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class NewPolitician {
  List<String> _collectionList = new List(2);
  List<String> _backgroundList = new List(2);
  int newPoliticianInt;
  String newPoliticianCollection;

  /// Constructor
  NewPolitician() {
    // COLLECTION LIST
    _collectionList[0] = "Venstre";
    _collectionList[1] = "SocialDemokraterne";

    // BACKGROUND LIST
    _backgroundList[0] = "graphics/Venstre_background.png";
    _backgroundList[1] = "graphics/SD_background.png";

    // Populate politicians
    _populatePoliticians();
  }

  /// Method for chosing what collection to look into.
  String collection(int index) {
     _collectionList.elementAt(index);
  }

  /// Method for chosing what collection to look into.
  String background(int bg) {
    return _backgroundList.elementAt(bg);
  }

  /// The method for calculating what to do with liked politician
  void performPolitician(bool isLiked, BuildContext context, String id, String collection) {
    print("ID: " + id + " is liked : " + isLiked.toString());
    _savePolitician(id, isLiked, collection);

    for(int i = 0 ; i < _collectionList.length; i++) {
      _iteratePolitician(_collectionList[i]);


    }

    /// HERE WE HAVE TO CHANGE BACK TO HOMEPAGE WITH COLLECTION AND NUMBER OF POLITICIAN.
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext _context) => HomePage()));
  }

  /// Saves a politician when he is seen and liked/disliked, into shared preferences. (REWRITE THIS CODE TO SAVE POLITICIANS IN THE CORRECT MAP. SO VENSTRE POLITICIANS GETS SAVED WITHIN A PREFERENCE CALLED VENSTRE)
  void _savePolitician(String id, bool isLiked, String collection) async {
    // Get the shared preference.
    final prefs = await SharedPreferences.getInstance();

    // IF DOESN'T EXIST
    if (prefs.getString("politicianMap") == null || prefs.getString("politicianMap") == "" || prefs.getString("politicianMap") == {}) {
      Map<String, dynamic> _politicianMapLocal = Map();
      _politicianMapLocal.update(
          id + " " + collection,
              (update) => isLiked,
          ifAbsent: () => isLiked
      );

      await prefs.setString("politicianMap", jsonEncode(_politicianMapLocal));
      print("POLITICIAN WAS FOUND IN SHAREDPREFERNECES: " +_politicianMapLocal.containsKey(id).toString());
    }
    else { // IF EXISTS.
      final _politicianMap = json.decode(
          prefs.getString("politicianMap") ?? "") ?? {};
      // Add the new politician to the map and to the shared preference.
      _politicianMap.update(
          id + " " + collection,
              (update) => isLiked,
          ifAbsent: () => isLiked
      );

      await prefs.setString("politicianMap", jsonEncode(_politicianMap));
      print("POLITICIAN WAS FOUND IN SHAREDPREFERNECES ELSE: " +_politicianMap.containsKey(id).toString());
    }
  }

  /// Used for populating (REWRITE THIS SO IT SAVES THE VENSTRE UNDER VESNTRELIST IN PREFS, SO I WILL KNOW WHO HAS WHAT AMOUNT OF POLITICIANS NAD CAN ITERATE.)
  void _populatePoliticians() async {
    // Get the shared preference.
    final prefs = await SharedPreferences.getInstance();

    // IF DOESN'T EXIST
    if (prefs.getString("politicianHolder") == null || prefs.getString("politicianHolder") == "" || prefs.getString("politicianHolder") == {}) {
      List<String> _localHolder = [];

      List<String> venstreList = new List(3);
      venstreList[0] = '1LarsLøkke';
      venstreList[1] = '2AnniMatthiesen';
      venstreList[2] = '3Test';

      List<String> sdList = new List(3);
      sdList[0] = '1MetteFrederiksen';
      sdList[1] = '2Test';
      sdList[2] = '3Test';

      _localHolder.addAll(venstreList);
      _localHolder.addAll(sdList);


      await prefs.setString("politicianHolder", jsonEncode(_localHolder));
      print('POLITICIANHOLDER HAS BEEN POPULATED BISH: ' + _localHolder.length.toString());
    }
  }

  /// THIS METHOD IS SUPPOSED TO ITERATE THROUGH THE MAP AND CHECK IT UP AGAINST (AFTER REFACOTRING THE TWO OTHER METHODS TO WORK WITH COLLECTIONS, ITERATE OVER A COLLECTION HERE).
  void _iteratePolitician(String collection) async{
    // Get the shared preference.
    final prefs = await SharedPreferences.getInstance();
  }
}