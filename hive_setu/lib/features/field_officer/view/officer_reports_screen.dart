import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_header.dart';

class OfficerReportsScreen extends StatelessWidget {
  const OfficerReportsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(title: 'Reports & Analytics', subtitle: 'रिपोर्ट और विश्लेषण'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Overview Stats
          Row(children: const [
            Expanded(child: _KpiCard(emoji: '🐝', value: '1,248', label: 'Beekeepers', change: '+8%', isUp: true)),
            SizedBox(width: AppSpacing.md),
            Expanded(child: _KpiCard(emoji: '🍯', value: '48T', label: 'Annual Yield', change: '+15%', isUp: true)),
          ]),
          const SizedBox(height: AppSpacing.md),
          Row(children: const [
            Expanded(child: _KpiCard(emoji: '🏛️', value: '24', label: 'FPOs Active', change: '+3', isUp: true)),
            SizedBox(width: AppSpacing.md),
            Expanded(child: _KpiCard(emoji: '⚠️', value: '14', label: 'Open Incidents', change: '-5', isUp: false)),
          ]),
          const SizedBox(height: AppSpacing.xl),

          // Disease Trends
          Text('Disease Trends', style: AppTextStyles.sectionTitle),
          const SizedBox(height: AppSpacing.xs),
          Text('रोग प्रवृत्ति', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppSpacing.cardRadius), boxShadow: AppColors.ambientShadow),
            child: Column(children: [
              _TrendRow(disease: 'Varroa Mite', cases: 42, trend: 'Rising', color: AppColors.error),
              _TrendRow(disease: 'Wax Moth', cases: 18, trend: 'Stable', color: AppColors.primary),
              _TrendRow(disease: 'Nosema', cases: 7, trend: 'Declining', color: AppColors.secondary),
              _TrendRow(disease: 'Colony Collapse', cases: 3, trend: 'Declining', color: AppColors.secondary),
              _TrendRow(disease: 'Pesticide Exposure', cases: 11, trend: 'Rising', color: AppColors.error),
            ]),
          ),
          const SizedBox(height: AppSpacing.xl),

          // Scheme Coverage
          Text('Scheme Coverage', style: AppTextStyles.sectionTitle),
          const SizedBox(height: AppSpacing.xs),
          Text('योजना कवरेज', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
          const SizedBox(height: AppSpacing.md),
          _SchemeBar(name: 'NBHM', enrolled: 840, target: 1000, color: AppColors.govtTeal),
          _SchemeBar(name: 'PMEGP', enrolled: 280, target: 500, color: AppColors.buyerBlue),
          _SchemeBar(name: 'State Scheme', enrolled: 128, target: 200, color: AppColors.fpoPurple),
          const SizedBox(height: AppSpacing.xl),

          // District Heatmap placeholder
          Text('District Heatmap', style: AppTextStyles.sectionTitle),
          const SizedBox(height: AppSpacing.md),
          Container(
            height: 180,
            decoration: BoxDecoration(color: AppColors.govtTeal.withValues(alpha: 0.06), borderRadius: BorderRadius.circular(AppSpacing.cardRadius)),
            child: Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
              const Icon(Icons.map_rounded, size: 40, color: AppColors.govtTeal),
              const SizedBox(height: AppSpacing.sm),
              Text('Colony Distribution Heatmap', style: AppTextStyles.titleSmall.copyWith(color: AppColors.govtTeal)),
              Text('Western UP Region', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
            ])),
          ),
          const SizedBox(height: AppSpacing.xl),

          // Export
          Text('Export & Share', style: AppTextStyles.sectionTitle),
          const SizedBox(height: AppSpacing.md),
          Row(children: [
            Expanded(child: AppButton(label: '📄 PDF Report', onPressed: () {}, width: double.infinity)),
            const SizedBox(width: AppSpacing.md),
            Expanded(child: AppButton(label: '📊 Excel Data', onPressed: () {}, width: double.infinity)),
          ]),
          const SizedBox(height: AppSpacing.md),
          AppButton(label: '📧 Email to Department', onPressed: () {}, width: double.infinity),
          const SizedBox(height: AppSpacing.massive),
        ]),
      ),
    );
  }
}

class _KpiCard extends StatelessWidget {
  const _KpiCard({required this.emoji, required this.value, required this.label, required this.change, required this.isUp});
  final String emoji, value, label, change;
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

class _TrendRow extends StatelessWidget {
  const _TrendRow({required this.disease, required this.cases, required this.trend, required this.color});
  final String disease, trend;
  final int cases;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(children: [
        Expanded(child: Text(disease, style: AppTextStyles.bodyMedium)),
        Text('$cases cases', style: AppTextStyles.labelMedium.copyWith(color: AppColors.onSurfaceVariant)),
        const SizedBox(width: AppSpacing.md),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 2),
          decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(AppSpacing.radiusFull)),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Icon(trend == 'Rising' ? Icons.trending_up_rounded : trend == 'Declining' ? Icons.trending_down_rounded : Icons.trending_flat_rounded, size: 14, color: color),
            const SizedBox(width: 2),
            Text(trend, style: AppTextStyles.labelSmall.copyWith(color: color)),
          ]),
        ),
      ]),
    );
  }
}

class _SchemeBar extends StatelessWidget {
  const _SchemeBar({required this.name, required this.enrolled, required this.target, required this.color});
  final String name;
  final int enrolled, target;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final progress = enrolled / target;
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppSpacing.radiusMd), boxShadow: AppColors.ambientShadow),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(name, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.w700)),
            Text('$enrolled / $target', style: AppTextStyles.labelMedium.copyWith(color: color)),
          ]),
          const SizedBox(height: AppSpacing.sm),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(value: progress, backgroundColor: color.withValues(alpha: 0.1), valueColor: AlwaysStoppedAnimation(color), minHeight: 6),
          ),
        ]),
      ),
    );
  }
}
