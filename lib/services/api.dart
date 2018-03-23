import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fluri/fluri.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:marvel_heroes/models/character.dart';
import 'package:marvel_heroes/models/api/characters_response.dart';

Future<CharactersResponse> fetchCharacters(int page,int limit) async {
  String apiJson = await rootBundle.loadString('assets/api.json');
  Map<String,String> api = JSON.decode(apiJson);

  Fluri fluri = new Fluri("https://gateway.marvel.com/v1/public/characters");
  fluri.updateQuery(api);
  fluri.updateQuery({
    'offset': ((page -1)*limit).toString(),
    'limit': limit.toString(),
    'orderBy':'name'
      });

  final response = await http.get(fluri.toString());
  final json = JSON.decode(response.body);
  List<Character> characters =json["data"]["results"].map((row)=> new Character.fromJson(row)).toList();
  bool hasMore = json["data"]["total"] >page * limit;
  return new CharactersResponse(characters,hasMore);
}