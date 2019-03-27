import 'dart:math';

class NewPolitician{
List<String> _collectionList = new List(2);

    NewPolitician(){
      _collectionList[0] = "Venstre";
      _collectionList[1] = "SocialDemokraterne";
    }

    String collection(){
      Random random = new Random();

      return _collectionList.elementAt(random.nextInt(_collectionList.length));
    }
}