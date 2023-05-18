// To parse this JSON data, do
//
//     final categorymodels = categorymodelsFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

Categorymodels categorymodelsFromJson(String str) => Categorymodels.fromJson(json.decode(str));

class Categorymodels {
  List<Category> categories;

  Categorymodels({
    required this.categories,
  });

  factory Categorymodels.fromJson(Map<String, dynamic> json) => Categorymodels(
    categories: List<Category>.from(json["categories"].map((x) => Category.fromJson(x))),
  );

}

class Category {
  String name;
  List<String> subcategory;

  Category({
    required this.name,
    required this.subcategory,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    name: json["name"],
    subcategory: List<String>.from(json["subcategory"].map((x) => x)),
  );

}
