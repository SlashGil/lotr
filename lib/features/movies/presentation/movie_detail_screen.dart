import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../home/providers/home_providers.dart';
import '../../quotes/data/models/quote.dart';
import '../data/models/movie.dart';

class MovieDetailScreen extends ConsumerWidget {
  final String movieId;
  final Map<String, dynamic>? movieData;

  const MovieDetailScreen({
    super.key,
    required this.movieId,
    this.movieData,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (movieData != null) {
      final movie = Movie.fromJson(movieData!);
      return _MovieDetailView(movie: movie);
    }

    final moviesAsync = ref.watch(movieListProvider);

    return Scaffold(
      backgroundColor: AppColors.bgMain,
      appBar: AppBar(title: const Text('Film Details')),
      body: moviesAsync.when(
        data: (movies) {
          final movie = movies.firstWhere(
            (m) => m.id == movieId,
            orElse: () => Movie(
              id: movieId,
              name: 'LOTR Film',
              runtimeInMinutes: 180,
              budgetInMillions: 90,
              boxOfficeRevenueInMillions: 900,
              academyAwardNominations: 10,
              academyAwardWins: 4,
              imageUrl: 'https://images.unsplash.com/photo-1519681393784-d120267933ba?q=80&w=600&auto=format&fit=crop',
            ),
          );
          return _MovieDetailView(movie: movie);
        },
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.ringGold),
        ),
        error: (err, _) => Center(
          child: Text('Error loading movie details: $err'),
        ),
      ),
    );
  }
}

class _MovieDetailView extends ConsumerWidget {
  final Movie movie;

  const _MovieDetailView({required this.movie});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quotesAsync = ref.watch(movieQuotesProvider(movie.id));

    return Scaffold(
      backgroundColor: AppColors.bgMain,
      appBar: AppBar(title: Text(movie.name)),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Banner & Poster
                ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.network(
                    movie.imageUrl,
                    height: 220,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),

                // Stats Card
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
                        movie.name,
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                              color: AppColors.ringGold,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const Divider(color: AppColors.borderDark, height: 24),
                      _StatRow(label: 'Runtime', value: '${movie.runtimeInMinutes} minutes'),
                      _StatRow(label: 'Budget', value: '\$${movie.budgetInMillions} Million'),
                      _StatRow(label: 'Box Office Revenue', value: '\$${movie.boxOfficeRevenueInMillions} Million'),
                      _StatRow(label: 'Academy Award Wins', value: '${movie.academyAwardWins} Oscars'),
                      _StatRow(label: 'Academy Award Nominations', value: '${movie.academyAwardNominations} Nominations'),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Quotes Card
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
                          const Icon(Icons.format_quote, color: AppColors.ringGold, size: 22),
                          const SizedBox(width: 8),
                          Text(
                            'Iconic Film Quotes',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: AppColors.ringGold,
                                  fontSize: 18,
                                ),
                          ),
                        ],
                      ),
                      const Divider(color: AppColors.borderDark, height: 24),
                      quotesAsync.when(
                        data: (quotes) {
                          if (quotes.isEmpty) {
                            return const Text('No quotes found for this film.',
                                style: TextStyle(color: AppColors.textSecondary));
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: quotes.map((q) => _MovieQuoteTile(quote: q)).toList(),
                          );
                        },
                        loading: () => const Center(
                          child: CircularProgressIndicator(color: AppColors.ringGold),
                        ),
                        error: (err, stack) => const Text('Unable to load film quotes.',
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

class _StatRow extends StatelessWidget {
  final String label;
  final String value;

  const _StatRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(color: AppColors.textSecondary, fontSize: 14)),
          Text(value, style: const TextStyle(color: AppColors.textPrimary, fontWeight: FontWeight.bold, fontSize: 14)),
        ],
      ),
    );
  }
}

class _MovieQuoteTile extends StatelessWidget {
  final Quote quote;

  const _MovieQuoteTile({required this.quote});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.bgMain,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: AppColors.ringGold.withValues(alpha: 0.2)),
        ),
        child: Text(
          '"${quote.dialog}"',
          style: const TextStyle(
            color: AppColors.textPrimary,
            fontStyle: FontStyle.italic,
            fontSize: 14,
            height: 1.4,
          ),
        ),
      ),
    );
  }
}
