import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/app_header.dart';

class AlertScreen extends StatelessWidget {
  const AlertScreen({super.key});

  static const _alerts = [
    _Alert(title: 'Varroa Mite Detected', hive: 'Hive H-03', severity: 'High', time: '2 hrs ago', emoji: '🦠'),
    _Alert(title: 'Low Honey Stores', hive: 'Hive H-07', severity: 'Medium', time: '1 day ago', emoji: '🍯'),
    _Alert(title: 'Queen Activity Weak', hive: 'Hive H-05', severity: 'High', time: '3 days ago', emoji: '👑'),
    _Alert(title: 'Pesticide Risk Nearby', hive: 'All Hives', severity: 'Medium', time: '5 days ago', emoji: '⚠️'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(
        title: 'Alerts & Companion',
        subtitle: 'सतर्कता केंद्र',
        badge: '${_alerts.where((a) => a.severity == 'High').length}',
        badgeColor: AppColors.error,
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
        itemCount: _alerts.length,
        separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
        itemBuilder: (context, i) => _AlertCard(alert: _alerts[i]),
      ),
    );
  }
}

class _Alert {
  const _Alert({required this.title, required this.hive, required this.severity, required this.time, required this.emoji});
  final String title, hive, severity, time, emoji;
}

class _AlertCard extends StatelessWidget {
  const _AlertCard({required this.alert});
  final _Alert alert;

  @override
  Widget build(BuildContext context) {
    final isHigh = alert.severity == 'High';
    final color = isHigh ? AppColors.error : AppColors.amberAlert;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        boxShadow: isHigh 
            ? [BoxShadow(color: AppColors.error.withValues(alpha: 0.1), blurRadius: 10, spreadRadius: 1)]
            : AppColors.ambientShadow,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(AppSpacing.radiusMd)),
            child: Center(child: Text(alert.emoji, style: const TextStyle(fontSize: 22))),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(child: Text(alert.title, style: AppTextStyles.titleSmall)),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(AppSpacing.radiusFull)),
                      child: Text(alert.severity, style: AppTextStyles.labelSmall.copyWith(color: color, fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(alert.hive, style: AppTextStyles.bodySmall.copyWith(color: AppColors.onSurface, fontWeight: FontWeight.w600)),
                Text(alert.time, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
