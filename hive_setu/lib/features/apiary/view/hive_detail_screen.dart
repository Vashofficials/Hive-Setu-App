import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/router/app_router.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_header.dart';

class HiveDetailScreen extends StatefulWidget {
  const HiveDetailScreen({super.key, required this.hiveId});
  final String hiveId;

  @override
  State<HiveDetailScreen> createState() => _HiveDetailScreenState();
}

class _HiveDetailScreenState extends State<HiveDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(
        title: widget.hiveId,
        subtitle: 'Hive Detail',
        badge: 'Healthy',
        badgeColor: AppColors.secondary,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit_outlined),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.onSurfaceVariant,
          indicatorColor: AppColors.primary,
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle: AppTextStyles.labelMedium,
          tabs: const [
            Tab(text: 'Summary'),
            Tab(text: 'Diary'),
            Tab(text: 'Photos'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _SummaryTab(hiveId: widget.hiveId),
          _DiaryTab(hiveId: widget.hiveId),
          _PhotosTab(hiveId: widget.hiveId),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => context.push(AppRoutes.inspectionWizard, extra: widget.hiveId),
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.white,
        icon: const Icon(Icons.add_task_rounded),
        label: const Text('New Inspection'),
      ),
    );
  }
}

// ── Summary Tab ──────────────────────────────────────────────────────────────

class _SummaryTab extends StatelessWidget {
  const _SummaryTab({required this.hiveId});
  final String hiveId;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Status + key metrics
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              gradient: AppColors.greenGradient,
              borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                _MetricItem(value: '8', label: 'Frames', icon: '🪵'),
                _MetricItem(value: '3.2 kg', label: 'Honey', icon: '🍯'),
                _MetricItem(value: 'Active', label: 'Queen', icon: '👑'),
                _MetricItem(value: 'Low', label: 'Varroa', icon: '🔬'),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Text('Hive Details', style: AppTextStyles.sectionTitle),
          const SizedBox(height: AppSpacing.md),
          _DetailRow(label: 'Hive Type', value: 'Langstroth 10-frame'),
          _DetailRow(label: 'Installed Date', value: '15 Jan 2026'),
          _DetailRow(label: 'Last Inspection', value: '12 Apr 2026'),
          _DetailRow(label: 'Location', value: 'Apiary Block A, Row 2'),
          _DetailRow(label: 'Bee Breed', value: 'Apis mellifera — Italian'),
          _DetailRow(label: 'Queen Age', value: '14 months'),
          const SizedBox(height: AppSpacing.xl),
          Text('Health Indicators', style: AppTextStyles.sectionTitle),
          const SizedBox(height: AppSpacing.md),
          _HealthBar(label: 'Colony Strength', percent: 0.82, color: AppColors.secondary),
          const SizedBox(height: AppSpacing.sm),
          _HealthBar(label: 'Brood Pattern', percent: 0.90, color: AppColors.secondary),
          const SizedBox(height: AppSpacing.sm),
          _HealthBar(label: 'Food Stores', percent: 0.60, color: AppColors.amberAlert),
          const SizedBox(height: AppSpacing.sm),
          _HealthBar(label: 'Pest Load', percent: 0.15, color: AppColors.secondary),
          const SizedBox(height: AppSpacing.xxl),
        ],
      ),
    );
  }
}

class _MetricItem extends StatelessWidget {
  const _MetricItem({required this.value, required this.label, required this.icon});
  final String value, label, icon;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 20)),
          const SizedBox(height: 4),
          Text(value, style: AppTextStyles.titleMedium.copyWith(color: AppColors.white, fontWeight: FontWeight.w700)),
          Text(label, style: AppTextStyles.caption.copyWith(color: AppColors.white.withValues(alpha: 0.8))),
        ],
      );
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});
  final String label, value;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 130,
              child: Text(label, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
            ),
            Expanded(child: Text(value, style: AppTextStyles.bodySmall.copyWith(color: AppColors.onSurface, fontWeight: FontWeight.w500))),
          ],
        ),
      );
}

class _HealthBar extends StatelessWidget {
  const _HealthBar({required this.label, required this.percent, required this.color});
  final String label;
  final double percent;
  final Color color;

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(label, style: AppTextStyles.bodySmall),
              Text('${(percent * 100).round()}%', style: AppTextStyles.labelSmall.copyWith(color: color)),
            ],
          ),
          const SizedBox(height: 4),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
            child: LinearProgressIndicator(
              value: percent,
              backgroundColor: AppColors.surfaceVariant,
              valueColor: AlwaysStoppedAnimation<Color>(color),
              minHeight: 6,
            ),
          ),
        ],
      );
}

// ── Diary Tab ────────────────────────────────────────────────────────────────

class _DiaryTab extends StatelessWidget {
  const _DiaryTab({required this.hiveId});
  final String hiveId;

  static const _entries = [
    _DiaryEntry(date: '12 Apr 2026', type: 'Inspection', notes: 'Queen active, good brood pattern. Minor Varroa detected (2 mites per 100 bees). Recommended treatment.', severity: 'normal'),
    _DiaryEntry(date: '01 Apr 2026', type: 'Treatment', notes: 'Applied Oxalic acid via dribble method. Colony calm, no aggression.', severity: 'treatment'),
    _DiaryEntry(date: '22 Mar 2026', type: 'Harvest', notes: 'Extracted 3.2 kg honey. Quality: Grade A, moisture 18%. Submitted to FPO batch #B-112.', severity: 'harvest'),
    _DiaryEntry(date: '08 Mar 2026', type: 'Inspection', notes: 'Colony strong. 8 frames covered. Sugar syrup feeders refilled. Queen eggs visible.', severity: 'normal'),
    _DiaryEntry(date: '20 Feb 2026', type: 'Inspection', notes: 'Post-winter check. Colony survived, population rebuilding. 5 frames covered.', severity: 'normal'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
      itemCount: _entries.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
      itemBuilder: (_, i) => _DiaryCard(entry: _entries[i]),
    );
  }
}

class _DiaryEntry {
  const _DiaryEntry({required this.date, required this.type, required this.notes, required this.severity});
  final String date, type, notes, severity;
}

class _DiaryCard extends StatelessWidget {
  const _DiaryCard({required this.entry});
  final _DiaryEntry entry;

  Color get _typeColor => switch (entry.severity) {
        'treatment' => AppColors.amberAlert,
        'harvest' => AppColors.secondary,
        _ => AppColors.primary,
      };

  String get _typeIcon => switch (entry.severity) {
        'treatment' => '💊',
        'harvest' => '🍯',
        _ => '🔍',
      };

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
                Text(_typeIcon, style: const TextStyle(fontSize: 18)),
                const SizedBox(width: AppSpacing.sm),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: _typeColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                  ),
                  child: Text(entry.type, style: AppTextStyles.labelSmall.copyWith(color: _typeColor, fontWeight: FontWeight.w700)),
                ),
                const Spacer(),
                Text(entry.date, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(entry.notes, style: AppTextStyles.bodySmall.copyWith(color: AppColors.onSurfaceVariant, height: 1.5)),
          ],
        ),
      );
}

// ── Photos Tab ───────────────────────────────────────────────────────────────

class _PhotosTab extends StatelessWidget {
  const _PhotosTab({required this.hiveId});
  final String hiveId;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: AppSpacing.sm,
        mainAxisSpacing: AppSpacing.sm,
      ),
      itemCount: 9,
      itemBuilder: (context, i) => Container(
        decoration: BoxDecoration(
          color: AppColors.primaryContainer.withValues(alpha: 0.15 + (i % 3) * 0.05),
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(['🐝', '🍯', '🏠', '🌸', '🔬', '👑', '🌿', '🐝', '🍯'][i], style: const TextStyle(fontSize: 28)),
            const SizedBox(height: 4),
            Text(
              ['Apr 12', 'Apr 01', 'Mar 22', 'Mar 08', 'Feb 20', 'Feb 10', 'Jan 30', 'Jan 22', 'Jan 15'][i],
              style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant),
            ),
          ],
        ),
      ),
    );
  }
}
