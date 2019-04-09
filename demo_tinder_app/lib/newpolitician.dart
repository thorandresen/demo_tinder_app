import 'dart:io';
import 'dart:math';

import 'package:demo_tinder_app/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';

class NewPolitician{
List<String> _collectionList = new List(2);
List<String> _backgroundList = new List(2);

// Json files.
File jsonFile;
Directory dir;
String fileName = "politicalData.json";
bool fileExists = false;
Map<String, String> fileContent;
int i = 0;

    NewPolitician(){
      // COLLECTION LIST
      _collectionList[0] = "Venstre";
      _collectionList[1] = "SocialDemokraterne";

      // BACKGROUND LIST
      _backgroundList[0] = "graphics/Venstre_background.png";
      _backgroundList[1] = "graphics/SD_background.png";

      // JSON
        getApplicationDocumentsDirectory().then((Directory directory) {
          dir = directory;
          jsonFile = new File(dir.path + "/" + fileName);
          jsonFile.createSync();
          fileExists = jsonFile.existsSync();

          if (fileExists) {
            print('We get here? 2');
            //writeToFile('Test', 'works');
            //fileContent = jsonDecode(jsonFile.readAsStringSync());
            print(fileContent.toString());
          }
        });



    }

    /// Method for chosing what collection to look into.
    String collection(){
      Random random = new Random();

      return _collectionList.elementAt(random.nextInt(_collectionList.length));
    }

    /// Method for chosing what collection to look into.
    String background(int bg){
      return _backgroundList.elementAt(bg);
    }

  /// The method for calculating what to do with liked politician
  void performPolitician(bool isLiked, BuildContext context, String id) {
      print("ID: " + id + " is liked : " + isLiked.toString());
      Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (BuildContext _context) => HomePage()));
  }



  void writeToFile(String key, String value) {
      print('Writing to JSON file');
      Map<String, String> content = {key: value};

      if (fileExists){
        print('File exists');
        Map<String, String> jsonFileContent = json.decode(jsonFile.readAsStringSync());
        jsonFileContent.addAll(content);
        jsonFile.writeAsString(json.encode(jsonFileContent));
      } else {
        print('File does not exist');
      }
  }

  String readValueFromFile(String key) {
    print('Reading value');
    Map<String, String> jsonFileContent = json.decode(jsonFile.readAsStringSync());
    return jsonFileContent.keys.firstWhere((k) => jsonFileContent[k] == key, orElse: () => null);
  }
}