import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../quotes/data/models/quote.dart';
import '../data/models/character.dart';
import '../providers/character_providers.dart';

class CharacterDetailScreen extends ConsumerWidget {
  final String characterId;
  final Map<String, dynamic>? characterData;

  const CharacterDetailScreen({
    super.key,
    required this.characterId,
    this.characterData,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (characterData != null) {
      final character = Character.fromJson(characterData!);
      return _CharacterDetailView(character: character);
    }

    final detailAsync = ref.watch(characterDetailProvider(characterId));

    return Scaffold(
      backgroundColor: AppColors.bgMain,
      appBar: AppBar(
        title: const Text('Character Lore'),
      ),
      body: detailAsync.when(
        data: (character) {
          if (character == null) {
            return const Center(
              child: Text(
                'Character not found',
                style: TextStyle(color: AppColors.textPrimary),
              ),
            );
          }
          return _CharacterDetailView(character: character);
        },
        loading: () => const Center(
          child: CircularProgressIndicator(color: AppColors.ringGold),
        ),
        error: (err, stack) => Center(
          child: Text(
            'Error loading details: $err',
            style: const TextStyle(color: Colors.redAccent),
          ),
        ),
      ),
    );
  }
}

class _CharacterDetailView extends ConsumerWidget {
  final Character character;

  const _CharacterDetailView({required this.character});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quotesAsync = ref.watch(characterQuotesProvider(character.id));

    return Scaffold(
      backgroundColor: AppColors.bgMain,
      appBar: AppBar(
        title: Text(character.name),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header Banner Card with Image
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.bgSurface,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(color: AppColors.ringGold.withValues(alpha: 0.4)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.4),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      // Banner Image
                      ClipRRect(
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(12)),
                        child: Stack(
                          alignment: Alignment.bottomCenter,
                          children: [
                            Image.network(
                              character.imageUrl,
                              height: 180,
                              width: double.infinity,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) => Container(
                                height: 180,
                                color: AppColors.bgSurface,
                              ),
                            ),
                            Container(
                              height: 180,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Colors.transparent,
                                    AppColors.bgSurface.withValues(alpha: 0.8),
                                    AppColors.bgSurface,
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Name & Subtitle
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                        child: Column(
                          children: [
                            Text(
                              character.name,
                              textAlign: TextAlign.center,
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                    color: AppColors.ringGold,
                                    fontSize: 26,
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              '${character.race} • ${character.gender}',
                              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                    color: AppColors.textSecondary,
                                    fontSize: 16,
                                  ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Lore & Attributes Container
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
                          const Icon(Icons.shield_outlined, color: AppColors.ringGold, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            'Lore & Attributes',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: AppColors.ringGold,
                                  fontSize: 18,
                                ),
                          ),
                        ],
                      ),
                      const Divider(color: AppColors.borderDark, height: 24),
                      _InfoRow(label: 'Realm', value: character.realm),
                      _InfoRow(label: 'Spouse', value: character.spouse),
                      _InfoRow(label: 'Birth', value: character.birth),
                      _InfoRow(label: 'Death', value: character.death),
                      _InfoRow(label: 'Hair Color', value: character.hair),
                      if (character.wikiUrl.isNotEmpty) ...[
                        const SizedBox(height: 8),
                        _InfoRow(label: 'Wiki', value: character.wikiUrl),
                      ],
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Quotes Section
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
                            'Famous Spoken Quotes',
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
                            return const Text(
                              'No spoken quotes recorded in the archives for this character.',
                              style: TextStyle(color: AppColors.textSecondary, fontStyle: FontStyle.italic),
                            );
                          }
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: quotes.take(5).map((q) => _QuoteTile(quote: q)).toList(),
                          );
                        },
                        loading: () => const Center(
                          child: CircularProgressIndicator(color: AppColors.ringGold),
                        ),
                        error: (err, stack) => const Text(
                          'Unable to load quotes.',
                          style: TextStyle(color: AppColors.textSecondary),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),

                // Featured In Books & Movies Section
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
                          const Icon(Icons.auto_stories_outlined, color: AppColors.ringGold, size: 20),
                          const SizedBox(width: 8),
                          Text(
                            'Featured In Works',
                            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: AppColors.ringGold,
                                  fontSize: 18,
                                ),
                          ),
                        ],
                      ),
                      const Divider(color: AppColors.borderDark, height: 24),
                      const Text(
                        '• The Fellowship of the Ring',
                        style: TextStyle(color: AppColors.textPrimary, fontSize: 14, height: 1.6),
                      ),
                      const Text(
                        '• The Two Towers',
                        style: TextStyle(color: AppColors.textPrimary, fontSize: 14, height: 1.6),
                      ),
                      const Text(
                        '• The Return of the King',
                        style: TextStyle(color: AppColors.textPrimary, fontSize: 14, height: 1.6),
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

class _QuoteTile extends StatelessWidget {
  final Quote quote;

  const _QuoteTile({required this.quote});

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

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 110,
            child: Text(
              label,
              style: const TextStyle(
                color: AppColors.textSecondary,
                fontWeight: FontWeight.w600,
                fontSize: 14,
              ),
            ),
          ),
          Expanded(
            child: Text(
              value,
              style: const TextStyle(
                color: AppColors.textPrimary,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
