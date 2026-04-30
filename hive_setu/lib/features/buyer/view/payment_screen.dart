import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/router/app_router.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_header.dart';

class PaymentScreen extends StatefulWidget {
  const PaymentScreen({super.key});

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  String _selectedMethod = 'upi';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(title: 'Payment', subtitle: 'भुगतान'),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
              child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                // Order Summary Card
                Container(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppSpacing.cardRadius), boxShadow: AppColors.ambientShadow),
                  child: Column(children: [
                    _Row(label: 'Subtotal', value: '₹27,250'),
                    _Row(label: 'GST (5%)', value: '₹1,363'),
                    _Row(label: 'Shipping', value: '₹500'),
                    const Divider(height: AppSpacing.lg),
                    _Row(label: 'Total', value: '₹29,113', bold: true),
                  ]),
                ),
                const SizedBox(height: AppSpacing.xl),
                Text('Payment Method', style: AppTextStyles.sectionTitle),
                const SizedBox(height: AppSpacing.xs),
                Text('भुगतान का तरीका', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
                const SizedBox(height: AppSpacing.md),
                _MethodCard(icon: Icons.account_balance_wallet_rounded, label: 'UPI / GPay / PhonePe', value: 'upi', selected: _selectedMethod, onTap: (v) => setState(() => _selectedMethod = v)),
                _MethodCard(icon: Icons.account_balance_rounded, label: 'Net Banking / NEFT', value: 'bank', selected: _selectedMethod, onTap: (v) => setState(() => _selectedMethod = v)),
                _MethodCard(icon: Icons.credit_card_rounded, label: 'Credit / Debit Card', value: 'card', selected: _selectedMethod, onTap: (v) => setState(() => _selectedMethod = v)),
                _MethodCard(icon: Icons.local_shipping_rounded, label: 'Cash on Delivery', value: 'cod', selected: _selectedMethod, onTap: (v) => setState(() => _selectedMethod = v)),
              ]),
            ),
          ),
          // Pay Button
          Container(
            padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
            decoration: BoxDecoration(color: AppColors.surface, boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 10, offset: const Offset(0, -4))]),
            child: SafeArea(
              child: AppButton(label: 'Pay ₹29,113', onPressed: () => context.push(AppRoutes.orderConfirmation), width: double.infinity),
            ),
          ),
        ],
      ),
    );
  }
}

class _Row extends StatelessWidget {
  const _Row({required this.label, required this.value, this.bold = false});
  final String label, value;
  final bool bold;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label, style: bold ? AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.w700) : AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceVariant)),
        Text(value, style: bold ? AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.w700, color: AppColors.primary) : AppTextStyles.bodyMedium),
      ]),
    );
  }
}

class _MethodCard extends StatelessWidget {
  const _MethodCard({required this.icon, required this.label, required this.value, required this.selected, required this.onTap});
  final IconData icon;
  final String label, value, selected;
  final ValueChanged<String> onTap;

  @override
  Widget build(BuildContext context) {
    final isActive = value == selected;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: GestureDetector(
        onTap: () => onTap(value),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(AppSpacing.lg),
          decoration: BoxDecoration(
            color: isActive ? AppColors.buyerBlue.withValues(alpha: 0.06) : AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            boxShadow: AppColors.ambientShadow,
          ),
          child: Row(children: [
            Container(width: 40, height: 40, decoration: BoxDecoration(color: (isActive ? AppColors.buyerBlue : AppColors.onSurfaceVariant).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(AppSpacing.radiusMd)),
              child: Icon(icon, color: isActive ? AppColors.buyerBlue : AppColors.onSurfaceVariant, size: 20)),
            const SizedBox(width: AppSpacing.md),
            Expanded(child: Text(label, style: AppTextStyles.titleSmall.copyWith(fontWeight: isActive ? FontWeight.w700 : FontWeight.w500, color: isActive ? AppColors.buyerBlue : AppColors.onSurface))),
            Container(width: 22, height: 22, decoration: BoxDecoration(shape: BoxShape.circle, color: isActive ? AppColors.buyerBlue : AppColors.surfaceVariant),
              child: isActive ? const Icon(Icons.check_rounded, color: AppColors.white, size: 14) : null),
          ]),
        ),
      ),
    );
  }
}
