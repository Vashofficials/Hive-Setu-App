import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/app_header.dart';

class FpoDashboardScreen extends StatelessWidget {
  const FpoDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(
        title: 'FPO Dashboard',
        subtitle: 'संगठन एडमिन',
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(color: AppColors.fpoPurple.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(AppSpacing.radiusFull)),
            child: Text('Admin', style: AppTextStyles.labelMedium.copyWith(color: AppColors.fpoPurple, fontWeight: FontWeight.w700)),
          ),
          const SizedBox(width: AppSpacing.md),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Stats Grid
            Row(
              children: const [
                Expanded(child: _StatCard(title: 'Active Members', value: '482', icon: '👥')),
                SizedBox(width: AppSpacing.md),
                Expanded(child: _StatCard(title: 'Pending Approvals', value: '14', icon: '⏳', isAlert: true)),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: const [
                Expanded(child: _StatCard(title: 'Total Yield (Month)', value: '1,240 kg', icon: '🍯')),
                SizedBox(width: AppSpacing.md),
                Expanded(child: _StatCard(title: 'Revenue (Month)', value: '₹4.2L', icon: '📈')),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            Text('Recent Activity', style: AppTextStyles.sectionTitle),
            const SizedBox(height: AppSpacing.md),
            _ActivityRow(title: 'Ramesh added 20 kg Mustard Honey', time: '2 hrs ago', icon: Icons.inventory_2_rounded, color: AppColors.primary),
            _ActivityRow(title: 'New Member application: Suresh K.', time: '5 hrs ago', icon: Icons.person_add_rounded, color: AppColors.fpoPurple),
            _ActivityRow(title: 'Advisory: Monsoon preparation sent', time: '1 day ago', icon: Icons.campaign_rounded, color: AppColors.govtTeal),
          ],
        ),
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.title, required this.value, required this.icon, this.isAlert = false});
  final String title, value, icon;
  final bool isAlert;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        border: Border.all(color: isAlert ? AppColors.error.withValues(alpha: 0.3) : AppColors.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(icon, style: const TextStyle(fontSize: 24)),
              if (isAlert) Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.error, shape: BoxShape.circle)),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(value, style: AppTextStyles.titleLarge.copyWith(color: isAlert ? AppColors.error : AppColors.onSurface)),
          Text(title, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
        ],
      ),
    );
  }
}

class _ActivityRow extends StatelessWidget {
  const _ActivityRow({required this.title, required this.time, required this.icon, required this.color});
  final String title, time;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.md),
        child: Row(
          children: [
            Container(
              width: 40, height: 40,
              decoration: BoxDecoration(color: color.withValues(alpha: 0.1), shape: BoxShape.circle),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.bodyMedium),
                  Text(time, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
                ],
              ),
            ),
          ],
        ),
      );
}
