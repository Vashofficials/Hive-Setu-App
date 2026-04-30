import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_header.dart';

class FpoReportsScreen extends StatefulWidget {
  const FpoReportsScreen({super.key});

  @override
  State<FpoReportsScreen> createState() => _FpoReportsScreenState();
}

class _FpoReportsScreenState extends State<FpoReportsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedPeriod = 'This Month';
  static const _periods = ['This Week', 'This Month', 'This Quarter', 'This Year'];

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
        title: 'Reports',
        subtitle: 'रिपोर्ट केंद्र',
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: AppSpacing.md),
            child: DropdownButton<String>(
              value: _selectedPeriod,
              underline: const SizedBox(),
              style: AppTextStyles.labelMedium.copyWith(color: AppColors.fpoPurple),
              items: _periods.map((p) => DropdownMenuItem(value: p, child: Text(p))).toList(),
              onChanged: (v) => setState(() => _selectedPeriod = v!),
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.fpoPurple,
          unselectedLabelColor: AppColors.onSurfaceVariant,
          indicatorColor: AppColors.fpoPurple,
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle: AppTextStyles.labelMedium,
          tabs: const [
            Tab(text: 'Harvest'),
            Tab(text: 'Income'),
            Tab(text: 'Incidents'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _HarvestReportTab(period: _selectedPeriod),
          _IncomeReportTab(period: _selectedPeriod),
          _IncidentsReportTab(period: _selectedPeriod),
        ],
      ),
    );
  }
}

// ── Harvest Report Tab ────────────────────────────────────────────────────────

class _HarvestReportTab extends StatelessWidget {
  const _HarvestReportTab({required this.period});
  final String period;

  static const _byMember = [
    _MemberHarvest(name: 'Ramesh Kumar', qty: 40, grade: 'A+'),
    _MemberHarvest(name: 'Suresh K.', qty: 32, grade: 'A'),
    _MemberHarvest(name: 'Madhav Ram', qty: 25, grade: 'A'),
    _MemberHarvest(name: 'Anita Devi', qty: 14, grade: 'B+'),
  ];

  @override
  Widget build(BuildContext context) {
    const total = 111;
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ReportSummaryCard(
            title: 'Total Harvest',
            value: '$total kg',
            subtitle: period,
            icon: '🍯',
            color: AppColors.primary,
            details: [
              _Detail('Grade A+ / A', '72 kg'),
              _Detail('Grade B+', '39 kg'),
              _Detail('Approved Batches', '8'),
              _Detail('Pending Review', '2'),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          Text('By Member', style: AppTextStyles.sectionTitle),
          const SizedBox(height: AppSpacing.md),
          ..._byMember.map((m) {
            final frac = m.qty / total;
            return Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: _BarRow(label: m.name, value: '${m.qty} kg', fraction: frac, color: AppColors.primary, sublabel: 'Grade ${m.grade}'),
            );
          }),
          const SizedBox(height: AppSpacing.xl),
          _ExportRow(label: 'Harvest Report', period: period),
          const SizedBox(height: AppSpacing.xxl),
        ],
      ),
    );
  }
}

class _MemberHarvest {
  const _MemberHarvest({required this.name, required this.qty, required this.grade});
  final String name, grade;
  final int qty;
}

// ── Income Report Tab ─────────────────────────────────────────────────────────

class _IncomeReportTab extends StatelessWidget {
  const _IncomeReportTab({required this.period});
  final String period;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ReportSummaryCard(
            title: 'Total Income',
            value: '₹1,24,800',
            subtitle: period,
            icon: '💰',
            color: AppColors.secondary,
            details: [
              _Detail('Honey Sales', '₹98,400'),
              _Detail('Beeswax & Propolis', '₹18,200'),
              _Detail('Subsidy Credit', '₹8,200'),
              _Detail('Pending Payments', '₹12,600'),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          Text('Income by Source', style: AppTextStyles.sectionTitle),
          const SizedBox(height: AppSpacing.md),
          _BarRow(label: 'Honey Sales', value: '₹98,400', fraction: 0.79, color: AppColors.secondary, sublabel: '79%'),
          const SizedBox(height: AppSpacing.md),
          _BarRow(label: 'Beeswax & Propolis', value: '₹18,200', fraction: 0.15, color: AppColors.govtTeal, sublabel: '15%'),
          const SizedBox(height: AppSpacing.md),
          _BarRow(label: 'Subsidy Credit', value: '₹8,200', fraction: 0.07, color: AppColors.fpoPurple, sublabel: '7%'),
          const SizedBox(height: AppSpacing.xl),
          Text('Monthly Trend', style: AppTextStyles.sectionTitle),
          const SizedBox(height: AppSpacing.md),
          _MiniBarChart(
            bars: const [
              _Bar('Jan', 0.5),
              _Bar('Feb', 0.6),
              _Bar('Mar', 0.8),
              _Bar('Apr', 1.0),
            ],
            color: AppColors.secondary,
          ),
          const SizedBox(height: AppSpacing.xl),
          _ExportRow(label: 'Income Report', period: period),
          const SizedBox(height: AppSpacing.xxl),
        ],
      ),
    );
  }
}

// ── Incidents Report Tab ──────────────────────────────────────────────────────

class _IncidentsReportTab extends StatelessWidget {
  const _IncidentsReportTab({required this.period});
  final String period;

  static const _incidents = [
    _IncidentRow(type: 'Varroa Infestation', count: 3, resolved: 2, color: AppColors.error),
    _IncidentRow(type: 'AFB Suspected', count: 1, resolved: 1, color: AppColors.amberAlert),
    _IncidentRow(type: 'Queen Loss', count: 5, resolved: 4, color: AppColors.fpoPurple),
    _IncidentRow(type: 'Absconding', count: 2, resolved: 2, color: AppColors.govtTeal),
    _IncidentRow(type: 'Pesticide Exposure', count: 1, resolved: 0, color: AppColors.error),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ReportSummaryCard(
            title: 'Total Incidents',
            value: '12',
            subtitle: period,
            icon: '⚠️',
            color: AppColors.amberAlert,
            details: [
              _Detail('Resolved', '9'),
              _Detail('Open', '3'),
              _Detail('Avg. Resolution Time', '2.4 days'),
              _Detail('Most Affected Apiary', 'Charthawal Farm'),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          Text('By Incident Type', style: AppTextStyles.sectionTitle),
          const SizedBox(height: AppSpacing.md),
          ..._incidents.map((inc) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: _IncidentTypeCard(inc: inc),
              )),
          const SizedBox(height: AppSpacing.xl),
          // Advisory Broadcast Composer
          _BroadcastComposer(),
          const SizedBox(height: AppSpacing.xl),
          _ExportRow(label: 'Incident Report', period: period),
          const SizedBox(height: AppSpacing.xxl),
        ],
      ),
    );
  }
}

class _IncidentRow {
  const _IncidentRow({required this.type, required this.count, required this.resolved, required this.color});
  final String type;
  final int count, resolved;
  final Color color;
}

class _IncidentTypeCard extends StatelessWidget {
  const _IncidentTypeCard({required this.inc});
  final _IncidentRow inc;

  @override
  Widget build(BuildContext context) {
    final openCount = inc.count - inc.resolved;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        boxShadow: AppColors.ambientShadow,
      ),
      child: Row(
        children: [
          Container(
            width: 4,
            height: 48,
            decoration: BoxDecoration(
              color: inc.color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(inc.type, style: AppTextStyles.titleSmall),
                Text('${inc.resolved} resolved • $openCount open', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
              ],
            ),
          ),
          Text('${inc.count}', style: AppTextStyles.titleLarge.copyWith(color: inc.color, fontWeight: FontWeight.w700)),
        ],
      ),
    );
  }
}

class _BroadcastComposer extends StatefulWidget {
  @override
  State<_BroadcastComposer> createState() => _BroadcastComposerState();
}

class _BroadcastComposerState extends State<_BroadcastComposer> {
  final _controller = TextEditingController();
  bool _sent = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.fpoPurple.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        border: Border.all(color: AppColors.fpoPurple.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Text('📢', style: TextStyle(fontSize: 18)),
              const SizedBox(width: AppSpacing.sm),
              Text('Broadcast Advisory', style: AppTextStyles.titleSmall.copyWith(color: AppColors.fpoPurple)),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          if (_sent)
            Text('Advisory sent to all 34 members ✓', style: AppTextStyles.bodySmall.copyWith(color: AppColors.secondary))
          else ...[
            TextField(
              controller: _controller,
              maxLines: 3,
              style: AppTextStyles.bodySmall,
              decoration: InputDecoration(
                hintText: 'Type advisory message for all FPO members...',
                hintStyle: AppTextStyles.bodySmall.copyWith(color: AppColors.onSurfaceVariant),
                filled: true,
                fillColor: AppColors.white,
                contentPadding: const EdgeInsets.all(AppSpacing.md),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            AppButton(
              label: 'Send to All Members',
              size: AppButtonSize.small,
              icon: const Icon(Icons.send_rounded, color: AppColors.white, size: 16),
              onPressed: () async {
                if (_controller.text.trim().isEmpty) return;
                await Future.delayed(const Duration(milliseconds: 800));
                if (mounted) setState(() => _sent = true);
              },
              width: double.infinity,
            ),
          ],
        ],
      ),
    );
  }
}

// ── Shared Widgets ────────────────────────────────────────────────────────────

class _Detail {
  const _Detail(this.label, this.value);
  final String label, value;
}

class _ReportSummaryCard extends StatelessWidget {
  const _ReportSummaryCard({required this.title, required this.value, required this.subtitle, required this.icon, required this.color, required this.details});
  final String title, value, subtitle, icon;
  final Color color;
  final List<_Detail> details;

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
                Text(icon, style: const TextStyle(fontSize: 28)),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
                      Text(value, style: AppTextStyles.headlineSmall.copyWith(color: color, fontWeight: FontWeight.w700)),
                      Text(subtitle, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            const Divider(height: 1, color: AppColors.outlineVariant),
            const SizedBox(height: AppSpacing.md),
            ...details.map((d) => Padding(
                  padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(d.label, style: AppTextStyles.bodySmall.copyWith(color: AppColors.onSurfaceVariant)),
                      Text(d.value, style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w600)),
                    ],
                  ),
                )),
          ],
        ),
      );
}

class _BarRow extends StatelessWidget {
  const _BarRow({required this.label, required this.value, required this.fraction, required this.color, required this.sublabel});
  final String label, value, sublabel;
  final double fraction;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          boxShadow: AppColors.ambientShadow,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Text(label, style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w500))),
                Text(sublabel, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
                const SizedBox(width: AppSpacing.md),
                Text(value, style: AppTextStyles.bodySmall.copyWith(color: color, fontWeight: FontWeight.w700)),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: fraction,
                minHeight: 6,
                backgroundColor: color.withValues(alpha: 0.1),
                valueColor: AlwaysStoppedAnimation<Color>(color),
              ),
            ),
          ],
        ),
      );
}

class _Bar {
  const _Bar(this.label, this.fraction);
  final String label;
  final double fraction;
}

class _MiniBarChart extends StatelessWidget {
  const _MiniBarChart({required this.bars, required this.color});
  final List<_Bar> bars;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          boxShadow: AppColors.ambientShadow,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: bars.map((b) => Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 600),
                    width: 36,
                    height: 80 * b.fraction,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: 0.15 + 0.85 * b.fraction),
                      borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(b.label, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
                ],
              )).toList(),
        ),
      );
}

class _ExportRow extends StatelessWidget {
  const _ExportRow({required this.label, required this.period});
  final String label, period;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
            child: AppButton(
              label: 'Export PDF',
              variant: AppButtonVariant.nest,
              size: AppButtonSize.small,
              icon: const Icon(Icons.picture_as_pdf_rounded, color: AppColors.error, size: 16),
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$label PDF exported'), behavior: SnackBarBehavior.floating),
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: AppButton(
              label: 'Export Excel',
              variant: AppButtonVariant.nest,
              size: AppButtonSize.small,
              icon: const Icon(Icons.table_chart_rounded, color: AppColors.secondary, size: 16),
              onPressed: () => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('$label Excel exported'), behavior: SnackBarBehavior.floating),
              ),
            ),
          ),
        ],
      );
}
