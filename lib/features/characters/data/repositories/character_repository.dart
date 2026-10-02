import '../../../../core/network/dio_client.dart';
import '../../../quotes/data/models/quote.dart';
import '../models/character.dart';

class CharacterRepository {
  final DioClient _dioClient;

  CharacterRepository({DioClient? dioClient})
      : _dioClient = dioClient ?? DioClient();

  Future<List<Character>> getCharacters({String? nameFilter}) async {
    try {
      final response = await _dioClient.dio.get(
        '/character',
        queryParameters: nameFilter != null && nameFilter.isNotEmpty
            ? {'name': '/$nameFilter/i'}
            : null,
      );

      if (response.statusCode == 200 && response.data != null) {
        final docs = response.data['docs'] as List<dynamic>?;
        if (docs != null && docs.isNotEmpty) {
          final characters = docs
              .map((json) => Character.fromJson(json as Map<String, dynamic>))
              .where((c) => c.name.isNotEmpty && c.name != 'Unknown')
              .toList();

          if (characters.isNotEmpty) {
            return characters;
          }
        }
      }
    } catch (_) {}

    return _getMockCharacters(nameFilter);
  }

  Future<Character?> getCharacterById(String id) async {
    try {
      final response = await _dioClient.dio.get('/character/$id');
      if (response.statusCode == 200 && response.data != null) {
        final docs = response.data['docs'] as List<dynamic>?;
        if (docs != null && docs.isNotEmpty) {
          return Character.fromJson(docs.first as Map<String, dynamic>);
        }
      }
    } catch (_) {}

    final mockList = _getMockCharacters(null);
    try {
      return mockList.firstWhere((c) => c.id == id);
    } catch (_) {
      return mockList.first;
    }
  }

  Future<List<Quote>> getCharacterQuotes(String characterId) async {
    try {
      final response = await _dioClient.dio.get('/character/$characterId/quote');
      if (response.statusCode == 200 && response.data != null) {
        final docs = response.data['docs'] as List<dynamic>?;
        if (docs != null && docs.isNotEmpty) {
          return docs
              .map((json) => Quote.fromJson(json as Map<String, dynamic>))
              .where((q) => q.dialog.trim().isNotEmpty)
              .toList();
        }
      }
    } catch (_) {}

    return _getMockQuotesForCharacter(characterId);
  }

  List<Quote> _getMockQuotesForCharacter(String characterId) {
    const Map<String, List<String>> mockQuotesMap = {
      'aragorn_id': [
        'A day may come when the courage of men fails... but it is not this day!',
        'I would have followed you, my brother... my captain... my king.',
        'If by my life or death I can protect you, I will. You have my sword.',
      ],
      'gandalf_id': [
        'A wizard is never late, Frodo Baggins. Nor is he early. He arrives precisely when he means to.',
        'All we have to decide is what to do with the time that is given us.',
        'You shall not pass!',
        'Fly, you fools!',
      ],
      'frodo_id': [
        'I will take the Ring, though I do not know the way.',
        'I wish the Ring had never come to me. I wish none of this had happened.',
        'There is no real going back.',
      ],
      'legolas_id': [
        'They\'re taking the Hobbits to Isengard!',
        'And you have my bow.',
        'A red sun rises, blood has been spilled this night.',
      ],
      'gimli_id': [
        'And my axe!',
        'Certainty of death. Small chance of success. What are we waiting for?',
        'Never thought I\'d die fighting side by side with an Elf.',
      ],
      'galadriel_id': [
        'Even the smallest person can change the course of the future.',
        'In place of a Dark Lord, you would have a queen!',
        'May it be a light to you in dark places, when all other lights go out.',
      ],
      'sauron_id': [
        'There is no life in the void. Only death.',
        'You cannot hide. I see you.',
      ],
      'sam_id': [
        'There\'s some good in this world, Mr. Frodo, and it\'s worth fighting for.',
        'I can\'t carry it for you, but I can carry you!',
      ],
      'boromir_id': [
        'One does not simply walk into Mordor.',
        'They have a cave troll.',
      ],
    };

    final list = mockQuotesMap[characterId] ?? [
      'I am bound by my oath in Middle-Earth.',
      'My destiny lies ahead in the shadows of the One Ring.',
    ];

    return list
        .map((dialog) => Quote(
              id: 'quote_${dialog.hashCode}',
              dialog: dialog,
              movieId: 'lotr_movie',
              characterId: characterId,
            ))
        .toList();
  }

  List<Character> _getMockCharacters(String? filter) {
    const mockData = [
      Character(
        id: 'aragorn_id',
        name: 'Aragorn II Elessar',
        race: 'Human',
        gender: 'Male',
        birth: 'TA 2931',
        death: 'FO 120',
        realm: 'Reunited Kingdom',
        spouse: 'Arwen Undómiel',
        hair: 'Dark',
        wikiUrl: 'https://lotr.fandom.com/wiki/Aragorn_II',
        imageUrl: 'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?q=80&w=600&auto=format&fit=crop',
      ),
      Character(
        id: 'gandalf_id',
        name: 'Gandalf (Mithrandir)',
        race: 'Maiar',
        gender: 'Male',
        birth: 'Before the Shaping of Arda',
        death: 'Immortal (Returned as White)',
        realm: 'Valinor / Middle-earth',
        spouse: 'None',
        hair: 'Grey / White',
        wikiUrl: 'https://lotr.fandom.com/wiki/Gandalf',
        imageUrl: 'https://images.unsplash.com/photo-1514539079130-25950c84af65?q=80&w=600&auto=format&fit=crop',
      ),
      Character(
        id: 'frodo_id',
        name: 'Frodo Baggins',
        race: 'Hobbit',
        gender: 'Male',
        birth: 'TA 2968',
        death: 'Unknown (Sailed West)',
        realm: 'The Shire',
        spouse: 'None',
        hair: 'Dark',
        wikiUrl: 'https://lotr.fandom.com/wiki/Frodo_Baggins',
        imageUrl: 'https://images.unsplash.com/photo-1543610892-0b1f7e6d8ac1?q=80&w=600&auto=format&fit=crop',
      ),
      Character(
        id: 'legolas_id',
        name: 'Legolas Greenleaf',
        race: 'Elf',
        gender: 'Male',
        birth: 'Third Age',
        death: 'Immortal',
        realm: 'Woodland Realm',
        spouse: 'None',
        hair: 'Blond / Dark',
        wikiUrl: 'https://lotr.fandom.com/wiki/Legolas',
        imageUrl: 'https://images.unsplash.com/photo-1579783902614-a3fb3927b675?q=80&w=600&auto=format&fit=crop',
      ),
      Character(
        id: 'gimli_id',
        name: 'Gimli, Son of Glóin',
        race: 'Dwarf',
        gender: 'Male',
        birth: 'TA 2879',
        death: 'FO 120 (Sailed West)',
        realm: 'Erebor / Glittering Caves',
        spouse: 'None',
        hair: 'Red / Auburn',
        wikiUrl: 'https://lotr.fandom.com/wiki/Gimli',
        imageUrl: 'https://images.unsplash.com/photo-1509198397868-475647b2a1e5?q=80&w=600&auto=format&fit=crop',
      ),
      Character(
        id: 'galadriel_id',
        name: 'Galadriel',
        race: 'Elf',
        gender: 'Female',
        birth: 'YT 1362',
        death: 'Immortal',
        realm: 'Lothlórien',
        spouse: 'Celeborn',
        hair: 'Golden-Silver',
        wikiUrl: 'https://lotr.fandom.com/wiki/Galadriel',
        imageUrl: 'https://images.unsplash.com/photo-1534447677768-be436bb09401?q=80&w=600&auto=format&fit=crop',
      ),
      Character(
        id: 'sauron_id',
        name: 'Sauron (The Dark Lord)',
        race: 'Maiar',
        gender: 'Male',
        birth: 'Before Arda',
        death: 'Diminished TA 3019',
        realm: 'Mordor',
        spouse: 'None',
        hair: 'Unknown',
        wikiUrl: 'https://lotr.fandom.com/wiki/Sauron',
        imageUrl: 'https://images.unsplash.com/photo-1509248961158-e54f6934749c?q=80&w=600&auto=format&fit=crop',
      ),
      Character(
        id: 'arwen_id',
        name: 'Arwen Undómiel',
        race: 'Elf / Half-Elven',
        gender: 'Female',
        birth: 'TA 241',
        death: 'FO 121',
        realm: 'Rivendell / Reunited Kingdom',
        spouse: 'Aragorn II Elessar',
        hair: 'Dark',
        wikiUrl: 'https://lotr.fandom.com/wiki/Arwen',
        imageUrl: 'https://images.unsplash.com/photo-1534528741775-53994a69daeb?q=80&w=600&auto=format&fit=crop',
      ),
      Character(
        id: 'sam_id',
        name: 'Samwise Gamgee',
        race: 'Hobbit',
        gender: 'Male',
        birth: 'TA 2980',
        death: 'Unknown (Sailed West)',
        realm: 'The Shire',
        spouse: 'Rosie Cotton',
        hair: 'Brown',
        wikiUrl: 'https://lotr.fandom.com/wiki/Samwise_Gamgee',
        imageUrl: 'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?q=80&w=600&auto=format&fit=crop',
      ),
      Character(
        id: 'boromir_id',
        name: 'Boromir',
        race: 'Human',
        gender: 'Male',
        birth: 'TA 2978',
        death: 'TA 3019',
        realm: 'Gondor',
        spouse: 'None',
        hair: 'Dark',
        wikiUrl: 'https://lotr.fandom.com/wiki/Boromir',
        imageUrl: 'https://images.unsplash.com/photo-1500648767791-00dcc994a43e?q=80&w=600&auto=format&fit=crop',
      ),
    ];

    if (filter != null && filter.isNotEmpty) {
      final query = filter.toLowerCase();
      return mockData
          .where((c) =>
              c.name.toLowerCase().contains(query) ||
              c.race.toLowerCase().contains(query) ||
              c.realm.toLowerCase().contains(query))
          .toList();
    }

    return mockData;
  }
}
