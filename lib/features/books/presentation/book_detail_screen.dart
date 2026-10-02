import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../home/providers/home_providers.dart';
import '../data/models/book.dart';

class BookDetailScreen extends ConsumerWidget {
  final String bookId;
  final Map<String, dynamic>? bookData;

  const BookDetailScreen({
    super.key,
    required this.bookId,
    this.bookData,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (bookData != null) {
      final book = Book.fromJson(bookData!);
      return _BookDetailView(book: book);
    }

    final booksAsync = ref.watch(bookListProvider);

    return Scaffold(
      backgroundColor: AppColors.bgMain,
      appBar: AppBar(title: const Text('Book Details')),
      body: booksAsync.when(
        data: (books) {
          final book = books.firstWhere(
            (b) => b.id == bookId,
            orElse: () => Book(
              id: bookId,
              name: 'LOTR Book',
              imageUrl: 'https://images.unsplash.com/photo-1544716278-ca5e3f4abd8c?q=80&w=600&auto=format&fit=crop',
            ),
          );
          return _BookDetailView(book: book);
        },
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.ringGold),
        ),
        error: (err, _) => Center(
          child: Text('Error loading book details: $err'),
        ),
      ),
    );
  }
}

class _BookDetailView extends ConsumerWidget {
  final Book book;

  const _BookDetailView({required this.book});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chaptersAsync = ref.watch(bookChaptersProvider(book.id));

    return Scaffold(
      backgroundColor: AppColors.bgMain,
      appBar: AppBar(title: Text(book.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Cover
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    book.imageUrl,
                    height: 220,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),

                // Title & Author Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.bgSurface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.ringGold.withValues(alpha: 0.3)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        book.name,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: AppColors.ringGold,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 6),
                      const Text(
                        'Author: J.R.R. Tolkien',
                        style: TextStyle(color: AppColors.textSecondary, fontSize: 15),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Chapters Card
                Container(
                  padding: const EdgeInsets.all(20),
                  decoration: BoxDecoration(
                    color: AppColors.bgSurface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.borderDark),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.menu_book, color: AppColors.ringGold, size: 22),
                          const SizedBox(width: 8),
                          Text(
                            'Book Chapters',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: AppColors.ringGold,
                                  fontSize: 18,
                                ),
                          ),
                        ],
                      ),
                      const Divider(color: AppColors.borderDark, height: 24),
                      chaptersAsync.when(
                        data: (chapters) {
                          if (chapters.isEmpty) {
                            return const Text('No chapters listed.',
                                style: TextStyle(color: AppColors.textSecondary));
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: chapters.asMap().entries.map((entry) {
                              final index = entry.key + 1;
                              final name = entry.value;
                              return Padding(
                                padding: const EdgeInsets.symmetric(vertical: 6.0),
                                child: Text(
                                  '$index. $name',
                                  style: const TextStyle(
                                    color: AppColors.textPrimary,
                                    fontSize: 14,
                                    height: 1.4,
                                  ),
                                ),
                              );
                            }).toList(),
                          );
                        },
                        loading: () => const Center(
                          child: CircularProgressIndicator(color: AppColors.ringGold),
                        ),
                        error: (err, stackTrace) => const Text('Unable to load chapters.',
                            style: TextStyle(color: AppColors.textSecondary)),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
