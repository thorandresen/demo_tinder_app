import 'dart:math';

import 'package:demo_tinder_app/homepage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:path/path.dart';

class NewPolitician{
List<String> _collectionList = new List(2);

    NewPolitician(){
      _collectionList[0] = "Venstre";
      _collectionList[1] = "SocialDemokraterne";
    }

    /// Method for chosing what collection to look into.
    String collection(){
      Random random = new Random();

      return _collectionList.elementAt(random.nextInt(_collectionList.length));
    }

  /// The method for changing politician after like/dislike.
  void changePolitician(bool isLiked, BuildContext context) {
  Navigator.pushReplacement(context,
      MaterialPageRoute(builder: (BuildContext _context) => HomePage()));
  }


}