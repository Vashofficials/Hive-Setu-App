import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/router/app_router.dart';
import '../../../core/widgets/app_header.dart';

class SchemeBeneficiaryListScreen extends StatefulWidget {
  const SchemeBeneficiaryListScreen({super.key});

  @override
  State<SchemeBeneficiaryListScreen> createState() => _SchemeBeneficiaryListScreenState();
}

class _SchemeBeneficiaryListScreenState extends State<SchemeBeneficiaryListScreen> {
  String _filter = 'All';
  static const _filters = ['All', 'NBHM', 'PMEGP', 'State Scheme'];

  static final _beneficiaries = [
    _Beneficiary(name: 'Ramesh Kumar', village: 'Shamli', scheme: 'NBHM', status: 'Active', hives: 24, verified: true),
    _Beneficiary(name: 'Suresh Patel', village: 'Saharanpur', scheme: 'PMEGP', status: 'Active', hives: 18, verified: true),
    _Beneficiary(name: 'Vikram Singh', village: 'Meerut', scheme: 'NBHM', status: 'Pending', hives: 12, verified: false),
    _Beneficiary(name: 'Amit Rana', village: 'Bijnor', scheme: 'State Scheme', status: 'Active', hives: 30, verified: true),
    _Beneficiary(name: 'Deepak Tyagi', village: 'Muzaffarnagar', scheme: 'NBHM', status: 'Expired', hives: 8, verified: true),
    _Beneficiary(name: 'Pradeep Malik', village: 'Moradabad', scheme: 'PMEGP', status: 'Active', hives: 15, verified: false),
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _filter == 'All' ? _beneficiaries : _beneficiaries.where((b) => b.scheme == _filter).toList();
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(title: 'Scheme Beneficiaries', subtitle: 'योजना लाभार्थी'),
      body: Column(children: [
        // Filter chips
        SizedBox(
          height: 48,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPaddingH),
            children: _filters.map((f) {
              final isActive = _filter == f;
              return Padding(
                padding: const EdgeInsets.only(right: AppSpacing.sm),
                child: GestureDetector(
                  onTap: () => setState(() => _filter = f),
                  child: Chip(
                    label: Text(f, style: AppTextStyles.labelSmall.copyWith(color: isActive ? AppColors.white : AppColors.onSurface)),
                    backgroundColor: isActive ? AppColors.govtTeal : AppColors.surface,
                    side: BorderSide.none,
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        // Count
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPaddingH, vertical: AppSpacing.sm),
          child: Row(children: [
            Text('${filtered.length} beneficiaries', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
          ]),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPaddingH),
            itemCount: filtered.length,
            separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
            itemBuilder: (_, i) => _BeneficiaryCard(
              b: filtered[i],
              onTap: () => context.push(AppRoutes.beneficiaryDetail),
            ),
          ),
        ),
      ]),
    );
  }
}

class _Beneficiary {
  const _Beneficiary({required this.name, required this.village, required this.scheme, required this.status, required this.hives, required this.verified});
  final String name, village, scheme, status;
  final int hives;
  final bool verified;
}

class _BeneficiaryCard extends StatelessWidget {
  const _BeneficiaryCard({required this.b, required this.onTap});
  final _Beneficiary b;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final statusColor = b.status == 'Active' ? AppColors.secondary : b.status == 'Pending' ? AppColors.primary : AppColors.onSurfaceVariant;
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppSpacing.cardRadius), boxShadow: AppColors.ambientShadow),
        child: Row(children: [
          CircleAvatar(
            radius: 22,
            backgroundColor: AppColors.govtTeal.withValues(alpha: 0.1),
            child: Text(b.name[0], style: AppTextStyles.titleMedium.copyWith(color: AppColors.govtTeal, fontWeight: FontWeight.w700)),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Row(children: [
              Text(b.name, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.w700)),
              if (b.verified) ...[const SizedBox(width: 4), const Icon(Icons.verified_rounded, size: 14, color: AppColors.govtTeal)],
            ]),
            Text('${b.village} • ${b.hives} hives', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
            Row(children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs, vertical: 1),
                decoration: BoxDecoration(color: AppColors.govtTeal.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(AppSpacing.radiusFull)),
                child: Text(b.scheme, style: AppTextStyles.labelSmall.copyWith(color: AppColors.govtTeal)),
              ),
              const SizedBox(width: AppSpacing.xs),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs, vertical: 1),
                decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(AppSpacing.radiusFull)),
                child: Text(b.status, style: AppTextStyles.labelSmall.copyWith(color: statusColor)),
              ),
            ]),
          ])),
          const Icon(Icons.chevron_right_rounded, color: AppColors.onSurfaceVariant),
        ]),
      ),
    );
  }
}
