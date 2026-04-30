import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_header.dart';

class ReportsCenterScreen extends StatelessWidget {
  const ReportsCenterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(title: 'Reports Center', subtitle: 'रिपोर्ट केंद्र'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Period selector
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppSpacing.radiusMd), boxShadow: AppColors.ambientShadow),
            child: Row(children: [
              const Icon(Icons.date_range_rounded, color: AppColors.fpoPurple, size: 20),
              const SizedBox(width: AppSpacing.sm),
              Text('April 2026', style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.w700)),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 4),
                decoration: BoxDecoration(color: AppColors.fpoPurple.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(AppSpacing.radiusFull)),
                child: Text('Change', style: AppTextStyles.labelSmall.copyWith(color: AppColors.fpoPurple)),
              ),
            ]),
          ),
          const SizedBox(height: AppSpacing.xl),
          // Summary Stats
          Row(children: const [
            Expanded(child: _ReportStat(label: 'Total Harvest', value: '1,240 kg', emoji: '🍯', change: '+18%', isUp: true)),
            SizedBox(width: AppSpacing.md),
            Expanded(child: _ReportStat(label: 'Revenue', value: '₹4.2L', emoji: '💰', change: '+24%', isUp: true)),
          ]),
          const SizedBox(height: AppSpacing.md),
          Row(children: const [
            Expanded(child: _ReportStat(label: 'Members', value: '482', emoji: '👥', change: '+12', isUp: true)),
            SizedBox(width: AppSpacing.md),
            Expanded(child: _ReportStat(label: 'Incidents', value: '7', emoji: '⚠️', change: '-3', isUp: false)),
          ]),
          const SizedBox(height: AppSpacing.xl),
          // Report Cards
          Text('Available Reports', style: AppTextStyles.sectionTitle),
          const SizedBox(height: AppSpacing.md),
          _ReportCard(title: 'Harvest Report', subtitle: 'Member-wise harvest, yield, grade breakdown', icon: Icons.inventory_2_rounded, color: AppColors.primary),
          _ReportCard(title: 'Income & Payments', subtitle: 'Revenue, payments disbursed, pending dues', icon: Icons.payments_rounded, color: AppColors.secondary),
          _ReportCard(title: 'Member Activity', subtitle: 'Active/inactive members, training status', icon: Icons.people_rounded, color: AppColors.fpoPurple),
          _ReportCard(title: 'Disease & Incidents', subtitle: 'Health alerts, treatments, mortality data', icon: Icons.health_and_safety_rounded, color: AppColors.error),
          _ReportCard(title: 'Marketplace Performance', subtitle: 'Listings, orders, buyer engagement', icon: Icons.store_rounded, color: AppColors.buyerBlue),
          const SizedBox(height: AppSpacing.xl),
          // Export buttons
          Text('Export Options', style: AppTextStyles.sectionTitle),
          const SizedBox(height: AppSpacing.md),
          Row(children: [
            Expanded(child: AppButton(label: '📄 Export PDF', onPressed: () {}, width: double.infinity)),
            const SizedBox(width: AppSpacing.md),
            Expanded(child: AppButton(label: '📊 Export Excel', onPressed: () {}, width: double.infinity)),
          ]),
          const SizedBox(height: AppSpacing.massive),
        ]),
      ),
    );
  }
}

class _ReportStat extends StatelessWidget {
  const _ReportStat({required this.label, required this.value, required this.emoji, required this.change, required this.isUp});
  final String label, value, emoji, change;
  final bool isUp;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppSpacing.cardRadius), boxShadow: AppColors.ambientShadow),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(emoji, style: const TextStyle(fontSize: 20)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs, vertical: 1),
            decoration: BoxDecoration(color: (isUp ? AppColors.secondary : AppColors.error).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(AppSpacing.radiusFull)),
            child: Text(change, style: AppTextStyles.labelSmall.copyWith(color: isUp ? AppColors.secondary : AppColors.error, fontWeight: FontWeight.w700)),
          ),
        ]),
        const SizedBox(height: AppSpacing.sm),
        Text(value, style: AppTextStyles.titleLarge.copyWith(fontWeight: FontWeight.w700)),
        Text(label, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
      ]),
    );
  }
}

class _ReportCard extends StatelessWidget {
  const _ReportCard({required this.title, required this.subtitle, required this.icon, required this.color});
  final String title, subtitle;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppSpacing.cardRadius), boxShadow: AppColors.ambientShadow),
        child: Row(children: [
          Container(width: 44, height: 44, decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(AppSpacing.radiusMd)),
            child: Icon(icon, color: color, size: 22)),
          const SizedBox(width: AppSpacing.md),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.w700)),
            Text(subtitle, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
          ])),
          const Icon(Icons.chevron_right_rounded, color: AppColors.onSurfaceVariant),
        ]),
      ),
    );
  }
}
