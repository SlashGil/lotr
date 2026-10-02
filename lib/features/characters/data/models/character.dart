import '../../../../core/utils/image_helper.dart';

class Character {
  final String id;
  final String name;
  final String race;
  final String gender;
  final String birth;
  final String death;
  final String realm;
  final String spouse;
  final String hair;
  final String wikiUrl;
  final String imageUrl;

  const Character({
    required this.id,
    required this.name,
    required this.race,
    required this.gender,
    required this.birth,
    required this.death,
    required this.realm,
    required this.spouse,
    required this.hair,
    required this.wikiUrl,
    required this.imageUrl,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    final name = json['name'] as String? ?? 'Unknown';
    final race = _cleanField(json['race']);
    final customImage = json['imageUrl'] as String?;

    return Character(
      id: json['_id'] as String? ?? json['id'] as String? ?? '',
      name: name,
      race: race,
      gender: _cleanField(json['gender']),
      birth: _cleanField(json['birth']),
      death: _cleanField(json['death']),
      realm: _cleanField(json['realm']),
      spouse: _cleanField(json['spouse']),
      hair: _cleanField(json['hair']),
      wikiUrl: json['wikiUrl'] as String? ?? '',
      imageUrl: customImage ?? ImageHelper.getCharacterImage(name, race),
    );
  }

  static String _cleanField(dynamic val) {
    if (val == null) return 'Unknown';
    final str = val.toString().trim();
    if (str.isEmpty || str == 'NaN') return 'Unknown';
    return str;
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'race': race,
      'gender': gender,
      'birth': birth,
      'death': death,
      'realm': realm,
      'spouse': spouse,
      'hair': hair,
      'wikiUrl': wikiUrl,
      'imageUrl': imageUrl,
    };
  }
}
