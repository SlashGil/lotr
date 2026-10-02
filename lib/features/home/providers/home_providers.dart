import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/network/dio_client.dart';
import '../../books/data/models/book.dart';
import '../../books/data/repositories/book_repository.dart';
import '../../characters/data/models/character.dart';
import '../../characters/data/repositories/character_repository.dart';
import '../../movies/data/models/movie.dart';
import '../../movies/data/repositories/movie_repository.dart';
import '../../quotes/data/models/quote.dart';
import '../../quotes/data/repositories/quote_repository.dart';

enum CategoryTab { characters, movies, books, quotes }

final dioClientProvider = Provider<DioClient>((ref) => DioClient());

// Repositories
final characterRepositoryProvider = Provider<CharacterRepository>((ref) {
  return CharacterRepository(dioClient: ref.watch(dioClientProvider));
});

final movieRepositoryProvider = Provider<MovieRepository>((ref) {
  return MovieRepository(dioClient: ref.watch(dioClientProvider));
});

final bookRepositoryProvider = Provider<BookRepository>((ref) {
  return BookRepository(dioClient: ref.watch(dioClientProvider));
});

final quoteRepositoryProvider = Provider<QuoteRepository>((ref) {
  return QuoteRepository(dioClient: ref.watch(dioClientProvider));
});

// Category & Search State
final selectedCategoryProvider =
    StateProvider<CategoryTab>((ref) => CategoryTab.characters);

final searchQueryProvider = StateProvider<String>((ref) => '');
final characterSearchQueryProvider = searchQueryProvider;

// Data Providers
final characterListProvider = FutureProvider<List<Character>>((ref) async {
  final repo = ref.watch(characterRepositoryProvider);
  final query = ref.watch(searchQueryProvider);
  return repo.getCharacters(nameFilter: query);
});

final characterDetailProvider =
    FutureProvider.family<Character?, String>((ref, id) async {
  final repo = ref.watch(characterRepositoryProvider);
  return repo.getCharacterById(id);
});

final characterQuotesProvider =
    FutureProvider.family<List<Quote>, String>((ref, characterId) async {
  final repo = ref.watch(characterRepositoryProvider);
  return repo.getCharacterQuotes(characterId);
});

final movieListProvider = FutureProvider<List<Movie>>((ref) async {
  final repo = ref.watch(movieRepositoryProvider);
  final query = ref.watch(searchQueryProvider);
  return repo.getMovies(nameFilter: query);
});

final movieQuotesProvider =
    FutureProvider.family<List<Quote>, String>((ref, movieId) async {
  final repo = ref.watch(movieRepositoryProvider);
  return repo.getMovieQuotes(movieId);
});

final bookListProvider = FutureProvider<List<Book>>((ref) async {
  final repo = ref.watch(bookRepositoryProvider);
  final query = ref.watch(searchQueryProvider);
  return repo.getBooks(nameFilter: query);
});

final bookChaptersProvider =
    FutureProvider.family<List<String>, String>((ref, bookId) async {
  final repo = ref.watch(bookRepositoryProvider);
  return repo.getBookChapters(bookId);
});

final quoteListProvider = FutureProvider<List<Quote>>((ref) async {
  final repo = ref.watch(quoteRepositoryProvider);
  final query = ref.watch(searchQueryProvider);
  return repo.getQuotes(textFilter: query);
});
