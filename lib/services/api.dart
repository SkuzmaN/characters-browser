import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluri/fluri.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:marvel_heroes/models/Character.dart';

Future<List<Character>> fetchCharacters() async {
  String apiJson = await rootBundle.loadString('assets/api.json');
  Map<String,String> api = JSON.decode(apiJson);

  Fluri fluri = new Fluri("https://gateway.marvel.com/v1/public/characters");
  fluri.updateQuery(api);

  final response = await http.get(fluri.toString());
  final json = JSON.decode(response.body);
  return json["data"]["results"].map((row)=> new Character.fromJson(row)).toList();
//  List charactersJSON = JSON.decode(json);
//  return charactersJSON.map((row)=> new Character.fromJson(row)).toList();
}