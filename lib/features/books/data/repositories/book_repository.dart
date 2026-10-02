import '../../../../core/network/dio_client.dart';
import '../models/book.dart';

class BookRepository {
  final DioClient _dioClient;

  BookRepository({DioClient? dioClient})
      : _dioClient = dioClient ?? DioClient();

  Future<List<Book>> getBooks({String? nameFilter}) async {
    try {
      final response = await _dioClient.dio.get('/book');
      if (response.statusCode == 200 && response.data != null) {
        final docs = response.data['docs'] as List<dynamic>?;
        if (docs != null && docs.isNotEmpty) {
          var books = docs
              .map((json) => Book.fromJson(json as Map<String, dynamic>))
              .toList();

          if (nameFilter != null && nameFilter.isNotEmpty) {
            final query = nameFilter.toLowerCase();
            books = books
                .where((b) => b.name.toLowerCase().contains(query))
                .toList();
          }

          if (books.isNotEmpty) {
            return books;
          }
        }
      }
    } catch (_) {}

    return _getMockBooks(nameFilter);
  }

  Future<List<String>> getBookChapters(String bookId) async {
    try {
      final response = await _dioClient.dio.get('/book/$bookId/chapter');
      if (response.statusCode == 200 && response.data != null) {
        final docs = response.data['docs'] as List<dynamic>?;
        if (docs != null && docs.isNotEmpty) {
          return docs
              .map((json) => json['chapterName'] as String? ?? 'Chapter')
              .where((name) => name.isNotEmpty)
              .toList();
        }
      }
    } catch (_) {}

    return [
      'A Long-expected Party',
      'The Shadow of the Past',
      'Three is Company',
      'A Short Cut to Mushrooms',
      'A Conspiracy Unmasked',
      'The Old Forest',
      'In the House of Tom Bombadil',
      'Fog on the Barrow-Downs',
      'At the Sign of The Prancing Pony',
      'Strider',
    ];
  }

  List<Book> _getMockBooks(String? filter) {
    const mockBooks = [
      Book(
        id: '5cf5805fb53e011a64671582',
        name: 'The Fellowship of the Ring',
        imageUrl: 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?q=80&w=600&auto=format&fit=crop',
      ),
      Book(
        id: '5cf58077b53e011a64671583',
        name: 'The Two Towers',
        imageUrl: 'https://images.unsplash.com/photo-1512820790803-83ca734da794?q=80&w=600&auto=format&fit=crop',
      ),
      Book(
        id: '5cf58080b53e011a64671584',
        name: 'The Return of the King',
        imageUrl: 'https://images.unsplash.com/photo-1497633762265-9d179a990aa6?q=80&w=600&auto=format&fit=crop',
      ),
    ];

    if (filter != null && filter.isNotEmpty) {
      final query = filter.toLowerCase();
      return mockBooks
          .where((b) => b.name.toLowerCase().contains(query))
          .toList();
    }

    return mockBooks;
  }
}
