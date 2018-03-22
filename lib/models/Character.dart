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

  factory Character.fromJson(Map<String, dynamic> json) {
    return new Character(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      thumbnail: json['thumbnail'],
      comics: json['comics'],
    );
  }
}