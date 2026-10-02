import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lotr/features/characters/providers/character_providers.dart';
import 'package:lotr/features/characters/data/repositories/character_repository.dart';
import 'package:lotr/main.dart';

void main() {
  testWidgets('App renders Middle-Earth title smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          characterRepositoryProvider.overrideWithValue(CharacterRepository()),
        ],
        child: const LotrApp(),
      ),
    );

    await tester.pump();
    expect(find.text('MIDDLE-EARTH'), findsOneWidget);

    // Fast-forward past the splash screen timer (2.6 seconds)
    await tester.pump(const Duration(seconds: 3));
    await tester.pumpAndSettle();

    expect(find.text('Middle-Earth'), findsOneWidget);
  });
}
