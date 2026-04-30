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
  final List<_CartItem> _items = [
    _CartItem(name: 'Wild Forest Honey', fpo: 'Sundarbans FPO', pricePerKg: 650, qty: 2, emoji: '🍯'),
    _CartItem(name: 'Natural Beeswax', fpo: 'Almora Beekeepers', pricePerKg: 450, qty: 1, emoji: '🕯️'),
  ];

  int get _subtotal => _items.fold(0, (sum, i) => sum + i.pricePerKg * i.qty);
  int get _delivery => 120;
  int get _total => _subtotal + _delivery;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(
        title: 'My Cart',
        subtitle: '${_items.length} items',
        badge: '${_items.length}',
        badgeColor: AppColors.buyerBlue,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
              itemCount: _items.length,
              separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
              itemBuilder: (_, i) => _CartTile(
                item: _items[i],
                onIncrement: () => setState(() => _items[i] = _items[i].copyWith(qty: _items[i].qty + 1)),
                onDecrement: () {
                  if (_items[i].qty > 1) {
                    setState(() => _items[i] = _items[i].copyWith(qty: _items[i].qty - 1));
                  }
                },
                onRemove: () => setState(() => _items.removeAt(i)),
              ),
            ),
          ),
          _buildOrderSummary(context),
        ],
      ),
    );
  }

  Widget _buildOrderSummary(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
      decoration: const BoxDecoration(
        color: AppColors.surface,
        boxShadow: [BoxShadow(color: Color(0x14000000), blurRadius: 16, offset: Offset(0, -4))],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Order Summary', style: AppTextStyles.sectionTitle),
          const SizedBox(height: AppSpacing.md),
          _SummaryRow(label: 'Subtotal', value: '₹$_subtotal'),
          const SizedBox(height: AppSpacing.xs),
          _SummaryRow(label: 'Delivery', value: '₹$_delivery'),
          const SizedBox(height: AppSpacing.sm),
          const Divider(color: AppColors.outlineVariant),
          const SizedBox(height: AppSpacing.sm),
          _SummaryRow(
            label: 'Total',
            value: '₹$_total',
            bold: true,
          ),
          const SizedBox(height: AppSpacing.lg),
          AppButton(
            label: 'Proceed to Checkout',
            onPressed: () => context.push(AppRoutes.checkout),
            icon: const Icon(Icons.arrow_forward_rounded, color: AppColors.white, size: 18),
            width: double.infinity,
          ),
        ],
      ),
    );
  }
}

class _CartItem {
  const _CartItem({required this.name, required this.fpo, required this.pricePerKg, required this.qty, required this.emoji});
  final String name, fpo, emoji;
  final int pricePerKg, qty;

  _CartItem copyWith({int? qty}) => _CartItem(name: name, fpo: fpo, pricePerKg: pricePerKg, qty: qty ?? this.qty, emoji: emoji);
}

class _CartTile extends StatelessWidget {
  const _CartTile({required this.item, required this.onIncrement, required this.onDecrement, required this.onRemove});
  final _CartItem item;
  final VoidCallback onIncrement, onDecrement, onRemove;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          boxShadow: AppColors.ambientShadow,
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: AppColors.buyerBlue.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
              child: Center(child: Text(item.emoji, style: const TextStyle(fontSize: 28))),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.name, style: AppTextStyles.titleSmall),
                  Text(item.fpo, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
                  const SizedBox(height: AppSpacing.xs),
                  Text('₹${item.pricePerKg}/kg', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.buyerBlue, fontWeight: FontWeight.w700)),
                ],
              ),
            ),
            Column(
              children: [
                GestureDetector(onTap: onRemove, child: const Icon(Icons.delete_outline_rounded, size: 18, color: AppColors.error)),
                const SizedBox(height: AppSpacing.sm),
                Row(
                  children: [
                    _QtyBtn(icon: Icons.remove_rounded, onTap: onDecrement),
                    const SizedBox(width: AppSpacing.sm),
                    Text('${item.qty} kg', style: AppTextStyles.titleSmall),
                    const SizedBox(width: AppSpacing.sm),
                    _QtyBtn(icon: Icons.add_rounded, onTap: onIncrement),
                  ],
                ),
              ],
            ),
          ],
        ),
      );
}

class _QtyBtn extends StatelessWidget {
  const _QtyBtn({required this.icon, required this.onTap});
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: 28,
          height: 28,
          decoration: BoxDecoration(
            color: AppColors.buyerBlue.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(AppSpacing.radiusSm),
          ),
          child: Icon(icon, size: 16, color: AppColors.buyerBlue),
        ),
      );
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value, this.bold = false});
  final String label, value;
  final bool bold;

  @override
  Widget build(BuildContext context) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: bold ? AppTextStyles.titleSmall : AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceVariant)),
          Text(value, style: bold ? AppTextStyles.titleMedium.copyWith(color: AppColors.buyerBlue) : AppTextStyles.bodyMedium),
        ],
      );
}
