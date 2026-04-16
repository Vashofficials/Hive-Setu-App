import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/app_header.dart';
import '../../../core/widgets/app_button.dart';

class MigrationScreen extends StatelessWidget {
  const MigrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeader(title: 'Migration Planning', subtitle: 'प्रवास योजना'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Current Location Card
            _InfoCard(
              icon: '📍',
              title: 'Current Location',
              value: 'Muzaffarnagar, UP',
              subtitle: 'Since: 1 Mar 2026 • 45 days',
              color: AppColors.secondary,
            ),
            const SizedBox(height: AppSpacing.md),
            _InfoCard(
              icon: '🌼',
              title: 'Next Recommended Crop',
              value: 'Mustard (Sarso)',
              subtitle: 'Punjab region — Best window: 20–30 Apr',
              color: AppColors.primary,
            ),
            const SizedBox(height: AppSpacing.xl),
            Text('Migration History', style: AppTextStyles.sectionTitle),
            const SizedBox(height: AppSpacing.md),
            ..._history.map((h) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.md),
                  child: _HistoryTile(entry: h),
                )),
            const SizedBox(height: AppSpacing.xl),
            AppButton(label: '+ Plan New Migration', onPressed: () {}, width: double.infinity),
          ],
        ),
      ),
    );
  }

  static const _history = [
    _MigEntry(from: 'Almora, UK', to: 'Muzaffarnagar, UP', crop: 'Eucalyptus', date: 'Mar 2026', hives: 24),
    _MigEntry(from: 'Jaipur, RJ', to: 'Almora, UK', crop: 'Litchi', date: 'Nov 2025', hives: 22),
  ];
}

class _MigEntry {
  const _MigEntry({required this.from, required this.to, required this.crop, required this.date, required this.hives});
  final String from, to, crop, date;
  final int hives;
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.icon, required this.title, required this.value, required this.subtitle, required this.color});
  final String icon, title, value, subtitle;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          boxShadow: color == AppColors.primary ? AppColors.amberShadow : AppColors.ambientShadow,
        ),
        child: Row(
          children: [
            Text(icon, style: const TextStyle(fontSize: 32)),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
                  Text(value, style: AppTextStyles.titleMedium.copyWith(color: color)),
                  Text(subtitle, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
                ],
              ),
            ),
          ],
        ),
      );
}

class _HistoryTile extends StatelessWidget {
  const _HistoryTile({required this.entry});
  final _MigEntry entry;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          boxShadow: AppColors.ambientShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text('🚛', style: const TextStyle(fontSize: 20)),
                const SizedBox(width: AppSpacing.sm),
                Expanded(child: Text('${entry.from} → ${entry.to}', style: AppTextStyles.titleSmall)),
                Text(entry.date, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
              ],
            ),
            const SizedBox(height: AppSpacing.xs),
            Text('Crop: ${entry.crop} • ${entry.hives} hives', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
          ],
        ),
      );
}
