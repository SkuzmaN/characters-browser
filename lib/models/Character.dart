class Character {
  Character({
    this.id,
    this.name,
    this.description,
    this.thumbnail,
    this.comics,
  });

  final int id;
  final String name;
  final String description;
  final String thumbnail;
  final List<String> comics;
}