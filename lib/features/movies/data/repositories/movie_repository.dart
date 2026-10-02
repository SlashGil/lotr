import '../../../../core/network/dio_client.dart';
import '../../../quotes/data/models/quote.dart';
import '../models/movie.dart';

class MovieRepository {
  final DioClient _dioClient;

  MovieRepository({DioClient? dioClient})
      : _dioClient = dioClient ?? DioClient();

  Future<List<Movie>> getMovies({String? nameFilter}) async {
    try {
      final response = await _dioClient.dio.get('/movie');
      if (response.statusCode == 200 && response.data != null) {
        final docs = response.data['docs'] as List<dynamic>?;
        if (docs != null && docs.isNotEmpty) {
          var movies = docs
              .map((json) => Movie.fromJson(json as Map<String, dynamic>))
              .toList();
          
          if (nameFilter != null && nameFilter.isNotEmpty) {
            final query = nameFilter.toLowerCase();
            movies = movies
                .where((m) => m.name.toLowerCase().contains(query))
                .toList();
          }

          if (movies.isNotEmpty) {
            return movies;
          }
        }
      }
    } catch (_) {}

    return _getMockMovies(nameFilter);
  }

  Future<List<Quote>> getMovieQuotes(String movieId) async {
    try {
      final response = await _dioClient.dio.get('/movie/$movieId/quote');
      if (response.statusCode == 200 && response.data != null) {
        final docs = response.data['docs'] as List<dynamic>?;
        if (docs != null && docs.isNotEmpty) {
          return docs
              .map((json) => Quote.fromJson(json as Map<String, dynamic>))
              .where((q) => q.dialog.trim().isNotEmpty)
              .take(15)
              .toList();
        }
      }
    } catch (_) {}

    return _getMockMovieQuotes(movieId);
  }

  List<Movie> _getMockMovies(String? filter) {
    const mockMovies = [
      Movie(
        id: '5cd9539514e03700156b162c',
        name: 'The Fellowship of the Ring',
        runtimeInMinutes: 178,
        budgetInMillions: 93,
        boxOfficeRevenueInMillions: 897.7,
        academyAwardNominations: 13,
        academyAwardWins: 4,
        imageUrl: 'https://images.unsplash.com/photo-1464822759023-fed622ff2c3b?q=80&w=600&auto=format&fit=crop',
      ),
      Movie(
        id: '5cd9539514e03700156b162d',
        name: 'The Two Towers',
        runtimeInMinutes: 179,
        budgetInMillions: 94,
        boxOfficeRevenueInMillions: 926,
        academyAwardNominations: 6,
        academyAwardWins: 2,
        imageUrl: 'https://images.unsplash.com/photo-1519681393784-d120267933ba?q=80&w=600&auto=format&fit=crop',
      ),
      Movie(
        id: '5cd9539514e03700156b162e',
        name: 'The Return of the King',
        runtimeInMinutes: 201,
        budgetInMillions: 94,
        boxOfficeRevenueInMillions: 1146,
        academyAwardNominations: 11,
        academyAwardWins: 11,
        imageUrl: 'https://images.unsplash.com/photo-1518709268805-4e9042af9f23?q=80&w=600&auto=format&fit=crop',
      ),
      Movie(
        id: '5cd9539514e03700156b1628',
        name: 'The Hobbit: An Unexpected Journey',
        runtimeInMinutes: 169,
        budgetInMillions: 200,
        boxOfficeRevenueInMillions: 1017,
        academyAwardNominations: 3,
        academyAwardWins: 0,
        imageUrl: 'https://images.unsplash.com/photo-1506744038136-46273834b3fb?q=80&w=600&auto=format&fit=crop',
      ),
      Movie(
        id: '5cd9539514e03700156b1629',
        name: 'The Hobbit: The Desolation of Smaug',
        runtimeInMinutes: 161,
        budgetInMillions: 217,
        boxOfficeRevenueInMillions: 958.4,
        academyAwardNominations: 3,
        academyAwardWins: 0,
        imageUrl: 'https://images.unsplash.com/photo-1509248961158-e54f6934749c?q=80&w=600&auto=format&fit=crop',
      ),
      Movie(
        id: '5cd9539514e03700156b162a',
        name: 'The Hobbit: The Battle of the Five Armies',
        runtimeInMinutes: 144,
        budgetInMillions: 250,
        boxOfficeRevenueInMillions: 956,
        academyAwardNominations: 1,
        academyAwardWins: 0,
        imageUrl: 'https://images.unsplash.com/photo-1514539079130-25950c84af65?q=80&w=600&auto=format&fit=crop',
      ),
    ];

    if (filter != null && filter.isNotEmpty) {
      final query = filter.toLowerCase();
      return mockMovies
          .where((m) => m.name.toLowerCase().contains(query))
          .toList();
    }

    return mockMovies;
  }

  List<Quote> _getMockMovieQuotes(String movieId) {
    return [
      Quote(
        id: 'mq1',
        dialog: 'One Ring to rule them all, One Ring to find them, One Ring to bring them all and in the darkness bind them.',
        movieId: movieId,
        characterId: 'gandalf_id',
        characterName: 'Gandalf',
      ),
      Quote(
        id: 'mq2',
        dialog: 'Even the smallest person can change the course of the future.',
        movieId: movieId,
        characterId: 'galadriel_id',
        characterName: 'Galadriel',
      ),
      Quote(
        id: 'mq3',
        dialog: 'A day may come when the courage of men fails... but it is not this day!',
        movieId: movieId,
        characterId: 'aragorn_id',
        characterName: 'Aragorn',
      ),
    ];
  }
}
