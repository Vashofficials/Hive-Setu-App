import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/app_header.dart';

class FpoMemberDetailScreen extends StatefulWidget {
  const FpoMemberDetailScreen({super.key, required this.memberId});
  final String memberId;

  @override
  State<FpoMemberDetailScreen> createState() => _FpoMemberDetailScreenState();
}

class _FpoMemberDetailScreenState extends State<FpoMemberDetailScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
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
        title: 'Ramesh Kumar',
        subtitle: 'Member ${widget.memberId}',
        badge: 'Active',
        badgeColor: AppColors.secondary,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: AppColors.fpoPurple,
          unselectedLabelColor: AppColors.onSurfaceVariant,
          indicatorColor: AppColors.fpoPurple,
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle: AppTextStyles.labelMedium,
          tabAlignment: TabAlignment.start,
          tabs: const [
            Tab(text: 'Profile'),
            Tab(text: 'Apiaries'),
            Tab(text: 'Harvests'),
            Tab(text: 'Payments'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _ProfileTab(),
          _ApiariesTab(),
          _HarvestsTab(),
          _PaymentsTab(),
        ],
      ),
    );
  }
}

// ── Profile Tab ──────────────────────────────────────────────────────────────

class _ProfileTab extends StatelessWidget {
  const _ProfileTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
      child: Column(
        children: [
          // Avatar card
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              gradient: AppColors.amberGradient,
              borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            ),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.white,
                  child: Text('R', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.primary)),
                ),
                const SizedBox(width: AppSpacing.lg),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Ramesh Kumar', style: AppTextStyles.titleLarge.copyWith(color: AppColors.white)),
                      Text('+91 9876543210', style: AppTextStyles.bodySmall.copyWith(color: AppColors.white.withValues(alpha: 0.85))),
                      Text('Member since: Jan 2023', style: AppTextStyles.caption.copyWith(color: AppColors.white.withValues(alpha: 0.7))),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          _InfoCard(items: const [
            _Item(icon: '📍', label: 'Village', value: 'Charthawal, Muzaffarnagar, UP'),
            _Item(icon: '🏛️', label: 'FPO ID', value: 'FPO-UP-2022-M482'),
            _Item(icon: '🏦', label: 'Bank Account', value: '****4821 — SBI Muzaffarnagar'),
            _Item(icon: '🆔', label: 'Aadhar', value: '****-****-4812'),
            _Item(icon: '🌾', label: 'Land Holding', value: '2.4 Acres'),
            _Item(icon: '📅', label: 'Last Active', value: '12 Apr 2026'),
          ]),
          const SizedBox(height: AppSpacing.xl),
          Text('Health Metrics', style: AppTextStyles.sectionTitle),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: const [
              Expanded(child: _MetricCard(title: 'Avg. Yield/Hive', value: '5.9 kg', icon: '🍯', color: AppColors.primary)),
              SizedBox(width: AppSpacing.md),
              Expanded(child: _MetricCard(title: 'Inspection Score', value: '87/100', icon: '🔍', color: AppColors.secondary)),
            ],
          ),
          const SizedBox(height: AppSpacing.xxl),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.items});
  final List<_Item> items;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          boxShadow: AppColors.ambientShadow,
        ),
        child: Column(
          children: items.asMap().entries.map((e) => Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                child: Row(
                  children: [
                    Text(e.value.icon, style: const TextStyle(fontSize: 18)),
                    const SizedBox(width: AppSpacing.md),
                    SizedBox(width: 100, child: Text(e.value.label, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant))),
                    Expanded(child: Text(e.value.value, style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w500))),
                  ],
                ),
              ),
              if (e.key < items.length - 1) const Divider(height: 1, color: AppColors.outlineVariant),
            ],
          )).toList(),
        ),
      );
}

class _Item {
  const _Item({required this.icon, required this.label, required this.value});
  final String icon, label, value;
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.title, required this.value, required this.icon, required this.color});
  final String title, value, icon;
  final Color color;

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
            Text(icon, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: AppSpacing.sm),
            Text(value, style: AppTextStyles.titleLarge.copyWith(color: color)),
            Text(title, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
          ],
        ),
      );
}

// ── Apiaries Tab ─────────────────────────────────────────────────────────────

class _ApiariesTab extends StatelessWidget {
  const _ApiariesTab();

  static const _apiaries = [
    _Apiary(name: 'Charthawal Farm', hives: 24, healthy: 21, atRisk: 1, honey: 142, location: 'Muzaffarnagar, UP'),
    _Apiary(name: 'Roorkee Garden', hives: 8, healthy: 7, atRisk: 1, honey: 44, location: 'Roorkee, UK'),
  ];

  @override
  Widget build(BuildContext context) => ListView.separated(
        padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
        itemCount: _apiaries.length,
        separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
        itemBuilder: (_, i) => _ApiaryCard(apiary: _apiaries[i]),
      );
}

class _Apiary {
  const _Apiary({required this.name, required this.hives, required this.healthy, required this.atRisk, required this.honey, required this.location});
  final String name, location;
  final int hives, healthy, atRisk, honey;
}

class _ApiaryCard extends StatelessWidget {
  const _ApiaryCard({required this.apiary});
  final _Apiary apiary;

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
                const Text('🏠', style: TextStyle(fontSize: 24)),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(apiary.name, style: AppTextStyles.titleSmall),
                      Text(apiary.location, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _Metric('${apiary.hives}', 'Total Hives', AppColors.primary),
                _Metric('${apiary.healthy}', 'Healthy', AppColors.secondary),
                _Metric('${apiary.atRisk}', 'At Risk', AppColors.amberAlert),
                _Metric('${apiary.honey} kg', 'Honey', AppColors.tertiary),
              ],
            ),
          ],
        ),
      );
}

class _Metric extends StatelessWidget {
  const _Metric(this.value, this.label, this.color);
  final String value, label;
  final Color color;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(value, style: AppTextStyles.titleMedium.copyWith(color: color)),
          Text(label, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
        ],
      );
}

// ── Harvests Tab ─────────────────────────────────────────────────────────────

class _HarvestsTab extends StatelessWidget {
  const _HarvestsTab();

  static const _harvests = [
    _Harvest(date: '12 Apr 2026', qty: 18, type: 'Mustard', grade: 'A', status: 'Approved'),
    _Harvest(date: '22 Mar 2026', qty: 22, type: 'Eucalyptus', grade: 'A+', status: 'Approved'),
    _Harvest(date: '10 Mar 2026', qty: 14, type: 'Mustard', grade: 'B', status: 'Submitted'),
  ];

  @override
  Widget build(BuildContext context) => ListView.separated(
        padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
        itemCount: _harvests.length,
        separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
        itemBuilder: (_, i) => _HarvestCard(h: _harvests[i]),
      );
}

class _Harvest {
  const _Harvest({required this.date, required this.qty, required this.type, required this.grade, required this.status});
  final String date, type, grade, status;
  final int qty;
}

class _HarvestCard extends StatelessWidget {
  const _HarvestCard({required this.h});
  final _Harvest h;

  @override
  Widget build(BuildContext context) {
    final approved = h.status == 'Approved';
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        boxShadow: AppColors.ambientShadow,
      ),
      child: Row(
        children: [
          const Text('🍯', style: TextStyle(fontSize: 28)),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${h.type} Honey — ${h.qty} kg', style: AppTextStyles.titleSmall),
                Text('${h.date} • Grade ${h.grade}', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: (approved ? AppColors.secondary : AppColors.amberAlert).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
            ),
            child: Text(h.status, style: AppTextStyles.labelSmall.copyWith(
              color: approved ? AppColors.secondary : AppColors.amberAlert,
              fontWeight: FontWeight.w700,
            )),
          ),
        ],
      ),
    );
  }
}

// ── Payments Tab ─────────────────────────────────────────────────────────────

class _PaymentsTab extends StatelessWidget {
  const _PaymentsTab();

  static const _payments = [
    _Payment(date: '14 Apr 2026', desc: 'Harvest Batch #B-221', amount: 5040, status: 'Paid'),
    _Payment(date: '28 Mar 2026', desc: 'Harvest Batch #B-208', amount: 6160, status: 'Paid'),
    _Payment(date: '10 Mar 2026', desc: 'Harvest Batch #B-195', amount: 3920, status: 'Pending'),
  ];

  @override
  Widget build(BuildContext context) {
    const totalPaid = 11200;
    const totalPending = 3920;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
          child: Row(
            children: const [
              Expanded(child: _PaySummary(title: 'Total Paid', value: '₹11,200', color: AppColors.secondary)),
              SizedBox(width: AppSpacing.md),
              Expanded(child: _PaySummary(title: 'Pending', value: '₹3,920', color: AppColors.amberAlert)),
            ],
          ),
        ),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPaddingH),
            itemCount: _payments.length,
            separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
            itemBuilder: (_, i) => _PaymentTile(p: _payments[i]),
          ),
        ),
      ],
    );
  }
}

class _Payment {
  const _Payment({required this.date, required this.desc, required this.amount, required this.status});
  final String date, desc, status;
  final int amount;
}

class _PaySummary extends StatelessWidget {
  const _PaySummary({required this.title, required this.value, required this.color});
  final String title, value;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: AppTextStyles.caption.copyWith(color: color)),
            Text(value, style: AppTextStyles.titleLarge.copyWith(color: color)),
          ],
        ),
      );
}

class _PaymentTile extends StatelessWidget {
  const _PaymentTile({required this.p});
  final _Payment p;

  @override
  Widget build(BuildContext context) {
    final paid = p.status == 'Paid';
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        boxShadow: AppColors.ambientShadow,
      ),
      child: Row(
        children: [
          Icon(paid ? Icons.check_circle_outline : Icons.pending_outlined,
              color: paid ? AppColors.secondary : AppColors.amberAlert,
              size: AppSpacing.iconMd),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(p.desc, style: AppTextStyles.titleSmall),
                Text(p.date, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
              ],
            ),
          ),
          Text('₹${p.amount}', style: AppTextStyles.titleSmall.copyWith(
            color: paid ? AppColors.secondary : AppColors.amberAlert,
            fontWeight: FontWeight.w700,
          )),
        ],
      ),
    );
  }
}
