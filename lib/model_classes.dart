import 'package:json_annotation/json_annotation.dart';
import 'package:rick_and_morty/result.dart';

/// This allows our `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.

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


