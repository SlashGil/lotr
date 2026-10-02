import '../../../../core/network/dio_client.dart';
import '../models/quote.dart';

class QuoteRepository {
  final DioClient _dioClient;

  QuoteRepository({DioClient? dioClient})
      : _dioClient = dioClient ?? DioClient();

  Future<List<Quote>> getQuotes({String? textFilter}) async {
    try {
      final response = await _dioClient.dio.get('/quote', queryParameters: {
        'limit': 50,
      });
      if (response.statusCode == 200 && response.data != null) {
        final docs = response.data['docs'] as List<dynamic>?;
        if (docs != null && docs.isNotEmpty) {
          var quotes = docs
              .map((json) => Quote.fromJson(json as Map<String, dynamic>))
              .where((q) => q.dialog.trim().isNotEmpty)
              .toList();

          if (textFilter != null && textFilter.isNotEmpty) {
            final query = textFilter.toLowerCase();
            quotes = quotes
                .where((q) => q.dialog.toLowerCase().contains(query))
                .toList();
          }

          if (quotes.isNotEmpty) {
            return quotes;
          }
        }
      }
    } catch (_) {}

    return _getMockQuotes(textFilter);
  }

  List<Quote> _getMockQuotes(String? filter) {
    const mockQuotes = [
      Quote(
        id: 'q1',
        dialog: 'A day may come when the courage of men fails... but it is not this day!',
        movieId: 'm1',
        characterId: 'aragorn_id',
        characterName: 'Aragorn',
      ),
      Quote(
        id: 'q2',
        dialog: 'A wizard is never late, Frodo Baggins. Nor is he early. He arrives precisely when he means to.',
        movieId: 'm1',
        characterId: 'gandalf_id',
        characterName: 'Gandalf',
      ),
      Quote(
        id: 'q3',
        dialog: 'All we have to decide is what to do with the time that is given us.',
        movieId: 'm1',
        characterId: 'gandalf_id',
        characterName: 'Gandalf',
      ),
      Quote(
        id: 'q4',
        dialog: 'One does not simply walk into Mordor.',
        movieId: 'm1',
        characterId: 'boromir_id',
        characterName: 'Boromir',
      ),
      Quote(
        id: 'q5',
        dialog: 'Even the smallest person can change the course of the future.',
        movieId: 'm1',
        characterId: 'galadriel_id',
        characterName: 'Galadriel',
      ),
      Quote(
        id: 'q6',
        dialog: 'There\'s some good in this world, Mr. Frodo, and it\'s worth fighting for.',
        movieId: 'm1',
        characterId: 'sam_id',
        characterName: 'Samwise Gamgee',
      ),
      Quote(
        id: 'q7',
        dialog: 'I will take the Ring, though I do not know the way.',
        movieId: 'm1',
        characterId: 'frodo_id',
        characterName: 'Frodo Baggins',
      ),
      Quote(
        id: 'q8',
        dialog: 'My precious!',
        movieId: 'm2',
        characterId: 'gollum_id',
        characterName: 'Gollum',
      ),
    ];

    if (filter != null && filter.isNotEmpty) {
      final query = filter.toLowerCase();
      return mockQuotes
          .where((q) =>
              q.dialog.toLowerCase().contains(query) ||
              (q.characterName != null && q.characterName!.toLowerCase().contains(query)))
          .toList();
    }

    return mockQuotes;
  }
}
