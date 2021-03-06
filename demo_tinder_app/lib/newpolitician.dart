import 'dart:math';
import 'package:demo_tinder_app/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'endscreen.dart';

class NewPolitician {
  List<String> _collectionList = new List(7);
  List<String> _backgroundList = new List(7);
  List<String> _logoList = new List(7);
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
    _collectionList[2] = "RadikaleVenstre";
    _collectionList[3] = "Alternativet";
    _collectionList[4] = "SF";
    _collectionList[5] = "Enhedslisten";
    _collectionList[6] = "LiberalAlliance";

    // BACKGROUND LIST
    _backgroundList[0] = "graphics/VenstreBackground_NY.png";
    _backgroundList[1] = "graphics/SDbackground_NY.png";
    _backgroundList[2] = "graphics/RadikalBackground_NY.png";
    _backgroundList[3] = "graphics/AlternativetBackground_NY.png";
    _backgroundList[4] = "graphics/SFbackground_NY.png";
    _backgroundList[5] = "graphics/EnhedslistenBackground_NY.png";
    _backgroundList[6] = "graphics/LABackground_NY.png";

    // LOGO LIST
    _logoList[0] = "graphics/venstrelogo.png";
    _logoList[1] = "graphics/sdlogo.png";
    _logoList[2] = "graphics/radikallogo.png";
    _logoList[3] = "graphics/alternativetlogo.png";
    _logoList[4] = "graphics/sflogo.png";
    _logoList[5] = "graphics/enhedslistenlogo.png";
    _logoList[6] = "graphics/lalogo.png";

    // Populate politicians
      _populatePoliticians(_collectionList[0]);
      _populatePoliticians(_collectionList[1]);
      _populatePoliticians(_collectionList[2]);
      _populatePoliticians(_collectionList[3]);
      _populatePoliticians(_collectionList[4]);
      _populatePoliticians(_collectionList[5]);
  }

  /// Method for chosing what collection to look into. This method takes finds a valid collection where there are still not seen politicians.
  void collectionGenerator() async {
    prefs = await SharedPreferences.getInstance();
    List<String> _goodCollections = [];

    for(int i = 0; i < _collectionList.length; i++) {
      if (prefs.getString(_collectionList[i] + "Map") == null || prefs.getString(_collectionList[i] + "Map") == "" || prefs.getString(_collectionList[i] + "Map") == {}) {
        _goodCollections.add(_collectionList[i]);
        print('COLLECTION: ' + _collectionList[i] + ' WAS GOOD AND EMPTY!');
      }
      else if(prefs.getString(_collectionList[i] + "Holder") == null || prefs.getString(_collectionList[i] + "Holder") == "" || prefs.getString(_collectionList[i] + "Holder") == {}){
        _populatePoliticians(_collectionList[i]);
        collectionGenerator();
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
      print('LENTGH OF GOOD COLLECTION LIST: ' + _goodCollections.length.toString());
    }

    if(_goodCollections.length == 1){
      newPoliticianCollection = _goodCollections[0];
    }else if(_goodCollections.length > 1) {
      Random random = new Random();
      newPoliticianCollection = _goodCollections[random.nextInt(_goodCollections.length)];
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

  String logo(int logo){
    return _logoList.elementAt(logo);
  }

  /// The method for calculating what to do with liked politician
  void performPolitician(bool isLiked, BuildContext context, String id, String collection) {
    print("ID: " + id + " is liked : " + isLiked.toString());
    this.context = context;

    _savePolitician(id, isLiked, collection);


    // Actually iterating over politicians and finding one.

    /// HERE WE HAVE TO CHANGE BACK TO HOMEPAGE WITH COLLECTION AND NUMBER OF POLITICIAN.

  }

  /// This method is for saving the politician that are just seen and either liked or disliked.
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
        collectionGenerator();
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
       collectionGenerator();
     }

     print('WAIT BOOL IS: ' + waitBool.toString());
      print("POLITICIAN WAS SAVED IN OLD MAP: " +_politicianMap.containsKey(id).toString() + 'IN COLLECTION: $collection');
    }

  }

  /// Used for populating the different "Holders" which holds all the politicians in different parties, so that it can be used to be compared with already seen politicians.
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
        case "RadikaleVenstre":
          List<String> radikalList = new List(11);
          radikalList[0] = '1KarenMelchior';
          radikalList[1] = '2TomBrøcherJakobsen';
          radikalList[2] = '3SørenBoPedersen';
          radikalList[3] = '4MichaelSkaaningJohansen';
          radikalList[4] = '5AnneSophieCallesen';
          radikalList[5] = '6SusanKronborg';
          radikalList[6] = '7HenrikVintherOlesen';
          radikalList[7] = '8KatrineRobsøe';
          radikalList[8] = '9MortenØstergaard';
          radikalList[9] = '10BassamEl-Daoud';
          radikalList[10] = '11MortenKjærSørensen';
          _localHolder.addAll(radikalList);
          break;
        case "Alternativet":
          List<String> alternativetList = new List(1);
          alternativetList[0] = '1TorstenGejl';
          _localHolder.addAll(alternativetList);
          break;
        case "SF":
          List<String> SFList = new List(1);
          SFList[0] = '1KirstenNormannAndersen';
          _localHolder.addAll(SFList);
          break;
        case "Enhedslisten":
          List<String> EnhedslistenList = new List(1);
          EnhedslistenList[0] = '1AnneHegelund';
          _localHolder.addAll(EnhedslistenList);
          break;
        case "LiberalAlliance":
          List<String> LAList = new List(1);
          LAList[0] = '1OleBirkOlesen';
          _localHolder.addAll(LAList);
          break;
      }

      await prefs.setString(collection+"Holder", json.encode(_localHolder));
      print('POLITICIANHOLDER IS NOW POPULATED BISH ($collection): ' + _localHolder.length.toString());
    }
    else {
      print('POLITICIANHOLDER HAS BEEN POPULATED BISH ($collection): ' + json
          .decode(prefs.getString(collection + "Holder"))
          .length
          .toString());
    }
  }

  /// Iterates over the valid politicians, and choses one to show the user, which the user has not seen before.
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
    else if (prefs.getString(collection+"Holder") == null ||
    prefs.getString(collection+"Holder") == "" ||
    prefs.getString(collection+"Holder") == {}) {

      /*List<String> _localHolder = [];
      _localHolder.add('1gwa');

      await prefs.setString(collection+"Holder", json.encode(_localHolder));*/

      _populatePoliticians(collection);
      _iteratePolitician(collection);
      print('HOLDER WASNT POPULATED CORRECT ($collection)');
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
        MaterialPageRoute(builder: (BuildContext _context) => HomePage(collection, newPoliticianString, true)));
  }

  List<String> get collectionList => _collectionList;
  List<String> get logoList => _logoList;
}