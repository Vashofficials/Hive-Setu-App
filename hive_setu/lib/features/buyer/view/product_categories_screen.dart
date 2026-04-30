import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/router/app_router.dart';
import '../../../core/widgets/app_header.dart';

class ProductCategoriesScreen extends StatelessWidget {
  const ProductCategoriesScreen({super.key});

  static const _categories = [
    _Category(name: 'Honey', subtitle: 'शहद', emoji: '🍯', count: 48, color: AppColors.primary),
    _Category(name: 'Beeswax', subtitle: 'मधुमोम', emoji: '🕯️', count: 15, color: AppColors.tertiary),
    _Category(name: 'Propolis', subtitle: 'प्रोपोलिस', emoji: '🧪', count: 12, color: AppColors.secondary),
    _Category(name: 'Royal Jelly', subtitle: 'रॉयल जेली', emoji: '👑', count: 8, color: AppColors.fpoPurple),
    _Category(name: 'Pollen', subtitle: 'पराग', emoji: '🌼', count: 22, color: AppColors.govtTeal),
    _Category(name: 'Bee Venom', subtitle: 'मधुमक्खी विष', emoji: '💉', count: 5, color: AppColors.error),
    _Category(name: 'Equipment', subtitle: 'उपकरण', emoji: '🔧', count: 31, color: AppColors.buyerBlue),
    _Category(name: 'Colonies', subtitle: 'कॉलोनी', emoji: '🐝', count: 18, color: AppColors.primary),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(title: 'Product Categories', subtitle: 'उत्पाद श्रेणियाँ'),
      body: GridView.builder(
        padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2, crossAxisSpacing: AppSpacing.md, mainAxisSpacing: AppSpacing.md, childAspectRatio: 1.1,
        ),
        itemCount: _categories.length,
        itemBuilder: (context, index) {
          final cat = _categories[index];
          return GestureDetector(
            onTap: () => context.push(AppRoutes.marketplace),
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppSpacing.cardRadius), boxShadow: AppColors.ambientShadow),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 48, height: 48,
                    decoration: BoxDecoration(color: cat.color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(AppSpacing.radiusMd)),
                    child: Center(child: Text(cat.emoji, style: const TextStyle(fontSize: 26))),
                  ),
                  Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text(cat.name, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.w700)),
                    Text(cat.subtitle, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
                    const SizedBox(height: 2),
                    Text('${cat.count} products', style: AppTextStyles.labelSmall.copyWith(color: cat.color)),
                  ]),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _Category {
  const _Category({required this.name, required this.subtitle, required this.emoji, required this.count, required this.color});
  final String name, subtitle, emoji;
  final int count;
  final Color color;
}
