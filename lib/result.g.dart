// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'result.dart';

// **************************************************************************
// Generator: JsonSerializableGenerator
// **************************************************************************

Result _$ResultFromJson(Map<String, dynamic> json) => new Result(
    json['id'] as int,
    json['name'] as String,
    json['status'] as String,
    json['species'] as String,
    json['type'] as String,
    json['gender'] as String,
    json['image'] as String,
    (json['episode'] as List)?.map((e) => e as String)?.toList(),
    json['url'] as String,
    json['created'] as String);

abstract class _$ResultSerializerMixin {
  int get id;
  String get name;
  String get status;
  String get species;
  String get type;
  String get gender;
  String get image;
  List<String> get episode;
  String get url;
  String get created;
  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': id,
        'name': name,
        'status': status,
        'species': species,
        'type': type,
        'gender': gender,
        'image': image,
        'episode': episode,
        'url': url,
        'created': created
      };
}
