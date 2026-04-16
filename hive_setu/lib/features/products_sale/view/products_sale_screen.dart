import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/app_header.dart';

class ProductsSaleScreen extends StatelessWidget {
  const ProductsSaleScreen({super.key});

  static const _products = [
    _SaleProduct(name: 'Mustard Honey', qty: '20 kg', price: 280, status: 'Available'),
    _SaleProduct(name: 'Acacia Honey', qty: '10 kg', price: 420, status: 'Available'),
    _SaleProduct(name: 'Beeswax', qty: '2 kg', price: 350, status: 'Sold'),
    _SaleProduct(name: 'Propolis', qty: '200 g', price: 800, status: 'Available'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeader(title: 'Products for Sale', subtitle: 'बिक्री के लिए उत्पाद'),
      body: ListView.separated(
        padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
        itemCount: _products.length,
        separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
        itemBuilder: (context, i) => _SaleCard(product: _products[i]),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        icon: const Icon(Icons.add_rounded),
        label: const Text('List Product'),
      ),
    );
  }
}

class _SaleProduct {
  const _SaleProduct({required this.name, required this.qty, required this.price, required this.status});
  final String name, qty, status;
  final int price;
}

class _SaleCard extends StatelessWidget {
  const _SaleCard({required this.product});
  final _SaleProduct product;

  @override
  Widget build(BuildContext context) {
    final isSold = product.status == 'Sold';
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        border: Border.all(color: AppColors.outlineVariant),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 8)],
      ),
      child: Row(
        children: [
          Container(
            width: 52, height: 52,
            decoration: BoxDecoration(
              color: AppColors.primaryContainer.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: const Center(child: Text('🍯', style: TextStyle(fontSize: 28))),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(product.name, style: AppTextStyles.titleSmall),
                Text('Qty: ${product.qty}', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
                Text('₹${product.price}/kg', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary, fontWeight: FontWeight.w700)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
            decoration: BoxDecoration(
              color: isSold
                  ? AppColors.onSurfaceVariant.withValues(alpha: 0.1)
                  : AppColors.secondary.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
            ),
            child: Text(
              product.status,
              style: AppTextStyles.labelSmall.copyWith(
                color: isSold ? AppColors.onSurfaceVariant : AppColors.secondary,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
