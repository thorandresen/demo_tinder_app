import 'dart:math';
import 'package:demo_tinder_app/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'endscreen.dart';

class NewPolitician {
  List<String> _collectionList = new List(2);
  List<String> _backgroundList = new List(2);
  int newPoliticianInt;
  String newPoliticianCollection = '';
  String newPoliticianString = '';
  bool waitBool;
  BuildContext context;
  SharedPreferences prefs;

  /// Constructor
  NewPolitician() {

    // COLLECTION LIST
    _collectionList[0] = "Venstre";
    _collectionList[1] = "SocialDemokraterne";

    // BACKGROUND LIST
    _backgroundList[0] = "graphics/Venstre_background.png";
    _backgroundList[1] = "graphics/SD_background.png";

    // Populate politicians
      _populatePoliticians(_collectionList[0]);
      _populatePoliticians(_collectionList[1]);
  }

  /// Method for chosing what collection to look into.
  void _collection() async {
    prefs = await SharedPreferences.getInstance();
    List<String> _goodCollections = [];

    for(int i = 0; i < _collectionList.length; i++) {
      if (prefs.getString(_collectionList[i] + "Map") == null || prefs.getString(_collectionList[i] + "Map") == "" || prefs.getString(_collectionList[i] + "Map") == {}) {
        _goodCollections.add(_collectionList[i]);
        print('COLLECTION: ' + _collectionList[i] + ' WAS GOOD AND EMPTY!');
      }
      else if(prefs.getString(_collectionList[i] + "Holder") == null || prefs.getString(_collectionList[i] + "Holder") == "" || prefs.getString(_collectionList[i] + "Holder") == {}){
        _populatePoliticians(_collectionList[i]);
        _collection();
        return;
      }
      else {
        final _politicianMap = await json.decode(
            prefs.getString(_collectionList[i] + "Map") ?? "") ?? {};

        final _politicianHolder  = await json.decode(
            prefs.getString(_collectionList[i] + "Holder") ?? "") ?? {};


        if(_politicianMap.length < _politicianHolder.length){
          _goodCollections.add(_collectionList[i]);
          print('COLLECTION: ' + _collectionList[i] + ' WAS GOOD BUT NOT EMPTY! - AND LENGTH OF MAP WAS: ' + _politicianMap.length.toString());
          print('COLLECTION HOLDER LENGTH: ' +_politicianHolder.length.toString() );
        }
      }
    }

    if(_goodCollections.length == 1){
      newPoliticianCollection = _goodCollections[0];
    }else if(_goodCollections.length > 1) {
      Random random = new Random();
      newPoliticianCollection = _goodCollections[random.nextInt(_collectionList.length)];
    }
    else{
      print('COLLECTION LIST WAS EMPTY AS FUCK IDIOT');
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext _context) => EndScreenPage()));
      return;
    }

    print('COLLECTION LIST IS: ' + _goodCollections.length.toString());
    print('COLLECTION CHOSEN WAS: $newPoliticianCollection');
    _iteratePolitician(newPoliticianCollection);

  }

  /// Method for chosing what collection to look into.
  String background(int bg) {
    return _backgroundList.elementAt(bg);
  }

  /// The method for calculating what to do with liked politician
  void performPolitician(bool isLiked, BuildContext context, String id, String collection) {
    print("ID: " + id + " is liked : " + isLiked.toString());
    this.context = context;

    _savePolitician(id, isLiked, collection);


    // Actually iterating over politicians and finding one.

    /// HERE WE HAVE TO CHANGE BACK TO HOMEPAGE WITH COLLECTION AND NUMBER OF POLITICIAN.

  }

  /// PROBLEM! WE DON'T CREATE THE MAP FOR VENSTRE UNLESS WE WANT TO SAVE SOMEONE, THIS MEANS THAT THERE IS NO MAP FOR SOCIALDEMOKRATERNE YET!! A METHOD HAS TO BE CREATED TO CREATE BOTH OF THESE MAPS WITH FAKE INPUT:)
  /// THIS IS THE REASON THAT I GET MAP NULL EVERYTIME I GO FROM VENSTRE TO SOCIALDEMOKRATERNE, BECAUSE IT TRIES TO ITERATE BUT IT HAS ONLY SAVED LARS LØKKE SO THE OTHER MAP DOESNT EXSIST YET!!!!!
  void _savePolitician(String id, bool isLiked, String collection) async {
    // Get the shared preference.
    prefs = await SharedPreferences.getInstance();

    // IF DOESN'T EXIST
    if (prefs.getString(collection + "Map") == null || prefs.getString(collection + "Map") == "" || prefs.getString(collection + "Map") == {}) {
      Map<String, dynamic> _politicianMapLocal = Map();
      _politicianMapLocal.update(
          id,
              (update) => isLiked,
          ifAbsent: () => isLiked
      );

      waitBool = await prefs.setString(collection + "Map", json.encode(_politicianMapLocal));

      if(waitBool) {
        _collection();
      }

      print('WAIT BOOL IS: ' + waitBool.toString());
      print("POLITICIAN WAS SAVED IN NEW MAP!: " +_politicianMapLocal.containsKey(id).toString() + 'IN COLLECTION: $collection');
    }
    else { // IF EXISTS.
      final _politicianMap = await json.decode(
          prefs.getString(collection + "Map") ?? "") ?? {};
      // Add the new politician to the map and to the shared preference.
      _politicianMap.update(
          id,
              (update) => isLiked,
          ifAbsent: () => isLiked
      );

     waitBool = await prefs.setString(collection + "Map", json.encode(_politicianMap));

     // WHEN SHIT IS ACTUALLY SAVED, THEN GO FOR CHANGING!!
     if(waitBool) {
       _collection();
     }

     print('WAIT BOOL IS: ' + waitBool.toString());
      print("POLITICIAN WAS SAVED IN OLD MAP: " +_politicianMap.containsKey(id).toString() + 'IN COLLECTION: $collection');
    }

  }

  /// Used for populating (REWRITE THIS SO IT SAVES THE VENSTRE UNDER VESNTRELIST IN PREFS, SO I WILL KNOW WHO HAS WHAT AMOUNT OF POLITICIANS NAD CAN ITERATE.)
  void _populatePoliticians(String collection) async {
    // Get the shared preference.
    prefs = await SharedPreferences.getInstance();

    // IF DOESN'T EXIST
    if (prefs.getString(collection+"Holder") == null || prefs.getString(collection+"Holder") == "" || prefs.getString(collection+"Holder") == {}) {
      List<String> _localHolder = [];

      switch(collection){
        case "Venstre":
          List<String> venstreList = new List(3);
          venstreList[0] = '1LarsLøkke';
          venstreList[1] = '2AnniMatthiesen';
          venstreList[2] = '3KristianJensen';
          _localHolder.addAll(venstreList);
          break;
        case "SocialDemokraterne":
          List<String> sdList = new List(3);
          sdList[0] = '1MetteFrederiksen';
          sdList[1] = '2FrankJensen';
          sdList[2] = '3JanJuulChristensen';
          _localHolder.addAll(sdList);
          break;
      }

      await prefs.setString(collection+"Holder", json.encode(_localHolder));
      print('POLITICIANHOLDER IS NOW POPULATED BISH: ' + _localHolder.length.toString());
    }
    else {
      print('POLITICIANHOLDER HAS BEEN POPULATED BISH: ' + json
          .decode(prefs.getString(collection + "Holder"))
          .length
          .toString());
    }
  }

  /// THIS METHOD IS SUPPOSED TO ITERATE THROUGH THE MAP AND CHECK IT UP AGAINST (AFTER REFACOTRING THE TWO OTHER METHODS TO WORK WITH COLLECTIONS, ITERATE OVER A COLLECTION HERE).
  void _iteratePolitician(String collection) async {
    // Get the shared preference.
    prefs = await SharedPreferences.getInstance();
    int localCounter;

    if (prefs.getString(collection + "Map") == null || prefs.getString(collection + "Map") == "" || prefs.getString(collection + "Map") == {}) {
      Map<String, dynamic> _politicianMapLocal = Map();

      await prefs.setString(collection + "Map", json.encode(_politicianMapLocal));
      print("MAP DOES NOT EXIST FRIENDS.: " +_politicianMapLocal.length.toString());
      _iteratePolitician(collection);
      return;
    }
    else {
      final _politicianMap = await json.decode(
          prefs.getString(collection + "Map") ?? "") ?? {};

      final _politicianHolder = await json.decode(
          prefs.getString(collection + "Holder") ?? "") ?? {};

      List<String> _mapList = _politicianMap.keys.toList();



      for (int i = 0; i < _politicianMap.length; i++) {
        if (_politicianHolder[i] != _mapList[i]) {
          print("THIS POLITICIAN WAS FOUND GOOD: " + _politicianHolder[i]);
          newPoliticianString = _politicianHolder[i];
          return;
        }
        else {
          print("LOCAL COUNTER WAS INCREMENTED!");
          localCounter = i;
        }
        newPoliticianString = _politicianHolder[localCounter+1];
      }

      if(_mapList.length == 0) {
        newPoliticianString = _politicianHolder[0];
        print('U LANDED IN MAPLIST.LENGTH 0.');
      }
    }

    // CHANGE TO DUMMY WIDGET IF THE STRING IS EMPTY!
    if(newPoliticianString == '' || newPoliticianString == null || newPoliticianString == {}){
      print('ERROR!!! U HAVE LANDED IN DUMMY WIDGET!');
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (BuildContext _context) => EndScreenPage()));
      return;
    }
    // CHANGES THE ACTUAL ACTIVITY.
    print('ACTIVITY IS CHANGED WITH FOLLOWING ARGUMENTS: $collection and $newPoliticianString');
    Navigator.pushReplacement(context,
        MaterialPageRoute(builder: (BuildContext _context) => HomePage(collection, newPoliticianString)));
  }
}