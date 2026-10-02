import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_colors.dart';
import '../../books/presentation/widgets/book_card.dart';
import '../../characters/presentation/widgets/character_card.dart';
import '../../movies/presentation/widgets/movie_card.dart';
import '../../quotes/presentation/widgets/quote_card.dart';
import '../providers/home_providers.dart';
import 'widgets/category_pills.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final activeTab = ref.watch(selectedCategoryProvider);

    return Scaffold(
      backgroundColor: AppColors.bgMain,
      appBar: AppBar(
        title: const Text('Middle-Earth'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(110),
          child: MaxWidthContainer(
            maxWidth: 600,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                  child: TextField(
                    controller: _searchController,
                    style: const TextStyle(color: AppColors.textPrimary),
                    decoration: InputDecoration(
                      hintText: _getHintText(activeTab),
                      prefixIcon: const Icon(Icons.search, color: AppColors.ringGold),
                      suffixIcon: _searchController.text.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.clear, color: AppColors.textSecondary),
                              onPressed: () {
                                _searchController.clear();
                                ref.read(searchQueryProvider.notifier).state = '';
                              },
                            )
                          : null,
                    ),
                    onChanged: (val) {
                      ref.read(searchQueryProvider.notifier).state = val.trim();
                    },
                  ),
                ),
                const CategoryPills(),
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: MaxWidthContainer(
          maxWidth: 600,
          child: _buildBody(activeTab),
        ),
      ),
    );
  }

  String _getHintText(CategoryTab tab) {
    switch (tab) {
      case CategoryTab.characters:
        return 'Search characters by name, race, or realm...';
      case CategoryTab.movies:
        return 'Search movies...';
      case CategoryTab.books:
        return 'Search books...';
      case CategoryTab.quotes:
        return 'Search quotes...';
    }
  }

  Widget _buildBody(CategoryTab tab) {
    switch (tab) {
      case CategoryTab.characters:
        return _buildCharacterList();
      case CategoryTab.movies:
        return _buildMovieList();
      case CategoryTab.books:
        return _buildBookList();
      case CategoryTab.quotes:
        return _buildQuoteList();
    }
  }

  Widget _buildCharacterList() {
    final asyncData = ref.watch(characterListProvider);
    return RefreshIndicator(
      color: AppColors.ringGold,
      backgroundColor: AppColors.bgSurface,
      onRefresh: () async => ref.refresh(characterListProvider.future),
      child: asyncData.when(
        data: (characters) {
          if (characters.isEmpty) return _buildEmptyView('No characters found');
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10),
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: characters.length,
            itemBuilder: (context, index) {
              final character = characters[index];
              return CharacterCard(
                character: character,
                onTap: () {
                  context.push(
                    '/character/${character.id}',
                    extra: character.toJson(),
                  );
                },
              );
            },
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.ringGold),
        ),
        error: (err, _) => _buildErrorView(err.toString(), () {
          ref.invalidate(characterListProvider);
        }),
      ),
    );
  }

  Widget _buildMovieList() {
    final asyncData = ref.watch(movieListProvider);
    return RefreshIndicator(
      color: AppColors.ringGold,
      backgroundColor: AppColors.bgSurface,
      onRefresh: () async => ref.refresh(movieListProvider.future),
      child: asyncData.when(
        data: (movies) {
          if (movies.isEmpty) return _buildEmptyView('No movies found');
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10),
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return MovieCard(
                movie: movie,
                onTap: () {
                  context.push(
                    '/movie/${movie.id}',
                    extra: movie.toJson(),
                  );
                },
              );
            },
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.ringGold),
        ),
        error: (err, _) => _buildErrorView(err.toString(), () {
          ref.invalidate(movieListProvider);
        }),
      ),
    );
  }

  Widget _buildBookList() {
    final asyncData = ref.watch(bookListProvider);
    return RefreshIndicator(
      color: AppColors.ringGold,
      backgroundColor: AppColors.bgSurface,
      onRefresh: () async => ref.refresh(bookListProvider.future),
      child: asyncData.when(
        data: (books) {
          if (books.isEmpty) return _buildEmptyView('No books found');
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10),
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: books.length,
            itemBuilder: (context, index) {
              final book = books[index];
              return BookCard(
                book: book,
                onTap: () {
                  context.push(
                    '/book/${book.id}',
                    extra: book.toJson(),
                  );
                },
              );
            },
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.ringGold),
        ),
        error: (err, _) => _buildErrorView(err.toString(), () {
          ref.invalidate(bookListProvider);
        }),
      ),
    );
  }

  Widget _buildQuoteList() {
    final asyncData = ref.watch(quoteListProvider);
    return RefreshIndicator(
      color: AppColors.ringGold,
      backgroundColor: AppColors.bgSurface,
      onRefresh: () async => ref.refresh(quoteListProvider.future),
      child: asyncData.when(
        data: (quotes) {
          if (quotes.isEmpty) return _buildEmptyView('No quotes found');
          return ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10),
            physics: const AlwaysScrollableScrollPhysics(),
            itemCount: quotes.length,
            itemBuilder: (context, index) {
              final quote = quotes[index];
              return QuoteCard(quote: quote);
            },
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.ringGold),
        ),
        error: (err, _) => _buildErrorView(err.toString(), () {
          ref.invalidate(quoteListProvider);
        }),
      ),
    );
  }

  Widget _buildEmptyView(String message) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        const SizedBox(height: 80),
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(
                Icons.explore_off_outlined,
                size: 48,
                color: AppColors.textSecondary,
              ),
              const SizedBox(height: 16),
              Text(
                message,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.textSecondary,
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildErrorView(String err, VoidCallback onRetry) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        const SizedBox(height: 80),
        Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.redAccent),
                const SizedBox(height: 16),
                Text('Error loading data', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Text(err, style: Theme.of(context).textTheme.bodyMedium, textAlign: TextAlign.center),
                const SizedBox(height: 16),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.ringGold,
                    foregroundColor: AppColors.bgMain,
                  ),
                  onPressed: onRetry,
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MaxWidthContainer extends StatelessWidget {
  final double maxWidth;
  final Widget child;

  const MaxWidthContainer({
    super.key,
    required this.maxWidth,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ConstrainedBox(
        constraints: BoxConstraints(maxWidth: maxWidth),
        child: child,
      ),
    );
  }
}
