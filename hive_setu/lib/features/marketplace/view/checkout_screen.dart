import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_header.dart';
import '../../../core/widgets/app_input.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeader(title: 'Checkout', showBackButton: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Order Summary
            Text('Order Summary', style: AppTextStyles.sectionTitle),
            const SizedBox(height: AppSpacing.sm),
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(AppSpacing.cardRadius), border: Border.all(color: AppColors.outlineVariant)),
              child: Column(
                children: [
                  _SummaryRow(label: 'Wild Forest Honey (1kg)', value: '₹650'),
                  _SummaryRow(label: 'Shipping', value: '₹50'),
                  const Divider(color: AppColors.outlineVariant, height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total', style: AppTextStyles.titleMedium),
                      Text('₹700', style: AppTextStyles.titleMedium.copyWith(color: AppColors.buyerBlue)),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            // Shipping Address
            Text('Shipping Details', style: AppTextStyles.sectionTitle),
            const SizedBox(height: AppSpacing.sm),
            AppInput(label: 'Full Name', controller: TextEditingController(text: 'John Doe')),
            const SizedBox(height: AppSpacing.md),
            AppInput(label: 'Address', controller: TextEditingController(), maxLines: 3),
            const SizedBox(height: AppSpacing.md),
            AppInput(label: 'Pincode', controller: TextEditingController(), keyboardType: TextInputType.number),
            const SizedBox(height: AppSpacing.xxl),
            // Payment Button
            AppButton(
              label: 'Proceed to Pay ₹700',
              width: double.infinity,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value});
  final String label, value;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.xs),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceVariant)),
            Text(value, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
          ],
        ),
      );
}
