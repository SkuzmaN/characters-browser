import 'package:marvel_heroes/features/characters/models/character.dart';

class FetchAllResponse {
  FetchAllResponse(this.data, this.hasMore);

  final bool hasMore;
  final List<Character> data;
}