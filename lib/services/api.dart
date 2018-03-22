import 'dart:async';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:marvel_heroes/models/Character.dart';



Future<List<Character>> fetchCharacters() async {
  String json = await rootBundle.loadString('assets/data.json');
  List charactersJSON = JSON.decode(json);
  final elo =charactersJSON.map((row)=> new Character.fromJson(row)).toList();
  return elo;
}