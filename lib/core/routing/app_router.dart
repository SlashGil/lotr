import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../features/books/presentation/book_detail_screen.dart';
import '../../features/characters/presentation/character_detail_screen.dart';
import '../../features/home/presentation/home_screen.dart';
import '../../features/movies/presentation/movie_detail_screen.dart';
import '../../features/splash/presentation/splash_screen.dart';

final GoRouter appRouter = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomeScreen(),
    ),
    GoRoute(
      path: '/character/:id',
      builder: (context, state) {
        final characterId = state.pathParameters['id'] ?? '';
        final extra = state.extra;
        return CharacterDetailScreen(
          characterId: characterId,
          characterData: extra is Map<String, dynamic> ? extra : null,
        );
      },
    ),
    GoRoute(
      path: '/movie/:id',
      builder: (context, state) {
        final movieId = state.pathParameters['id'] ?? '';
        final extra = state.extra;
        return MovieDetailScreen(
          movieId: movieId,
          movieData: extra is Map<String, dynamic> ? extra : null,
        );
      },
    ),
    GoRoute(
      path: '/book/:id',
      builder: (context, state) {
        final bookId = state.pathParameters['id'] ?? '';
        final extra = state.extra;
        return BookDetailScreen(
          bookId: bookId,
          bookData: extra is Map<String, dynamic> ? extra : null,
        );
      },
    ),
  ],
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Route not found: ${state.uri}'),
    ),
  ),
);
