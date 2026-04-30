import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/router/app_router.dart';
import '../../../core/widgets/app_header.dart';

class BuyerDashboardScreen extends StatelessWidget {
  const BuyerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(
        title: 'Buyer Dashboard',
        subtitle: 'खरीदार डैशबोर्ड',
        actions: [
          GestureDetector(
            onTap: () => context.push(AppRoutes.cart),
            child: Container(
              width: 44, height: 44,
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
              child: const Icon(Icons.shopping_cart_outlined, size: AppSpacing.iconMd, color: AppColors.onSurface),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Search Bar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.lg, vertical: AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.surface,
                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                boxShadow: AppColors.ambientShadow,
              ),
              child: Row(
                children: [
                  const Icon(Icons.search_rounded, color: AppColors.onSurfaceVariant),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(child: Text('Search honey, beeswax, propolis...', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceVariant))),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            // Quick Actions Row
            Row(
              children: [
                _QuickAction(icon: Icons.category_rounded, label: 'Browse', color: AppColors.buyerBlue, onTap: () => context.push(AppRoutes.productCategories)),
                const SizedBox(width: AppSpacing.md),
                _QuickAction(icon: Icons.inventory_rounded, label: 'Bulk Order', color: AppColors.primary, onTap: () => context.push(AppRoutes.bulkEnquiry)),
                const SizedBox(width: AppSpacing.md),
                _QuickAction(icon: Icons.receipt_long_rounded, label: 'My Orders', color: AppColors.secondary, onTap: () => context.push(AppRoutes.ordersList)),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            // Stats
            Row(
              children: const [
                Expanded(child: _StatCard(title: 'Active Orders', value: '3', icon: '📦', color: AppColors.buyerBlue)),
                SizedBox(width: AppSpacing.md),
                Expanded(child: _StatCard(title: 'This Month', value: '₹1.8L', icon: '📈', color: AppColors.primary)),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            // Featured FPOs
            Text('Featured FPOs', style: AppTextStyles.sectionTitle),
            const SizedBox(height: AppSpacing.md),
            SizedBox(
              height: 130,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: const [
                  _FpoCard(name: 'Sundarbans Honey FPO', location: 'West Bengal', rating: 4.8),
                  _FpoCard(name: 'Nilgiri Bee Co-op', location: 'Tamil Nadu', rating: 4.6),
                  _FpoCard(name: 'Aravalli Madhu FPO', location: 'Rajasthan', rating: 4.7),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            // Recommended Products
            Text('Recommended Products', style: AppTextStyles.sectionTitle),
            const SizedBox(height: AppSpacing.md),
            _ProductTile(name: 'Organic Mustard Honey', fpo: 'Aravalli FPO', price: '₹320/kg', onTap: () => context.push(AppRoutes.productDetail)),
            _ProductTile(name: 'Raw Acacia Honey', fpo: 'Sundarbans FPO', price: '₹450/kg', onTap: () => context.push(AppRoutes.productDetail)),
            _ProductTile(name: 'Pure Beeswax Blocks', fpo: 'Nilgiri Co-op', price: '₹280/kg', onTap: () => context.push(AppRoutes.productDetail)),
            const SizedBox(height: AppSpacing.massive),
          ],
        ),
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({required this.icon, required this.label, required this.color, required this.onTap});
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
          decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppSpacing.radiusLg), boxShadow: AppColors.ambientShadow),
          child: Column(
            children: [
              Container(width: 40, height: 40, decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(AppSpacing.radiusMd)), child: Icon(icon, color: color, size: 20)),
              const SizedBox(height: AppSpacing.xs),
              Text(label, style: AppTextStyles.labelSmall.copyWith(color: AppColors.onSurface), textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.title, required this.value, required this.icon, required this.color});
  final String title, value, icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppSpacing.cardRadius), boxShadow: AppColors.ambientShadow),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(icon, style: const TextStyle(fontSize: 22)),
        const SizedBox(height: AppSpacing.sm),
        Text(value, style: AppTextStyles.titleLarge.copyWith(color: color)),
        Text(title, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
      ]),
    );
  }
}

class _FpoCard extends StatelessWidget {
  const _FpoCard({required this.name, required this.location, required this.rating});
  final String name, location;
  final double rating;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 190, margin: const EdgeInsets.only(right: AppSpacing.md), padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppSpacing.cardRadius), boxShadow: AppColors.ambientShadow),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(name, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.w700), maxLines: 2, overflow: TextOverflow.ellipsis),
        Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('📍 $location', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
          Row(children: [const Icon(Icons.star_rounded, size: 14, color: AppColors.tertiary), Text(' $rating', style: AppTextStyles.labelSmall.copyWith(color: AppColors.primary))]),
        ]),
      ]),
    );
  }
}

class _ProductTile extends StatelessWidget {
  const _ProductTile({required this.name, required this.fpo, required this.price, required this.onTap});
  final String name, fpo, price;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppSpacing.cardRadius), boxShadow: AppColors.ambientShadow),
          child: Row(children: [
            Container(width: 48, height: 48, decoration: BoxDecoration(color: AppColors.primaryContainer.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(AppSpacing.radiusMd)), child: const Center(child: Text('🍯', style: TextStyle(fontSize: 24)))),
            const SizedBox(width: AppSpacing.md),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(name, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.w700)),
              Text(fpo, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
            ])),
            Text(price, style: AppTextStyles.titleSmall.copyWith(color: AppColors.primary, fontWeight: FontWeight.w700)),
          ]),
        ),
      ),
    );
  }
}
