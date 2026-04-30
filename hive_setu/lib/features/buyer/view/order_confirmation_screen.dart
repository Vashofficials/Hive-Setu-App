import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/router/app_router.dart';
import '../../../core/widgets/app_button.dart';

class OrderConfirmationScreen extends StatelessWidget {
  const OrderConfirmationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
          child: Column(
            children: [
              const Spacer(flex: 2),
              Container(
                width: 100, height: 100,
                decoration: BoxDecoration(color: AppColors.secondary.withValues(alpha: 0.1), shape: BoxShape.circle),
                child: const Icon(Icons.check_circle_rounded, color: AppColors.secondary, size: 64),
              ),
              const SizedBox(height: AppSpacing.xxl),
              Text('Order Placed! 🎉', style: AppTextStyles.headlineMedium.copyWith(color: AppColors.onSurface)),
              const SizedBox(height: AppSpacing.sm),
              Text('ऑर्डर सफलतापूर्वक दिया गया', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceVariant)),
              const SizedBox(height: AppSpacing.xxxl),
              Container(
                padding: const EdgeInsets.all(AppSpacing.lg),
                decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppSpacing.cardRadius), boxShadow: AppColors.ambientShadow),
                child: Column(children: [
                  _DetailRow(label: 'Order ID', value: '#ORD-2853'),
                  _DetailRow(label: 'Amount Paid', value: '₹29,113'),
                  _DetailRow(label: 'Payment', value: 'UPI'),
                  _DetailRow(label: 'Est. Delivery', value: 'May 5–8, 2026'),
                  _DetailRow(label: 'Ship To', value: 'New Delhi 110001'),
                ]),
              ),
              const SizedBox(height: AppSpacing.lg),
              Container(
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(color: AppColors.secondary.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(AppSpacing.radiusMd)),
                child: Row(children: [
                  const Icon(Icons.local_shipping_rounded, color: AppColors.secondary, size: 20),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(child: Text('You will receive tracking details via SMS & WhatsApp', style: AppTextStyles.bodySmall.copyWith(color: AppColors.secondary))),
                ]),
              ),
              const Spacer(flex: 3),
              AppButton(label: 'View My Orders', onPressed: () => context.go(AppRoutes.ordersList), width: double.infinity),
              const SizedBox(height: AppSpacing.md),
              TextButton(
                onPressed: () => context.go(AppRoutes.buyerDashboard),
                child: Text('Back to Dashboard', style: AppTextStyles.labelLarge.copyWith(color: AppColors.onSurfaceVariant)),
              ),
              const SizedBox(height: AppSpacing.xxl),
            ],
          ),
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});
  final String label, value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label, style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceVariant)),
        Text(value, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.w600)),
      ]),
    );
  }
}
