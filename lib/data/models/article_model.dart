import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

class ArticleModel {
  ArticleModel({
    required this.title,
    required this.imageAssetPath,
    required this.date,
    required this.location,
    required this.description,
  });

  String title;
  String imageAssetPath;
  String date;
  String location;
  String description;

  static Future<String> getJson() {
    return rootBundle.loadString('assets/json/data_Article.json');
  }

  factory ArticleModel.fromRawJson(String str) =>
      ArticleModel.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory ArticleModel.fromJson(Map<String, dynamic> json) => ArticleModel(
        title: json["title"],
        imageAssetPath: json["imageAssetPath"],
        date: json["date"],
        location: json["location"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "title": title,
        "imageAssetPath": imageAssetPath,
        "date": date,
        "location": location,
        "description": description,
      };
}
