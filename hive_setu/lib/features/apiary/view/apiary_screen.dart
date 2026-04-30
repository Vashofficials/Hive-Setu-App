import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/router/app_router.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_header.dart';

class ApiaryScreen extends StatelessWidget {
  const ApiaryScreen({super.key});

  static const _hives = [
    _Hive(id: 'H-01', status: 'Healthy', queen: 'Active', frames: 8, honey: 3.2, color: AppColors.secondary),
    _Hive(id: 'H-02', status: 'Healthy', queen: 'Active', frames: 7, honey: 2.8, color: AppColors.secondary),
    _Hive(id: 'H-03', status: 'Alert', queen: 'Weak', frames: 5, honey: 1.1, color: AppColors.error),
    _Hive(id: 'H-04', status: 'Healthy', queen: 'Active', frames: 9, honey: 4.0, color: AppColors.secondary),
    _Hive(id: 'H-05', status: 'Queenless', queen: 'Missing', frames: 4, honey: 0.5, color: AppColors.amberAlert),
    _Hive(id: 'H-06', status: 'Healthy', queen: 'Active', frames: 8, honey: 3.5, color: AppColors.secondary),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(
        title: 'मेरी मधुशाला',
        subtitle: 'My Apiary — 24 Hives',
        actions: [
          IconButton(
            icon: const Icon(Icons.map_outlined),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Summary Strip
          Container(
            margin: const EdgeInsets.all(AppSpacing.screenPaddingH),
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              gradient: AppColors.amberGradient,
              borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _SummaryItem(value: '21', label: 'Healthy', icon: '✅'),
                _SummaryItem(value: '1', label: 'Alert', icon: '⚠️'),
                _SummaryItem(value: '2', label: 'Queenless', icon: '👑'),
                _SummaryItem(value: '142 kg', label: 'Total Honey', icon: '🍯'),
              ],
            ),
          ),
          // Hive Grid
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.screenPaddingH,
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: AppSpacing.md,
                mainAxisSpacing: AppSpacing.md,
                childAspectRatio: 1.1,
              ),
              itemCount: _hives.length,
              itemBuilder: (context, index) => _HiveCard(
                hive: _hives[index],
                onTap: () => context.push(AppRoutes.hiveDetail, extra: _hives[index].id),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        icon: const Icon(Icons.add_rounded),
        label: Text('Add Hive', style: AppTextStyles.labelLarge.copyWith(color: AppColors.white)),
      ),
    );
  }
}

class _SummaryItem extends StatelessWidget {
  const _SummaryItem({required this.value, required this.label, required this.icon});
  final String value, label, icon;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 2),
          Text(value, style: AppTextStyles.titleMedium.copyWith(color: AppColors.white)),
          Text(label, style: AppTextStyles.caption.copyWith(color: AppColors.white.withValues(alpha: 0.85))),
        ],
      );
}

class _Hive {
  const _Hive({required this.id, required this.status, required this.queen, required this.frames, required this.honey, required this.color});
  final String id, status, queen;
  final int frames;
  final double honey;
  final Color color;
}

class _HiveCard extends StatelessWidget {
  const _HiveCard({required this.hive, required this.onTap});
  final _Hive hive;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        boxShadow: hive.status == 'Alert' 
            ? [BoxShadow(color: AppColors.error.withValues(alpha: 0.12), blurRadius: 16, offset: const Offset(0, 8))]
            : AppColors.ambientShadow,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('🏠', style: const TextStyle(fontSize: 28)),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: hive.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                ),
                child: Text(
                  hive.status,
                  style: AppTextStyles.labelSmall.copyWith(color: hive.color, fontWeight: FontWeight.w700),
                ),
              ),
            ],
          ),
          const Spacer(),
          Text(hive.id, style: AppTextStyles.titleMedium.copyWith(color: AppColors.onSurface)),
          const SizedBox(height: 2),
          Text('${hive.frames} frames • ${hive.honey}kg', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
          Text('Queen: ${hive.queen}', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
        ],
      ),
    ),
    );
  }
}
