import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/router/app_router.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_header.dart';

class HarvestLogScreen extends StatelessWidget {
  const HarvestLogScreen({super.key});

  static const _logs = [
    _Log(location: 'Sundarbans Forest Block A', date: '12 Apr 2026', qty: '18 kg', status: 'Submitted', tree: 'Sundari'),
    _Log(location: 'Kaziranga Buffer Zone', date: '08 Apr 2026', qty: '22 kg', status: 'Pending', tree: 'Jamun'),
    _Log(location: 'Simlipal Forest', date: '02 Apr 2026', qty: '15 kg', status: 'Approved', tree: 'Mahua'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeader(title: 'Harvest Log', subtitle: 'जंगली शहद संग्रह — HC1'),
      body: ListView.separated(
        padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
        itemCount: _logs.length,
        separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
        itemBuilder: (_, i) => _LogCard(log: _logs[i]),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutes.geotagCamera),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        icon: const Icon(Icons.add_location_alt_rounded),
        label: const Text('New Harvest'),
      ),
    );
  }
}

class _Log {
  const _Log({required this.location, required this.date, required this.qty, required this.status, required this.tree});
  final String location, date, qty, status, tree;
}

class _LogCard extends StatelessWidget {
  const _LogCard({required this.log});
  final _Log log;

  @override
  Widget build(BuildContext context) {
    final statusColor = log.status == 'Approved' ? AppColors.secondary : log.status == 'Submitted' ? AppColors.govtTeal : AppColors.amberAlert;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(AppSpacing.cardRadius), border: Border.all(color: AppColors.outlineVariant)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Text(log.location, style: AppTextStyles.titleSmall)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(AppSpacing.radiusFull)),
                child: Text(log.status, style: AppTextStyles.labelSmall.copyWith(color: statusColor, fontWeight: FontWeight.w700)),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            children: [
              Text('🍯 ${log.qty}', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.primary, fontWeight: FontWeight.w600)),
              const SizedBox(width: AppSpacing.md),
              Text('🌳 ${log.tree}', style: AppTextStyles.bodySmall.copyWith(color: AppColors.onSurfaceVariant)),
              const Spacer(),
              Text(log.date, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
            ],
          ),
        ],
      ),
    );
  }
}
