import 'dart:convert';
import 'package:flutter/foundation.dart';

import 'package:perklight/utilities.dart';

class Character {
  
  final String name;
  final String description;
  final String imagePath;
  
  Character({this.name, this.description, this.imagePath});
  
  Character.fromJson(Map<String, dynamic> m):
    name = m['name'],
    description = m['description'],
    imagePath = m['imagePath'];

  
}