class Quote {
  final String id;
  final String dialog;
  final String movieId;
  final String characterId;
  final String? characterName;

  const Quote({
    required this.id,
    required this.dialog,
    required this.movieId,
    required this.characterId,
    this.characterName,
  });

  factory Quote.fromJson(Map<String, dynamic> json) {
    return Quote(
      id: json['_id'] as String? ?? json['id'] as String? ?? '',
      dialog: json['dialog'] as String? ?? '',
      movieId: json['movie'] as String? ?? '',
      characterId: json['character'] as String? ?? '',
      characterName: json['characterName'] as String?,
    );
  }

  Quote copyWith({String? characterName}) {
    return Quote(
      id: id,
      dialog: dialog,
      movieId: movieId,
      characterId: characterId,
      characterName: characterName ?? this.characterName,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'dialog': dialog,
      'movie': movieId,
      'character': characterId,
      'characterName': characterName,
    };
  }
}
