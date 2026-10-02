import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import '../../data/models/quote.dart';

class QuoteCard extends StatelessWidget {
  final Quote quote;

  const QuoteCard({
    super.key,
    required this.quote,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: AppColors.bgSurface,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.ringGold.withValues(alpha: 0.3)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 6,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(
                Icons.format_quote,
                color: AppColors.ringGold,
                size: 28,
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  '"${quote.dialog}"',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        color: AppColors.textPrimary,
                        fontStyle: FontStyle.italic,
                        fontSize: 16,
                        height: 1.4,
                      ),
                ),
              ),
            ],
          ),
          if (quote.characterName != null && quote.characterName!.isNotEmpty) ...[
            const SizedBox(height: 12),
            Align(
              alignment: Alignment.centerRight,
              child: Text(
                '— ${quote.characterName}',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppColors.ringGold,
                      fontSize: 14,
                    ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
