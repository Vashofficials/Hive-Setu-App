import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/router/app_router.dart';
import '../../../core/widgets/app_header.dart';
import '../../../core/widgets/app_input.dart';

class ProductCategoriesScreen extends StatefulWidget {
  const ProductCategoriesScreen({super.key});

  @override
  State<ProductCategoriesScreen> createState() => _ProductCategoriesScreenState();
}

class _ProductCategoriesScreenState extends State<ProductCategoriesScreen> {
  final _searchController = TextEditingController();
  String _selectedCategory = 'All';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  static const _categories = [
    _Category(name: 'All', emoji: '🍀', count: 48),
    _Category(name: 'Raw Honey', emoji: '🍯', count: 18),
    _Category(name: 'Processed Honey', emoji: '✨', count: 12),
    _Category(name: 'Beeswax', emoji: '🕯️', count: 7),
    _Category(name: 'Propolis', emoji: '🟤', count: 5),
    _Category(name: 'Royal Jelly', emoji: '👑', count: 4),
    _Category(name: 'Pollen', emoji: '🌸', count: 2),
  ];

  static const _products = [
    _Prod(name: 'Wild Forest Honey', fpo: 'Sundarbans FPO', price: 650, rating: 4.8, emoji: '🍯', category: 'Raw Honey', origin: 'West Bengal', organic: true),
    _Prod(name: 'Mustard Honey', fpo: 'Muzaffarnagar FPO', price: 280, rating: 4.5, emoji: '🌻', category: 'Raw Honey', origin: 'Uttar Pradesh', organic: true),
    _Prod(name: 'Natural Beeswax', fpo: 'Almora Beekeepers', price: 450, rating: 4.9, emoji: '🕯️', category: 'Beeswax', origin: 'Uttarakhand', organic: false),
    _Prod(name: 'Acacia Honey', fpo: 'Haryana FPO', price: 480, rating: 4.6, emoji: '🌼', category: 'Raw Honey', origin: 'Haryana', organic: true),
    _Prod(name: 'Propolis Extract', fpo: 'Bihar Beekeepers', price: 320, rating: 4.4, emoji: '🟤', category: 'Propolis', origin: 'Bihar', organic: false),
    _Prod(name: 'Jamun Honey', fpo: 'Odisha FPO', price: 380, rating: 4.7, emoji: '🫐', category: 'Raw Honey', origin: 'Odisha', organic: true),
  ];

  List<_Prod> get _filtered {
    final q = _searchController.text.toLowerCase();
    return _products.where((p) {
      final matchCat = _selectedCategory == 'All' || p.category == _selectedCategory;
      final matchQ = q.isEmpty || p.name.toLowerCase().contains(q) || p.fpo.toLowerCase().contains(q);
      return matchCat && matchQ;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeader(title: 'Browse Products', subtitle: 'उत्पाद श्रेणी'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPaddingH, vertical: AppSpacing.sm),
            child: AppInput(
              controller: _searchController,
              hint: 'Search honey, wax, propolis...',
              prefixIcon: const Icon(Icons.search_rounded, color: AppColors.onSurfaceVariant),
              onChanged: (_) => setState(() {}),
            ),
          ),
          SizedBox(
            height: 52,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPaddingH),
              itemCount: _categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
              itemBuilder: (_, i) {
                final c = _categories[i];
                final isSelected = _selectedCategory == c.name;
                return GestureDetector(
                  onTap: () => setState(() => _selectedCategory = c.name),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 150),
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
                    decoration: BoxDecoration(
                      color: isSelected ? AppColors.buyerBlue : AppColors.surface,
                      borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                      boxShadow: AppColors.ambientShadow,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(c.emoji, style: const TextStyle(fontSize: 14)),
                        const SizedBox(width: 4),
                        Text(
                          c.name,
                          style: AppTextStyles.labelMedium.copyWith(
                            color: isSelected ? AppColors.white : AppColors.onSurface,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPaddingH, vertical: AppSpacing.sm),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.72,
                crossAxisSpacing: AppSpacing.md,
                mainAxisSpacing: AppSpacing.md,
              ),
              itemCount: _filtered.length,
              itemBuilder: (_, i) => _ProdCard(prod: _filtered[i], onTap: () => context.push(AppRoutes.productDetail)),
            ),
          ),
        ],
      ),
    );
  }
}

class _Category {
  const _Category({required this.name, required this.emoji, required this.count});
  final String name, emoji;
  final int count;
}

class _Prod {
  const _Prod({required this.name, required this.fpo, required this.price, required this.rating, required this.emoji, required this.category, required this.origin, required this.organic});
  final String name, fpo, emoji, category, origin;
  final int price;
  final double rating;
  final bool organic;
}

class _ProdCard extends StatelessWidget {
  const _ProdCard({required this.prod, required this.onTap});
  final _Prod prod;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
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
                child: Stack(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: AppColors.buyerBlue.withValues(alpha: 0.08),
                        borderRadius: const BorderRadius.vertical(top: Radius.circular(AppSpacing.cardRadius)),
                      ),
                      child: Center(child: Text(prod.emoji, style: const TextStyle(fontSize: 44))),
                    ),
                    if (prod.organic)
                      Positioned(
                        top: 8,
                        left: 8,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: AppColors.secondary,
                            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                          ),
                          child: Text('Organic', style: AppTextStyles.caption.copyWith(color: AppColors.white, fontWeight: FontWeight.w600)),
                        ),
                      ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(prod.name, style: AppTextStyles.titleSmall, maxLines: 1, overflow: TextOverflow.ellipsis),
                    Text(prod.fpo, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant), maxLines: 1, overflow: TextOverflow.ellipsis),
                    Text(prod.origin, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('₹${prod.price}/kg', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.buyerBlue, fontWeight: FontWeight.w700)),
                        Row(children: [
                          const Icon(Icons.star_rounded, color: AppColors.amberAlert, size: 12),
                          Text(prod.rating.toString(), style: AppTextStyles.caption),
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
