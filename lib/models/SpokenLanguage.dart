import 'dart:convert';

class SpokenLanguage {
  final String? iso6391;
  final String? name;

  SpokenLanguage({
    this.iso6391,
    this.name,
  });

  factory SpokenLanguage.fromJson(String str) =>
      SpokenLanguage.fromMap(json.decode(str));

  factory SpokenLanguage.fromMap(Map<String, dynamic> json) =>
      SpokenLanguage(
        iso6391: json["iso_639_1"],
        name: json["name"],
      );
}