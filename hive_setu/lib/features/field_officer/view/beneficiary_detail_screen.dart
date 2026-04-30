import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/app_header.dart';

class BeneficiaryDetailScreen extends StatelessWidget {
  const BeneficiaryDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(title: 'Beneficiary Detail', subtitle: 'लाभार्थी विवरण'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Profile header
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppSpacing.cardRadius), boxShadow: AppColors.ambientShadow),
            child: Row(children: [
              CircleAvatar(radius: 32, backgroundColor: AppColors.govtTeal.withValues(alpha: 0.1),
                child: Text('RK', style: AppTextStyles.titleMedium.copyWith(color: AppColors.govtTeal, fontWeight: FontWeight.w700))),
              const SizedBox(width: AppSpacing.lg),
              Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Text('Ramesh Kumar', style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(width: 4),
                  const Icon(Icons.verified_rounded, size: 16, color: AppColors.govtTeal),
                ]),
                Text('Shamli, Uttar Pradesh', style: AppTextStyles.bodySmall.copyWith(color: AppColors.onSurfaceVariant)),
                const SizedBox(height: AppSpacing.xs),
                Row(children: [
                  _Tag(label: 'NBHM', color: AppColors.govtTeal),
                  const SizedBox(width: AppSpacing.xs),
                  _Tag(label: 'Active', color: AppColors.secondary),
                ]),
              ])),
            ]),
          ),
          const SizedBox(height: AppSpacing.lg),
          // Stats
          Row(children: const [
            Expanded(child: _StatBox(emoji: '🐝', value: '24', label: 'Hives')),
            SizedBox(width: AppSpacing.sm),
            Expanded(child: _StatBox(emoji: '🍯', value: '380 kg', label: 'Annual Yield')),
            SizedBox(width: AppSpacing.sm),
            Expanded(child: _StatBox(emoji: '📈', value: '₹1.2L', label: 'Income')),
          ]),
          const SizedBox(height: AppSpacing.xl),
          // Scheme Details
          Text('Scheme Details', style: AppTextStyles.sectionTitle),
          const SizedBox(height: AppSpacing.md),
          _InfoCard(items: const [
            _InfoItem(label: 'Scheme', value: 'National Beekeeping & Honey Mission', icon: Icons.policy_rounded),
            _InfoItem(label: 'Beneficiary ID', value: 'NBHM-UP-2023-04521', icon: Icons.badge_rounded),
            _InfoItem(label: 'Enrolled', value: 'March 15, 2023', icon: Icons.calendar_today_rounded),
            _InfoItem(label: 'Subsidy Received', value: '₹45,000 / ₹80,000', icon: Icons.payments_rounded),
            _InfoItem(label: 'Documentation', value: 'Complete ✓', icon: Icons.folder_rounded),
          ]),
          const SizedBox(height: AppSpacing.xl),
          // Colony Details
          Text('Colony Information', style: AppTextStyles.sectionTitle),
          const SizedBox(height: AppSpacing.md),
          _InfoCard(items: const [
            _InfoItem(label: 'Bee Species', value: 'Apis mellifera', icon: Icons.pets_rounded),
            _InfoItem(label: 'Avg. Colony Strength', value: '8 frames / hive', icon: Icons.analytics_rounded),
            _InfoItem(label: 'Last Inspection', value: 'April 20, 2026', icon: Icons.search_rounded),
            _InfoItem(label: 'Health Status', value: 'Good — No active issues', icon: Icons.health_and_safety_rounded),
          ]),
          const SizedBox(height: AppSpacing.xl),
          // Training
          Text('Training History', style: AppTextStyles.sectionTitle),
          const SizedBox(height: AppSpacing.md),
          _TrainingTile(title: 'NBHM Basic Beekeeping', date: 'Jan 2023', status: 'Completed'),
          _TrainingTile(title: 'Queen Rearing Techniques', date: 'Jun 2023', status: 'Completed'),
          _TrainingTile(title: 'Organic Honey Processing', date: 'Nov 2023', status: 'Completed'),
          _TrainingTile(title: 'Advanced Apiculture', date: 'May 2026', status: 'Upcoming'),
          const SizedBox(height: AppSpacing.massive),
        ]),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 2),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(AppSpacing.radiusFull)),
      child: Text(label, style: AppTextStyles.labelSmall.copyWith(color: color, fontWeight: FontWeight.w700)),
    );
  }
}

class _StatBox extends StatelessWidget {
  const _StatBox({required this.emoji, required this.value, required this.label});
  final String emoji, value, label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppSpacing.radiusMd), boxShadow: AppColors.ambientShadow),
      child: Column(children: [
        Text(emoji, style: const TextStyle(fontSize: 20)),
        Text(value, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.w700)),
        Text(label, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
      ]),
    );
  }
}

class _InfoItem {
  const _InfoItem({required this.label, required this.value, required this.icon});
  final String label, value;
  final IconData icon;
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.items});
  final List<_InfoItem> items;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppSpacing.cardRadius), boxShadow: AppColors.ambientShadow),
      child: Column(children: items.map((item) => Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.md),
        child: Row(children: [
          Container(width: 36, height: 36, decoration: BoxDecoration(color: AppColors.govtTeal.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(AppSpacing.radiusMd)),
            child: Icon(item.icon, color: AppColors.govtTeal, size: 18)),
          const SizedBox(width: AppSpacing.md),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(item.label, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
            Text(item.value, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w500)),
          ])),
        ]),
      )).toList()),
    );
  }
}

class _TrainingTile extends StatelessWidget {
  const _TrainingTile({required this.title, required this.date, required this.status});
  final String title, date, status;

  @override
  Widget build(BuildContext context) {
    final isDone = status == 'Completed';
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppSpacing.radiusMd), boxShadow: AppColors.ambientShadow),
        child: Row(children: [
          Icon(isDone ? Icons.check_circle_rounded : Icons.schedule_rounded, color: isDone ? AppColors.secondary : AppColors.primary, size: 20),
          const SizedBox(width: AppSpacing.md),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.w600)),
            Text(date, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
          ])),
          _Tag(label: status, color: isDone ? AppColors.secondary : AppColors.primary),
        ]),
      ),
    );
  }
}
