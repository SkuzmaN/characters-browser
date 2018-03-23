import 'package:marvel_heroes/models/character.dart';

class CharactersResponse {
  CharactersResponse(this.data, this.hasMore);

  final bool hasMore;
  final List<Character> data;
}