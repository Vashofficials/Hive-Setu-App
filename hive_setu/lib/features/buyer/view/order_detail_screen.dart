import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_header.dart';

class OrderDetailScreen extends StatelessWidget {
  const OrderDetailScreen({super.key, required this.orderId});
  final String orderId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(title: orderId, subtitle: 'Order Detail'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStatusTimeline(),
            const SizedBox(height: AppSpacing.xl),
            Text('Order Items', style: AppTextStyles.sectionTitle),
            const SizedBox(height: AppSpacing.md),
            _buildOrderItem('🍯', 'Wild Forest Honey', '2 kg', '₹1,300', 'Sundarbans FPO'),
            const SizedBox(height: AppSpacing.xl),
            Text('Delivery Details', style: AppTextStyles.sectionTitle),
            const SizedBox(height: AppSpacing.md),
            _buildDeliveryInfo(),
            const SizedBox(height: AppSpacing.xl),
            Text('Payment Summary', style: AppTextStyles.sectionTitle),
            const SizedBox(height: AppSpacing.md),
            _buildPaymentSummary(),
            const SizedBox(height: AppSpacing.xl),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    label: 'Download Invoice',
                    variant: AppButtonVariant.nest,
                    icon: const Icon(Icons.download_rounded, color: AppColors.primary, size: 18),
                    onPressed: () {},
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: AppButton(
                    label: 'Track Order',
                    icon: const Icon(Icons.local_shipping_outlined, color: AppColors.white, size: 18),
                    onPressed: () {},
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusTimeline() {
    const steps = [
      _Step(title: 'Order Placed', subtitle: '07 Apr • 10:24 AM', done: true),
      _Step(title: 'Confirmed by FPO', subtitle: '07 Apr • 02:15 PM', done: true),
      _Step(title: 'Shipped', subtitle: '08 Apr • 09:00 AM', done: true),
      _Step(title: 'Out for Delivery', subtitle: 'Expected: 11 Apr', done: false),
      _Step(title: 'Delivered', subtitle: 'Pending', done: false),
    ];

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        boxShadow: AppColors.ambientShadow,
      ),
      child: Column(
        children: steps.asMap().entries.map((entry) {
          final i = entry.key;
          final step = entry.value;
          final isLast = i == steps.length - 1;
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Container(
                    width: 24,
                    height: 24,
                    decoration: BoxDecoration(
                      color: step.done ? AppColors.buyerBlue : AppColors.surfaceVariant,
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      step.done ? Icons.check_rounded : Icons.circle,
                      size: step.done ? 14 : 8,
                      color: step.done ? AppColors.white : AppColors.onSurfaceVariant,
                    ),
                  ),
                  if (!isLast)
                    Container(
                      width: 2,
                      height: 32,
                      color: step.done ? AppColors.buyerBlue.withValues(alpha: 0.3) : AppColors.outlineVariant,
                    ),
                ],
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(step.title, style: AppTextStyles.titleSmall.copyWith(
                        color: step.done ? AppColors.onSurface : AppColors.onSurfaceVariant,
                      )),
                      Text(step.subtitle, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
                    ],
                  ),
                ),
              ),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildOrderItem(String emoji, String name, String qty, String price, String fpo) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        boxShadow: AppColors.ambientShadow,
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: AppColors.buyerBlue.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: Center(child: Text(emoji, style: const TextStyle(fontSize: 26))),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: AppTextStyles.titleSmall),
                Text('$fpo • $qty', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
              ],
            ),
          ),
          Text(price, style: AppTextStyles.titleSmall.copyWith(color: AppColors.buyerBlue, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }

  Widget _buildDeliveryInfo() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        boxShadow: AppColors.ambientShadow,
      ),
      child: Column(
        children: [
          _InfoRow(icon: Icons.person_outline_rounded, label: 'Name', value: 'Priya Sharma'),
          _InfoRow(icon: Icons.phone_outlined, label: 'Phone', value: '+91 9876543210'),
          _InfoRow(icon: Icons.location_on_outlined, label: 'Address', value: 'B-204, Shivaji Nagar, Mumbai - 400049'),
          _InfoRow(icon: Icons.local_shipping_outlined, label: 'Courier', value: 'Delhivery — DL4821099'),
        ],
      ),
    );
  }

  Widget _buildPaymentSummary() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        boxShadow: AppColors.ambientShadow,
      ),
      child: Column(
        children: [
          _PayRow(label: 'Product Total', value: '₹1,300'),
          _PayRow(label: 'Delivery', value: '₹120'),
          _PayRow(label: 'Discount', value: '-₹0'),
          const Divider(color: AppColors.outlineVariant, height: AppSpacing.lg),
          _PayRow(label: 'Grand Total', value: '₹1,420', bold: true),
          const SizedBox(height: AppSpacing.sm),
          _PayRow(label: 'Payment Method', value: 'UPI', color: AppColors.secondary),
          _PayRow(label: 'Payment Status', value: 'Paid', color: AppColors.secondary),
        ],
      ),
    );
  }
}

class _Step {
  const _Step({required this.title, required this.subtitle, required this.done});
  final String title, subtitle;
  final bool done;
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.icon, required this.label, required this.value});
  final IconData icon;
  final String label, value;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: AppSpacing.iconSm, color: AppColors.onSurfaceVariant),
            const SizedBox(width: AppSpacing.sm),
            SizedBox(width: 70, child: Text(label, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant))),
            Expanded(child: Text(value, style: AppTextStyles.bodySmall)),
          ],
        ),
      );
}

class _PayRow extends StatelessWidget {
  const _PayRow({required this.label, required this.value, this.bold = false, this.color});
  final String label, value;
  final bool bold;
  final Color? color;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.xs),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label, style: bold ? AppTextStyles.titleSmall : AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceVariant)),
            Text(value, style: (bold ? AppTextStyles.titleMedium : AppTextStyles.bodyMedium).copyWith(color: color ?? (bold ? AppColors.buyerBlue : AppColors.onSurface))),
          ],
        ),
      );
}
