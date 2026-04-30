import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_header.dart';

class FieldVisitScreen extends StatefulWidget {
  const FieldVisitScreen({super.key});

  @override
  State<FieldVisitScreen> createState() => _FieldVisitScreenState();
}

class _FieldVisitScreenState extends State<FieldVisitScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  bool _checkedIn = false;
  String? _checkedInApiary;
  bool _syncPending = false;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  static const _planned = [
    _VisitPlan(beekeeper: 'Ramesh Kumar', apiary: 'Charthawal Farm', time: '09:00 AM', purpose: 'Health Inspection', status: 'Completed'),
    _VisitPlan(beekeeper: 'Anita Devi', apiary: 'Roorkee Garden', time: '11:00 AM', purpose: 'Varroa Treatment Follow-up', status: 'In Progress'),
    _VisitPlan(beekeeper: 'Suresh K.', apiary: 'Muzaffarnagar Apiary', time: '02:00 PM', purpose: 'New Hive Registration', status: 'Pending'),
    _VisitPlan(beekeeper: 'Priya Singh', apiary: 'Shamli Colony', time: '04:00 PM', purpose: 'Colony Census', status: 'Pending'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(
        title: 'Field Visits',
        subtitle: 'क्षेत्र भ्रमण',
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.govtTeal,
          unselectedLabelColor: AppColors.onSurfaceVariant,
          indicatorColor: AppColors.govtTeal,
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle: AppTextStyles.labelMedium,
          tabs: const [
            Tab(text: 'Today\'s Plan'),
            Tab(text: 'Check-In'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildPlanTab(),
          _buildCheckInTab(),
        ],
      ),
    );
  }

  Widget _buildPlanTab() {
    final completed = _planned.where((v) => v.status == 'Completed').length;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Progress banner
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.govtTeal.withValues(alpha: 0.08),
              borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
              border: Border.all(color: AppColors.govtTeal.withValues(alpha: 0.2)),
            ),
            child: Row(
              children: [
                Text('📋', style: const TextStyle(fontSize: 28)),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Today — 30 Apr 2026', style: AppTextStyles.titleSmall.copyWith(color: AppColors.govtTeal)),
                      Text('$completed of ${_planned.length} visits completed', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
                      const SizedBox(height: AppSpacing.sm),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: LinearProgressIndicator(
                          value: completed / _planned.length,
                          minHeight: 6,
                          backgroundColor: AppColors.govtTeal.withValues(alpha: 0.15),
                          valueColor: const AlwaysStoppedAnimation<Color>(AppColors.govtTeal),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Text('Scheduled Visits', style: AppTextStyles.sectionTitle),
          const SizedBox(height: AppSpacing.md),
          ..._planned.map((v) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: _VisitCard(plan: v, onCheckIn: () {
                  setState(() {
                    _checkedIn = true;
                    _checkedInApiary = v.apiary;
                    _tabController.animateTo(1);
                  });
                }),
              )),
          const SizedBox(height: AppSpacing.xl),
          if (_syncPending)
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.amberAlert.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                border: Border.all(color: AppColors.amberAlert.withValues(alpha: 0.3)),
              ),
              child: Row(
                children: [
                  const Icon(Icons.cloud_off_rounded, color: AppColors.amberAlert),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(child: Text('1 visit saved offline — tap to sync', style: AppTextStyles.bodySmall.copyWith(color: AppColors.amberAlert))),
                  TextButton(
                    onPressed: () => setState(() => _syncPending = false),
                    child: Text('Sync', style: AppTextStyles.labelMedium.copyWith(color: AppColors.govtTeal)),
                  ),
                ],
              ),
            ),
          const SizedBox(height: AppSpacing.xxl),
        ],
      ),
    );
  }

  Widget _buildCheckInTab() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // GPS Check-in card
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.govtTeal, Color(0xFF0A5A73)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            ),
            child: Column(
              children: [
                Text(_checkedIn ? '✅' : '📍', style: const TextStyle(fontSize: 40)),
                const SizedBox(height: AppSpacing.md),
                Text(
                  _checkedIn ? 'Checked In' : 'GPS Check-In',
                  style: AppTextStyles.titleMedium.copyWith(color: AppColors.white),
                ),
                Text(
                  _checkedIn ? (_checkedInApiary ?? 'Apiary') : 'Tap to record your GPS location at the apiary',
                  style: AppTextStyles.bodySmall.copyWith(color: AppColors.white.withValues(alpha: 0.85)),
                  textAlign: TextAlign.center,
                ),
                if (_checkedIn) ...[
                  const SizedBox(height: AppSpacing.sm),
                  Text('29°24\'N, 77°41\'E • 11:08 AM', style: AppTextStyles.caption.copyWith(color: AppColors.white.withValues(alpha: 0.7))),
                ],
                const SizedBox(height: AppSpacing.lg),
                AppButton(
                  label: _checkedIn ? 'Check Out' : 'Check In Now',
                  variant: _checkedIn ? AppButtonVariant.ghost : AppButtonVariant.primary,
                  onPressed: () => setState(() {
                    _checkedIn = !_checkedIn;
                    if (!_checkedIn) _checkedInApiary = null;
                  }),
                  icon: Icon(_checkedIn ? Icons.logout_rounded : Icons.my_location_rounded, size: 18, color: _checkedIn ? AppColors.govtTeal : AppColors.white),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          if (_checkedIn) ...[
            Text('Visit Report', style: AppTextStyles.sectionTitle),
            const SizedBox(height: AppSpacing.md),
            _buildVisitForm(),
          ] else ...[
            Text('Recent Check-Ins', style: AppTextStyles.sectionTitle),
            const SizedBox(height: AppSpacing.md),
            _CheckInTile(apiary: 'Charthawal Farm', beekeeper: 'Ramesh Kumar', time: '09:02 AM', duration: '1h 24m'),
          ],
          const SizedBox(height: AppSpacing.xxl),
        ],
      ),
    );
  }

  final _observationsCtrl = TextEditingController();
  final _recommendCtrl = TextEditingController();
  String _healthRating = 'Good';

  Widget _buildVisitForm() {
    const ratings = ['Poor', 'Fair', 'Good', 'Excellent'];
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('Colony Health Rating', style: AppTextStyles.inputLabel.copyWith(color: AppColors.onSurface)),
        const SizedBox(height: AppSpacing.sm),
        Row(
          children: ratings.map((r) {
            final selected = _healthRating == r;
            final color = switch (r) {
              'Poor' => AppColors.error,
              'Fair' => AppColors.amberAlert,
              'Excellent' => AppColors.secondary,
              _ => AppColors.govtTeal,
            };
            return Expanded(
              child: GestureDetector(
                onTap: () => setState(() => _healthRating = r),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  margin: const EdgeInsets.symmetric(horizontal: 3),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    color: selected ? color : color.withValues(alpha: 0.08),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  ),
                  child: Text(r, textAlign: TextAlign.center, style: AppTextStyles.labelSmall.copyWith(
                    color: selected ? AppColors.white : color,
                    fontWeight: FontWeight.w600,
                  )),
                ),
              ),
            );
          }).toList(),
        ),
        const SizedBox(height: AppSpacing.lg),
        _VisitField(label: 'Observations', hint: 'What did you observe during this visit?', controller: _observationsCtrl, maxLines: 4),
        const SizedBox(height: AppSpacing.md),
        _VisitField(label: 'Recommendations', hint: 'Actions recommended to the beekeeper...', controller: _recommendCtrl, maxLines: 3),
        const SizedBox(height: AppSpacing.xl),
        Row(
          children: [
            Expanded(
              child: AppButton(
                label: 'Save Offline',
                variant: AppButtonVariant.nest,
                size: AppButtonSize.small,
                icon: const Icon(Icons.download_done_rounded, color: AppColors.govtTeal, size: 16),
                onPressed: () => setState(() { _syncPending = true; _tabController.animateTo(0); }),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: AppButton(
                label: 'Submit Report',
                size: AppButtonSize.small,
                onPressed: _submitReport,
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _submitReport() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Visit report submitted'), backgroundColor: AppColors.govtTeal, behavior: SnackBarBehavior.floating),
    );
    setState(() { _checkedIn = false; _checkedInApiary = null; _tabController.animateTo(0); });
  }
}

class _VisitPlan {
  const _VisitPlan({required this.beekeeper, required this.apiary, required this.time, required this.purpose, required this.status});
  final String beekeeper, apiary, time, purpose, status;
}

class _VisitCard extends StatelessWidget {
  const _VisitCard({required this.plan, required this.onCheckIn});
  final _VisitPlan plan;
  final VoidCallback onCheckIn;

  Color get _statusColor => switch (plan.status) {
        'Completed' => AppColors.secondary,
        'In Progress' => AppColors.govtTeal,
        _ => AppColors.onSurfaceVariant,
      };

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: plan.status == 'Completed' ? AppColors.surfaceVariant : AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          boxShadow: plan.status == 'Completed' ? null : AppColors.ambientShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                  ),
                  child: Text(plan.time, style: AppTextStyles.caption.copyWith(color: _statusColor, fontWeight: FontWeight.w600)),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: _statusColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                  ),
                  child: Text(plan.status, style: AppTextStyles.labelSmall.copyWith(color: _statusColor, fontWeight: FontWeight.w700)),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(plan.beekeeper, style: AppTextStyles.titleSmall),
            Text('${plan.apiary} • ${plan.purpose}', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
            if (plan.status == 'Pending') ...[
              const SizedBox(height: AppSpacing.md),
              AppButton(
                label: 'Check In',
                size: AppButtonSize.small,
                onPressed: onCheckIn,
                icon: const Icon(Icons.my_location_rounded, color: AppColors.white, size: 16),
              ),
            ],
          ],
        ),
      );
}

class _CheckInTile extends StatelessWidget {
  const _CheckInTile({required this.apiary, required this.beekeeper, required this.time, required this.duration});
  final String apiary, beekeeper, time, duration;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          boxShadow: AppColors.ambientShadow,
        ),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(color: AppColors.secondary.withValues(alpha: 0.1), shape: BoxShape.circle),
              child: const Icon(Icons.check_rounded, color: AppColors.secondary, size: 20),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(apiary, style: AppTextStyles.titleSmall),
                  Text('$beekeeper • $time', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
                ],
              ),
            ),
            Text(duration, style: AppTextStyles.bodySmall.copyWith(color: AppColors.govtTeal, fontWeight: FontWeight.w600)),
          ],
        ),
      );
}

class _VisitField extends StatelessWidget {
  const _VisitField({required this.label, required this.hint, required this.controller, this.maxLines = 2});
  final String label, hint;
  final TextEditingController controller;
  final int maxLines;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: AppTextStyles.inputLabel.copyWith(color: AppColors.onSurface)),
          const SizedBox(height: AppSpacing.xs),
          TextField(
            controller: controller,
            maxLines: maxLines,
            style: AppTextStyles.bodySmall,
            decoration: InputDecoration(
              hintText: hint,
              hintStyle: AppTextStyles.bodySmall.copyWith(color: AppColors.onSurfaceVariant),
              filled: true,
              fillColor: AppColors.white,
              contentPadding: const EdgeInsets.all(AppSpacing.md),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppSpacing.radiusMd), borderSide: BorderSide.none),
              enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppSpacing.radiusMd), borderSide: BorderSide.none),
            ),
          ),
        ],
      );
}
