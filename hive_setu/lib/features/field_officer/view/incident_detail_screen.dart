import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_header.dart';
import '../../../core/widgets/app_input.dart';

class IncidentDetailScreen extends StatefulWidget {
  const IncidentDetailScreen({super.key});

  @override
  State<IncidentDetailScreen> createState() => _IncidentDetailScreenState();
}

class _IncidentDetailScreenState extends State<IncidentDetailScreen> {
  String _status = 'Open';
  final _notesCtrl = TextEditingController();

  @override
  void dispose() {
    _notesCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(title: 'Incident Detail', subtitle: 'घटना विवरण'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // Incident Header
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(color: AppColors.error.withValues(alpha: 0.06), borderRadius: BorderRadius.circular(AppSpacing.cardRadius)),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [
                Container(width: 44, height: 44, decoration: BoxDecoration(color: AppColors.error.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(AppSpacing.radiusMd)),
                  child: const Icon(Icons.warning_amber_rounded, color: AppColors.error, size: 24)),
                const SizedBox(width: AppSpacing.md),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Varroa Mite Outbreak', style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.w700)),
                  Text('Shamli Block, Uttar Pradesh', style: AppTextStyles.bodySmall.copyWith(color: AppColors.onSurfaceVariant)),
                ])),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 4),
                  decoration: BoxDecoration(color: AppColors.error.withValues(alpha: 0.15), borderRadius: BorderRadius.circular(AppSpacing.radiusFull)),
                  child: Text('High', style: AppTextStyles.labelSmall.copyWith(color: AppColors.error, fontWeight: FontWeight.w700)),
                ),
              ]),
            ]),
          ),
          const SizedBox(height: AppSpacing.lg),

          // Details Card
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppSpacing.cardRadius), boxShadow: AppColors.ambientShadow),
            child: Column(children: [
              _DetailRow(icon: Icons.calendar_today_rounded, label: 'Reported', value: 'April 29, 2026 — 8:30 AM'),
              _DetailRow(icon: Icons.person_rounded, label: 'Reported By', value: 'Ramesh Kumar (Member)'),
              _DetailRow(icon: Icons.hive_rounded, label: 'Affected', value: '3 hives — Colony 7, 8, 12'),
              _DetailRow(icon: Icons.pest_control_rounded, label: 'Type', value: 'Varroa destructor infestation'),
              _DetailRow(icon: Icons.location_on_rounded, label: 'GPS', value: '29.4401°N, 77.3186°E'),
            ]),
          ),
          const SizedBox(height: AppSpacing.xl),

          // Status Management
          Text('Update Status', style: AppTextStyles.sectionTitle),
          const SizedBox(height: AppSpacing.md),
          Row(children: ['Open', 'In Progress', 'Resolved', 'Escalated'].map((s) {
            final isActive = _status == s;
            final color = s == 'Open' ? AppColors.error : s == 'In Progress' ? AppColors.primary : s == 'Resolved' ? AppColors.secondary : AppColors.fpoPurple;
            return Padding(
              padding: const EdgeInsets.only(right: AppSpacing.sm),
              child: GestureDetector(
                onTap: () => setState(() => _status = s),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
                  decoration: BoxDecoration(color: isActive ? color : color.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(AppSpacing.radiusFull)),
                  child: Text(s, style: AppTextStyles.labelSmall.copyWith(color: isActive ? AppColors.white : color, fontWeight: FontWeight.w700)),
                ),
              ),
            );
          }).toList()),
          const SizedBox(height: AppSpacing.xl),

          // Notes
          AppInput(label: 'Officer Notes / अधिकारी टिप्पणी', hint: 'Add your observations, actions taken...', controller: _notesCtrl, maxLines: 4),
          const SizedBox(height: AppSpacing.xl),

          // Timeline
          Text('Activity Timeline', style: AppTextStyles.sectionTitle),
          const SizedBox(height: AppSpacing.md),
          _TimelineItem(time: '8:30 AM', text: 'Incident reported by Ramesh Kumar', color: AppColors.error),
          _TimelineItem(time: '9:15 AM', text: 'Alert sent to Block Officer', color: AppColors.primary),
          _TimelineItem(time: '10:00 AM', text: 'Field visit scheduled for today', color: AppColors.govtTeal),
          const SizedBox(height: AppSpacing.xxl),

          // Actions
          Row(children: [
            Expanded(child: AppButton(label: 'Save Notes', onPressed: () => Navigator.pop(context), width: double.infinity)),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.arrow_upward_rounded, size: 18),
                label: const Text('Escalate'),
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.error,
                  side: BorderSide(color: AppColors.error.withValues(alpha: 0.3)),
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.radiusMd)),
                ),
              ),
            ),
          ]),
          const SizedBox(height: AppSpacing.massive),
        ]),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.icon, required this.label, required this.value});
  final IconData icon;
  final String label, value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(children: [
        Icon(icon, size: 18, color: AppColors.govtTeal),
        const SizedBox(width: AppSpacing.md),
        SizedBox(width: 80, child: Text(label, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant))),
        Expanded(child: Text(value, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w500))),
      ]),
    );
  }
}

class _TimelineItem extends StatelessWidget {
  const _TimelineItem({required this.time, required this.text, required this.color});
  final String time, text;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Column(children: [
          Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
          Container(width: 2, height: 30, color: AppColors.surfaceVariant),
        ]),
        const SizedBox(width: AppSpacing.md),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(time, style: AppTextStyles.labelSmall.copyWith(color: color)),
          Text(text, style: AppTextStyles.bodySmall),
        ])),
      ]),
    );
  }
}
