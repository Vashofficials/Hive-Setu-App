import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/router/app_router.dart';
import '../../../core/widgets/app_header.dart';
import '../../../core/widgets/app_input.dart';

class MarketplaceScreen extends StatelessWidget {
  const MarketplaceScreen({super.key});

  static const _products = [
    _MarketItem(name: 'Wild Forest Honey', origin: 'Sundarbans FPO', price: 650, rating: 4.8, type: 'Raw, Organic'),
    _MarketItem(name: 'Pure Mustard Honey', origin: 'Muzaffarnagar FPO', price: 320, rating: 4.5, type: 'Crystallized'),
    _MarketItem(name: 'Natural Beeswax', origin: 'Almora Beekeepers', price: 450, rating: 4.9, type: 'Cosmetic Grade'),
    _MarketItem(name: 'Acacia Honey', origin: 'Haryana FPO', price: 480, rating: 4.6, type: 'Raw, Filtered'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeader(title: 'Marketplace', subtitle: 'हनी बाज़ार'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
            child: AppInput(
              controller: TextEditingController(),
              hint: 'Search honey, beeswax...',
              prefixIcon: const Icon(Icons.search_rounded, color: AppColors.onSurfaceVariant),
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPaddingH, vertical: AppSpacing.md),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.75,
                crossAxisSpacing: AppSpacing.md,
                mainAxisSpacing: AppSpacing.md,
              ),
              itemCount: _products.length,
              itemBuilder: (context, i) => _ProductCard(item: _products[i]),
            ),
          ),
        ],
      ),
    );
  }
}

class _MarketItem {
  const _MarketItem({required this.name, required this.origin, required this.price, required this.rating, required this.type});
  final String name, origin, type;
  final int price;
  final double rating;
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.item});
  final _MarketItem item;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push(AppRoutes.productDetail),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          boxShadow: AppColors.ambientShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(color: AppColors.primaryContainer.withValues(alpha: 0.15), borderRadius: const BorderRadius.vertical(top: Radius.circular(AppSpacing.cardRadius - 1))),
                child: const Center(child: Text('🍯', style: TextStyle(fontSize: 48))),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name, style: AppTextStyles.titleSmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                  Text(item.origin, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
                  const SizedBox(height: 4),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('₹${item.price}/kg', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.buyerBlue, fontWeight: FontWeight.w700)),
                      Row(children: [
                        const Icon(Icons.star_rounded, color: AppColors.amberAlert, size: 14),
                        const SizedBox(width: 2),
                        Text(item.rating.toString(), style: AppTextStyles.labelSmall),
                      ]),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
