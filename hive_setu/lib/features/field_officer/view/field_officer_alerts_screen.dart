import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/router/app_router.dart';
import '../../../core/widgets/app_header.dart';

class FieldOfficerAlertsScreen extends StatelessWidget {
  const FieldOfficerAlertsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(
        title: 'District Alerts',
        subtitle: 'जिला अधिकारी',
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(color: AppColors.error.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(AppSpacing.radiusFull)),
            child: Text('Gov Admin', style: AppTextStyles.labelMedium.copyWith(color: AppColors.error, fontWeight: FontWeight.w700)),
          ),
          const SizedBox(width: AppSpacing.md),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
        children: [
          Row(
            children: [
              Expanded(child: Text('High Priority Issues', style: AppTextStyles.sectionTitle)),
              IconButton(onPressed: () => context.push(AppRoutes.districtMap), icon: const Icon(Icons.map_rounded, color: AppColors.error)),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          _DistrictAlertCard(title: 'Disease Outbreak Risk', region: 'North Muzaffarnagar', details: 'Varroa incidence > 15% in 3 local FPOs. Immediate inspection recommended.', metric: '15.2%', metricColor: AppColors.error),
          const SizedBox(height: AppSpacing.md),
          _DistrictAlertCard(title: 'Pesticide Application Expected', region: 'Shamli Border', details: 'Sugarcane spraying scheduled. Issue hive closure warning.', metric: 'High Risk', metricColor: AppColors.amberAlert),
          const SizedBox(height: AppSpacing.xl),
          Row(
            children: [
              Expanded(child: Text('Subsidies & Applications', style: AppTextStyles.sectionTitle)),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          _DistrictAlertCard(title: 'New Subsidy Claims', region: 'District wide', details: '42 pending NBHM subsidy verifications required.', metric: '42', metricColor: AppColors.govtTeal),
        ],
      ),
    );
  }
}

class _DistrictAlertCard extends StatelessWidget {
  const _DistrictAlertCard({required this.title, required this.region, required this.details, required this.metric, required this.metricColor});
  final String title, region, details, metric;
  final Color metricColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(AppSpacing.cardRadius), border: Border.all(color: AppColors.outlineVariant, width: 1.5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(color: AppColors.onSurfaceVariant.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(AppSpacing.radiusFull)),
                child: Row(children: [const Icon(Icons.location_on_rounded, size: 12), const SizedBox(width: 4), Text(region, style: AppTextStyles.labelSmall)]),
              ),
              Text(metric, style: AppTextStyles.titleMedium.copyWith(color: metricColor)),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(title, style: AppTextStyles.titleMedium),
          const SizedBox(height: 4),
          Text(details, style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceVariant)),
        ],
      ),
    );
  }
}


