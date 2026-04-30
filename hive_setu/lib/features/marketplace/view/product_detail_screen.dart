import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/router/app_router.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_header.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeader(title: 'Product Details', showBackButton: true),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 250,
              width: double.infinity,
              color: AppColors.primaryContainer.withValues(alpha: 0.15),
              child: const Center(child: Text('🍯', style: TextStyle(fontSize: 100))),
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Wild Forest Honey', style: AppTextStyles.headlineSmall),
                            Text('Sundarbans FPO • 4.8 ⭐ (120 reviews)', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceVariant)),
                          ],
                        ),
                      ),
                      Text('₹650/kg', style: AppTextStyles.headlineMedium.copyWith(color: AppColors.buyerBlue)),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(color: AppColors.secondary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(AppSpacing.radiusFull)),
                    child: Text('✓ 100% Certified Organic', style: AppTextStyles.labelMedium.copyWith(color: AppColors.secondary, fontWeight: FontWeight.w700)),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Text('Description', style: AppTextStyles.sectionTitle),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Raw, unfiltered honey collected by tribal honey hunters from the deep Sundarbans mangroves. Known for its distinct woody flavor and high medicinal value. Crystalizes naturally in cold weather.',
                    style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceVariant, height: 1.5),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Text('Traceability', style: AppTextStyles.sectionTitle),
                  const SizedBox(height: AppSpacing.sm),
                  _TraceItem(icon: '📍', title: 'Source', value: 'Sundarbans Forest Reserve, West Bengal'),
                  _TraceItem(icon: '🗓️', title: 'Harvest Date', value: '12 April 2026'),
                  _TraceItem(icon: '🏷️', title: 'FPO Certification No.', value: 'FPO-WB-2024-88A2'),
                  const SizedBox(height: AppSpacing.xxl),
                  Row(
                    children: [
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () {},
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppColors.buyerBlue,
                            side: BorderSide(color: AppColors.buyerBlue.withValues(alpha: 0.3)),
                            padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.radiusMd)),
                          ),
                          child: Text('Add to Cart', style: AppTextStyles.buttonSmall.copyWith(color: AppColors.buyerBlue)),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(
                        child: AppButton(
                          label: 'Buy Now',
                          onPressed: () => context.push(AppRoutes.checkout),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TraceItem extends StatelessWidget {
  const _TraceItem({required this.icon, required this.title, required this.value});
  final String icon, title, value;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(icon, style: const TextStyle(fontSize: 18)),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.labelSmall.copyWith(color: AppColors.onSurfaceVariant)),
                  Text(value, style: AppTextStyles.bodyMedium),
                ],
              ),
            ),
          ],
        ),
      );
}
