import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/router/app_router.dart';
import '../../../core/widgets/app_header.dart';

class OfficerDashboardScreen extends StatelessWidget {
  const OfficerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(
        title: 'Officer Dashboard',
        subtitle: 'अधिकारी डैशबोर्ड',
        actions: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
            decoration: BoxDecoration(color: AppColors.govtTeal.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(AppSpacing.radiusFull)),
            child: Text('Field Officer', style: AppTextStyles.labelMedium.copyWith(color: AppColors.govtTeal, fontWeight: FontWeight.w700)),
          ),
          const SizedBox(width: AppSpacing.md),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // KPI Cards
          Row(children: const [
            Expanded(child: _KpiCard(label: 'Beekeepers', value: '1,248', emoji: '🐝', color: AppColors.primary)),
            SizedBox(width: AppSpacing.md),
            Expanded(child: _KpiCard(label: 'Active Programs', value: '8', emoji: '📋', color: AppColors.govtTeal)),
          ]),
          const SizedBox(height: AppSpacing.md),
          Row(children: const [
            Expanded(child: _KpiCard(label: 'Open Incidents', value: '14', emoji: '⚠️', color: AppColors.error)),
            SizedBox(width: AppSpacing.md),
            Expanded(child: _KpiCard(label: 'Field Visits', value: '6', emoji: '📍', color: AppColors.buyerBlue)),
          ]),
          const SizedBox(height: AppSpacing.xl),

          // Quick Actions
          Text('Quick Actions', style: AppTextStyles.sectionTitle),
          const SizedBox(height: AppSpacing.xs),
          Text('तुरंत कार्य', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
          const SizedBox(height: AppSpacing.md),
          Row(children: [
            _ActionTile(icon: Icons.people_rounded, label: 'Beneficiaries', color: AppColors.govtTeal, onTap: () => context.push(AppRoutes.schemeBeneficiaryList)),
            const SizedBox(width: AppSpacing.md),
            _ActionTile(icon: Icons.map_rounded, label: 'Incident Map', color: AppColors.error, onTap: () => context.push(AppRoutes.incidentMap)),
            const SizedBox(width: AppSpacing.md),
            _ActionTile(icon: Icons.event_note_rounded, label: 'Visit Planner', color: AppColors.buyerBlue, onTap: () => context.push(AppRoutes.fieldVisitPlanner)),
            const SizedBox(width: AppSpacing.md),
            _ActionTile(icon: Icons.analytics_rounded, label: 'Reports', color: AppColors.fpoPurple, onTap: () => context.push(AppRoutes.officerReports)),
          ]),
          const SizedBox(height: AppSpacing.xl),

          // Block Schedule
          Text('This Week\'s Schedule', style: AppTextStyles.sectionTitle),
          const SizedBox(height: AppSpacing.xs),
          Text('इस सप्ताह की योजना', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
          const SizedBox(height: AppSpacing.md),
          _ScheduleCard(day: 'Mon', title: 'Shamli Block — Scheme Verification', time: '10:00 AM', done: true),
          _ScheduleCard(day: 'Tue', title: 'Muzaffarnagar — FPO Audit', time: '11:00 AM', done: true),
          _ScheduleCard(day: 'Wed', title: 'Saharanpur — Disease Assessment', time: '9:30 AM', done: false),
          _ScheduleCard(day: 'Thu', title: 'Meerut — Training Program', time: '2:00 PM', done: false),
          _ScheduleCard(day: 'Fri', title: 'Bijnor — Colony Inspection', time: '10:00 AM', done: false),

          const SizedBox(height: AppSpacing.xl),
          // Recent Alerts
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('Recent Alerts', style: AppTextStyles.sectionTitle),
              Text('हाल की चेतावनियाँ', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
            ]),
            TextButton(onPressed: () => context.push(AppRoutes.alertFeed), child: Text('View All', style: AppTextStyles.labelMedium.copyWith(color: AppColors.govtTeal))),
          ]),
          const SizedBox(height: AppSpacing.md),
          _AlertTile(title: 'Varroa Mite Outbreak — Shamli', severity: 'High', time: '2 hrs ago', color: AppColors.error),
          _AlertTile(title: 'Low Colony Strength — Meerut Block', severity: 'Medium', time: '5 hrs ago', color: AppColors.primary),
          _AlertTile(title: 'Pesticide Exposure — Saharanpur', severity: 'High', time: '1 day ago', color: AppColors.error),
          const SizedBox(height: AppSpacing.massive),
        ]),
      ),
    );
  }
}

class _KpiCard extends StatelessWidget {
  const _KpiCard({required this.label, required this.value, required this.emoji, required this.color});
  final String label, value, emoji;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppSpacing.cardRadius), boxShadow: AppColors.ambientShadow),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(emoji, style: const TextStyle(fontSize: 22)),
        const SizedBox(height: AppSpacing.sm),
        Text(value, style: AppTextStyles.titleLarge.copyWith(color: color)),
        Text(label, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
      ]),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({required this.icon, required this.label, required this.color, required this.onTap});
  final IconData icon;
  final String label;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
          decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppSpacing.radiusLg), boxShadow: AppColors.ambientShadow),
          child: Column(children: [
            Container(width: 36, height: 36, decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(AppSpacing.radiusMd)),
              child: Icon(icon, color: color, size: 18)),
            const SizedBox(height: AppSpacing.xs),
            Text(label, style: AppTextStyles.labelSmall.copyWith(color: AppColors.onSurface), textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
          ]),
        ),
      ),
    );
  }
}

class _ScheduleCard extends StatelessWidget {
  const _ScheduleCard({required this.day, required this.title, required this.time, required this.done});
  final String day, title, time;
  final bool done;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppSpacing.radiusMd), boxShadow: AppColors.ambientShadow),
        child: Row(children: [
          Container(
            width: 40, height: 40,
            decoration: BoxDecoration(color: done ? AppColors.secondary.withValues(alpha: 0.1) : AppColors.govtTeal.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(AppSpacing.radiusMd)),
            child: Center(child: Text(day, style: AppTextStyles.labelSmall.copyWith(color: done ? AppColors.secondary : AppColors.govtTeal, fontWeight: FontWeight.w700))),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.w600, decoration: done ? TextDecoration.lineThrough : null, color: done ? AppColors.onSurfaceVariant : AppColors.onSurface)),
            Text(time, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
          ])),
          if (done) const Icon(Icons.check_circle_rounded, color: AppColors.secondary, size: 20),
        ]),
      ),
    );
  }
}

class _AlertTile extends StatelessWidget {
  const _AlertTile({required this.title, required this.severity, required this.time, required this.color});
  final String title, severity, time;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppSpacing.radiusMd), boxShadow: AppColors.ambientShadow),
        child: Row(children: [
          Container(width: 40, height: 40, decoration: BoxDecoration(color: color.withValues(alpha: 0.1), shape: BoxShape.circle),
            child: Icon(Icons.warning_amber_rounded, color: color, size: 20)),
          const SizedBox(width: AppSpacing.md),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.w600)),
            Text(time, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
          ])),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 2),
            decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(AppSpacing.radiusFull)),
            child: Text(severity, style: AppTextStyles.labelSmall.copyWith(color: color, fontWeight: FontWeight.w700)),
          ),
        ]),
      ),
    );
  }
}
