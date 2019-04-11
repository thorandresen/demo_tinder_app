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
  String newPoliticianString;

  /// Constructor
  NewPolitician() {
    // COLLECTION LIST
    _collectionList[0] = "Venstre";
    _collectionList[1] = "SocialDemokraterne";

    // BACKGROUND LIST
    _backgroundList[0] = "graphics/Venstre_background.png";
    _backgroundList[1] = "graphics/SD_background.png";

    // Populate politicians
    for(int i = 0; i < _collectionList.length; i++){
      _populatePoliticians(_collectionList[i]);
    }

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

    // Actually iterating over politicians and finding one.
      _iteratePolitician(_collectionList[1]);


    /// HERE WE HAVE TO CHANGE BACK TO HOMEPAGE WITH COLLECTION AND NUMBER OF POLITICIAN.
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext _context) => HomePage(_collectionList[0], newPoliticianString)));
  }

  /// PROBLEM! WE DON'T CREATE THE MAP FOR VENSTRE UNLESS WE WANT TO SAVE SOMEONE, THIS MEANS THAT THERE IS NO MAP FOR SOCIALDEMOKRATERNE YET!! A METHOD HAS TO BE CREATED TO CREATE BOTH OF THESE MAPS WITH FAKE INPUT:)
  /// THIS IS THE REASON THAT I GET MAP NULL EVERYTIME I GO FROM VENSTRE TO SOCIALDEMOKRATERNE, BECAUSE IT TRIES TO ITERATE BUT IT HAS ONLY SAVED LARS LØKKE SO THE OTHER MAP DOESNT EXSIST YET!!!!!
  void _savePolitician(String id, bool isLiked, String collection) async {
    // Get the shared preference.
    final prefs = await SharedPreferences.getInstance();

    // IF DOESN'T EXIST
    if (prefs.getString(collection + "Map") == null || prefs.getString(collection + "Map") == "" || prefs.getString(collection + "Map") == {}) {
      Map<String, dynamic> _politicianMapLocal = Map();
      _politicianMapLocal.update(
          id,
              (update) => isLiked,
          ifAbsent: () => isLiked
      );

      await prefs.setString(collection + "Map", jsonEncode(_politicianMapLocal));
      print("POLITICIAN WAS FOUND IN SHAREDPREFERNECES: " +_politicianMapLocal.containsKey(id).toString());
    }
    else { // IF EXISTS.
      final _politicianMap = json.decode(
          prefs.getString(collection + "Map") ?? "") ?? {};
      // Add the new politician to the map and to the shared preference.
      _politicianMap.update(
          id,
              (update) => isLiked,
          ifAbsent: () => isLiked
      );

      await prefs.setString(collection + "Map", jsonEncode(_politicianMap));
      print("POLITICIAN WAS FOUND IN SHAREDPREFERNECES ELSE: " +_politicianMap.containsKey(id).toString());
    }
  }

  /// Used for populating (REWRITE THIS SO IT SAVES THE VENSTRE UNDER VESNTRELIST IN PREFS, SO I WILL KNOW WHO HAS WHAT AMOUNT OF POLITICIANS NAD CAN ITERATE.)
  void _populatePoliticians(String collection) async {
    // Get the shared preference.
    final prefs = await SharedPreferences.getInstance();

    // IF DOESN'T EXIST
    if (prefs.getString(collection+"Holder") == null || prefs.getString(collection+"Holder") == "" || prefs.getString(collection+"Holder") == {}) {
      List<String> _localHolder = [];

      switch(collection){
        case 'Venstre':
          List<String> venstreList = new List(3);
          venstreList[0] = '1LarsLøkke';
          venstreList[1] = '2AnniMatthiesen';
          venstreList[2] = '3Test';
          _localHolder.addAll(venstreList);
          break;
        case 'SocialDemokraterne':
          List<String> sdList = new List(3);
          sdList[0] = '1MetteFrederiksen';
          sdList[1] = '2Test';
          sdList[2] = '3Test';
          _localHolder.addAll(sdList);
          break;
      }

      await prefs.setString(collection+"Holder", jsonEncode(_localHolder));
      print('POLITICIANHOLDER HAS BEEN POPULATED BISH: ' + _localHolder.length.toString());
    }
    print('POLITICIANHOLDER WAS BEEN POPULATED BISH: ' + prefs.getString(collection+"Holder").length.toString());
  }

  /// THIS METHOD IS SUPPOSED TO ITERATE THROUGH THE MAP AND CHECK IT UP AGAINST (AFTER REFACOTRING THE TWO OTHER METHODS TO WORK WITH COLLECTIONS, ITERATE OVER A COLLECTION HERE).
  void _iteratePolitician(String collection) async {
    // Get the shared preference.
    final prefs = await SharedPreferences.getInstance();
    int localCounter;

    if (prefs.getString(collection + "Map") == null ||
        prefs.getString(collection + "Map") == "" ||
        prefs.getString(collection + "Map") == {}) {
      print('MAP IS NULL');
    }
    else {
      final _politicianMap = json.decode(
          prefs.getString(collection + "Map") ?? "") ?? {};

      final _politicianHolder = json.decode(
          prefs.getString(collection + "Holder") ?? "") ?? {};

      List<String> _mapList = _politicianMap.keys.toList();

      for (int i = 0; i < _politicianMap.length; i++) {
        if (_politicianHolder[i] != _mapList[i]) {
          print("THIS POLITICIAN WAS FOUND GOOD: " + _politicianHolder[i]);
          newPoliticianString = _politicianHolder[i];
          return;
        }
        else {
          localCounter = i;
        }
      }
      newPoliticianString = _politicianHolder[localCounter+1];
    }
  }
}