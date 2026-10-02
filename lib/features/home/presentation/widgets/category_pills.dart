import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/theme/app_colors.dart';
import '../../providers/home_providers.dart';

class CategoryPills extends ConsumerWidget {
  const CategoryPills({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTab = ref.watch(selectedCategoryProvider);

    final tabs = [
      (CategoryTab.characters, 'Characters', Icons.person_outline),
      (CategoryTab.movies, 'Movies', Icons.movie_outlined),
      (CategoryTab.books, 'Books', Icons.menu_book_outlined),
      (CategoryTab.quotes, 'Quotes', Icons.format_quote_outlined),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: tabs.map((item) {
          final isSelected = selectedTab == item.$1;
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    ref.read(selectedCategoryProvider.notifier).state = item.$1;
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.ringGold : AppColors.bgSurface,
                      borderRadius: BorderRadius.circular(20),
                      border: Border.all(
                        color: isSelected ? AppColors.ringGold : AppColors.borderDark,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: AppColors.ringGold.withValues(alpha: 0.3),
                                blurRadius: 8,
                                offset: const Offset(0, 2),
                              ),
                            ]
                          : [],
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          item.$3,
                          size: 18,
                          color: isSelected ? AppColors.bgMain : AppColors.ringGold,
                        ),
                        const SizedBox(width: 6),
                        Text(
                          item.$2,
                          style: TextStyle(
                            color: isSelected ? AppColors.bgMain : AppColors.textPrimary,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
