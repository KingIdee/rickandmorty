
class RickAndMortyModel{

  Info info;
  List<Result> result;

}

class Info {

  int count;
  int pages;
  String next;
  String prev;

}

class Location {

  String name;
  String url;

}


class Origin {

  String name;
  String url;

}

class Result {

  int id;
  String name;
  String status;
  String species;
  String type;
  String gender;
  Origin origin;
  Location location;
  String image;
  List<String> episode;
  String url;
  String created;

}