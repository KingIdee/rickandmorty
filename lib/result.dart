import 'package:json_annotation/json_annotation.dart';

/// This allows our `User` class to access private members in
/// the generated file. The value for this is *.g.dart, where
/// the star denotes the source file name.
part 'result.g.dart';

@JsonSerializable()
class Result extends Object with _$ResultSerializerMixin {

  Result(this.id,
      this.name,
      this.status,
      this.species,
      this.type,
      this.gender,/*
      this.origin,
      this.location,*/
      this.image,
      this.episode,
      this.url,
      this.created,);

  int id;
  String name;
  String status;
  String species;
  String type;
  String gender;
  //Origin origin;
  //Location location;
  String image;
  List<String> episode;
  String url;
  String created;


  factory Result.fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

}