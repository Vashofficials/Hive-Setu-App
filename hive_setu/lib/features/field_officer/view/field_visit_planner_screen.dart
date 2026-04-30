import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/router/app_router.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_header.dart';

class FieldVisitPlannerScreen extends StatelessWidget {
  const FieldVisitPlannerScreen({super.key});

  static final _visits = [
    _Visit(location: 'Shamli Block', purpose: 'Varroa Outbreak Assessment', date: 'Apr 30', time: '9:30 AM', status: 'Scheduled', priority: 'High'),
    _Visit(location: 'Meerut Block', purpose: 'NBHM Training Program', date: 'May 1', time: '11:00 AM', status: 'Scheduled', priority: 'Medium'),
    _Visit(location: 'Saharanpur', purpose: 'Pesticide Impact Survey', date: 'May 2', time: '10:00 AM', status: 'Scheduled', priority: 'High'),
    _Visit(location: 'Bijnor', purpose: 'Colony Census', date: 'May 5', time: '9:00 AM', status: 'Planned', priority: 'Low'),
    _Visit(location: 'Muzaffarnagar', purpose: 'FPO Quarterly Review', date: 'Apr 28', time: '2:00 PM', status: 'Completed', priority: 'Medium'),
    _Visit(location: 'Moradabad', purpose: 'Wax Moth Incident Follow-up', date: 'Apr 25', time: '10:00 AM', status: 'Completed', priority: 'Medium'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(title: 'Field Visit Planner', subtitle: 'फील्ड विजिट योजना'),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutes.fieldVisitLog),
        backgroundColor: AppColors.govtTeal,
        icon: const Icon(Icons.add_rounded, color: AppColors.white),
        label: Text('New Visit', style: AppTextStyles.buttonSmall.copyWith(color: AppColors.white)),
      ),
      body: ListView.separated(
        padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
        itemCount: _visits.length,
        separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
        itemBuilder: (_, i) => _VisitCard(visit: _visits[i], onTap: () => context.push(AppRoutes.fieldVisitLog)),
      ),
    );
  }
}

class _Visit {
  const _Visit({required this.location, required this.purpose, required this.date, required this.time, required this.status, required this.priority});
  final String location, purpose, date, time, status, priority;
}

class _VisitCard extends StatelessWidget {
  const _VisitCard({required this.visit, required this.onTap});
  final _Visit visit;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final priorityColor = visit.priority == 'High' ? AppColors.error : visit.priority == 'Medium' ? AppColors.primary : AppColors.secondary;
    final statusColor = visit.status == 'Completed' ? AppColors.secondary : visit.status == 'Scheduled' ? AppColors.govtTeal : AppColors.onSurfaceVariant;
    final isDone = visit.status == 'Completed';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppSpacing.cardRadius), boxShadow: AppColors.ambientShadow),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Container(width: 44, height: 44, decoration: BoxDecoration(color: (isDone ? AppColors.secondary : AppColors.govtTeal).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(AppSpacing.radiusMd)),
              child: Icon(isDone ? Icons.check_circle_rounded : Icons.event_rounded, color: isDone ? AppColors.secondary : AppColors.govtTeal, size: 22)),
            const SizedBox(width: AppSpacing.md),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(visit.purpose, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.w700, decoration: isDone ? TextDecoration.lineThrough : null)),
              Text('📍 ${visit.location}', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
            ])),
          ]),
          const SizedBox(height: AppSpacing.sm),
          Row(children: [
            Icon(Icons.schedule_rounded, size: 14, color: AppColors.onSurfaceVariant),
            const SizedBox(width: 4),
            Text('${visit.date} at ${visit.time}', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
            const Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs, vertical: 1),
              decoration: BoxDecoration(color: priorityColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(AppSpacing.radiusFull)),
              child: Text(visit.priority, style: AppTextStyles.labelSmall.copyWith(color: priorityColor, fontWeight: FontWeight.w700)),
            ),
            const SizedBox(width: AppSpacing.xs),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xs, vertical: 1),
              decoration: BoxDecoration(color: statusColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(AppSpacing.radiusFull)),
              child: Text(visit.status, style: AppTextStyles.labelSmall.copyWith(color: statusColor, fontWeight: FontWeight.w700)),
            ),
          ]),
        ]),
      ),
    );
  }
}
