import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/router/app_router.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_header.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  final _items = [
    _CartItem(name: 'Organic Mustard Honey', fpo: 'Aravalli Madhu FPO', price: 320, qty: 50, unit: 'kg', emoji: '🍯'),
    _CartItem(name: 'Raw Acacia Honey', fpo: 'Sundarbans Honey FPO', price: 450, qty: 25, unit: 'kg', emoji: '🌿'),
    _CartItem(name: 'Pure Beeswax Blocks', fpo: 'Nilgiri Bee Co-op', price: 280, qty: 10, unit: 'kg', emoji: '🕯️'),
  ];

  double get _subtotal => _items.fold(0, (s, i) => s + i.price * i.qty);
  double get _gst => _subtotal * 0.05;
  double get _total => _subtotal + _gst;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(title: 'Cart', subtitle: 'कार्ट — ${_items.length} items'),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
              itemCount: _items.length,
              separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
              itemBuilder: (context, index) {
                final item = _items[index];
                return Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppSpacing.cardRadius), boxShadow: AppColors.ambientShadow),
                  child: Row(
                    children: [
                      Container(
                        width: 48, height: 48,
                        decoration: BoxDecoration(color: AppColors.primaryContainer.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(AppSpacing.radiusMd)),
                        child: Center(child: Text(item.emoji, style: const TextStyle(fontSize: 24))),
                      ),
                      const SizedBox(width: AppSpacing.md),
                      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                        Text(item.name, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.w700)),
                        Text(item.fpo, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
                        Text('₹${item.price}/${item.unit} × ${item.qty} ${item.unit}', style: AppTextStyles.labelSmall.copyWith(color: AppColors.primary)),
                      ])),
                      Column(children: [
                        Text('₹${(item.price * item.qty).toStringAsFixed(0)}', style: AppTextStyles.titleSmall.copyWith(color: AppColors.onSurface, fontWeight: FontWeight.w700)),
                        GestureDetector(
                          onTap: () => setState(() => _items.removeAt(index)),
                          child: const Icon(Icons.delete_outline_rounded, color: AppColors.error, size: 20),
                        ),
                      ]),
                    ],
                  ),
                );
              },
            ),
          ),
          // Summary & Checkout
          Container(
            padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
            decoration: BoxDecoration(color: AppColors.surface, boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, -4))]),
            child: SafeArea(
              child: Column(children: [
                _SummaryRow(label: 'Subtotal', value: '₹${_subtotal.toStringAsFixed(0)}'),
                _SummaryRow(label: 'GST (5%)', value: '₹${_gst.toStringAsFixed(0)}'),
                const SizedBox(height: AppSpacing.sm),
                _SummaryRow(label: 'Total', value: '₹${_total.toStringAsFixed(0)}', isBold: true),
                const SizedBox(height: AppSpacing.lg),
                AppButton(
                  label: 'Proceed to Checkout',
                  onPressed: () => context.push(AppRoutes.shippingDetails),
                  width: double.infinity,
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _CartItem {
  _CartItem({required this.name, required this.fpo, required this.price, required this.qty, required this.unit, required this.emoji});
  final String name, fpo, unit, emoji;
  final double price;
  int qty;
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value, this.isBold = false});
  final String label, value;
  final bool isBold;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label, style: isBold ? AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.w700) : AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceVariant)),
        Text(value, style: isBold ? AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.w700, color: AppColors.primary) : AppTextStyles.bodyMedium),
      ]),
    );
  }
}
