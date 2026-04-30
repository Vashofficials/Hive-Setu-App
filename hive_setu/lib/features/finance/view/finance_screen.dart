import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/app_header.dart';
import '../../../core/widgets/section_title.dart';

class FinanceScreen extends StatefulWidget {
  const FinanceScreen({super.key});

  @override
  State<FinanceScreen> createState() => _FinanceScreenState();
}

class _FinanceScreenState extends State<FinanceScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(
        title: 'Finance',
        subtitle: 'आय और व्यय',
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.onSurfaceVariant,
          indicatorColor: AppColors.primary,
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle: AppTextStyles.labelMedium,
          tabs: const [
            Tab(text: 'Summary'),
            Tab(text: 'Transactions'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _SummaryTab(),
          _TransactionsTab(),
        ],
      ),
    );
  }
}

// ── Summary Tab ──────────────────────────────────────────────────────────────

class _SummaryTab extends StatelessWidget {
  const _SummaryTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Net summary card
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(
              gradient: AppColors.pollenPillGradient,
              borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Net Profit — Apr 2026', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.white.withValues(alpha: 0.8))),
                const SizedBox(height: AppSpacing.sm),
                Text('₹18,400', style: AppTextStyles.statValue.copyWith(color: AppColors.white, fontSize: 36)),
                const SizedBox(height: AppSpacing.md),
                Row(
                  children: [
                    Expanded(child: _NetItem(label: 'Income', value: '₹24,500', icon: '↑', up: true)),
                    Container(width: 1, height: 40, color: AppColors.white.withValues(alpha: 0.3)),
                    Expanded(child: _NetItem(label: 'Expenses', value: '₹6,100', icon: '↓', up: false)),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),

          SectionTitle(title: 'Income by Source', subtitle: 'आय के स्रोत'),
          const SizedBox(height: AppSpacing.md),
          const _BreakdownBar(
            items: [
              _BarItem(label: 'Honey Sales', value: 18200, total: 24500, color: AppColors.primary),
              _BarItem(label: 'Wax Sales', value: 3800, total: 24500, color: AppColors.tertiary),
              _BarItem(label: 'Propolis', value: 1600, total: 24500, color: AppColors.secondary),
              _BarItem(label: 'Pollination', value: 900, total: 24500, color: AppColors.govtTeal),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),

          SectionTitle(title: 'Expenses by Category', subtitle: 'व्यय श्रेणी'),
          const SizedBox(height: AppSpacing.md),
          const _BreakdownBar(
            items: [
              _BarItem(label: 'Feed / Sugar', value: 2800, total: 6100, color: AppColors.amberAlert),
              _BarItem(label: 'Medications', value: 1400, total: 6100, color: AppColors.error),
              _BarItem(label: 'Equipment', value: 1200, total: 6100, color: AppColors.fpoPurple),
              _BarItem(label: 'Transport', value: 700, total: 6100, color: AppColors.onSurfaceVariant),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),

          SectionTitle(title: 'Monthly Trend', subtitle: 'मासिक रुझान'),
          const SizedBox(height: AppSpacing.md),
          Container(
            height: 120,
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
              boxShadow: AppColors.ambientShadow,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                _MonthBar(month: 'Nov', income: 0.6, expense: 0.4),
                _MonthBar(month: 'Dec', income: 0.5, expense: 0.3),
                _MonthBar(month: 'Jan', income: 0.7, expense: 0.5),
                _MonthBar(month: 'Feb', income: 0.8, expense: 0.4),
                _MonthBar(month: 'Mar', income: 0.75, expense: 0.35),
                _MonthBar(month: 'Apr', income: 1.0, expense: 0.25, current: true),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
        ],
      ),
    );
  }
}

class _NetItem extends StatelessWidget {
  const _NetItem({required this.label, required this.value, required this.icon, required this.up});
  final String label, value, icon;
  final bool up;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(label, style: AppTextStyles.caption.copyWith(color: AppColors.white.withValues(alpha: 0.7))),
          const SizedBox(height: 4),
          Text(value, style: AppTextStyles.titleMedium.copyWith(color: AppColors.white, fontWeight: FontWeight.w700)),
        ],
      );
}

class _BarItem {
  const _BarItem({required this.label, required this.value, required this.total, required this.color});
  final String label;
  final int value, total;
  final Color color;
}

class _BreakdownBar extends StatelessWidget {
  const _BreakdownBar({required this.items});
  final List<_BarItem> items;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          boxShadow: AppColors.ambientShadow,
        ),
        child: Column(
          children: [
            // Stacked bar
            ClipRRect(
              borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
              child: Row(
                children: items.map((item) => Expanded(
                  flex: item.value,
                  child: Container(height: 10, color: item.color),
                )).toList(),
              ),
            ),
            const SizedBox(height: AppSpacing.md),
            ...items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.xs),
              child: Row(
                children: [
                  Container(width: 10, height: 10, decoration: BoxDecoration(color: item.color, shape: BoxShape.circle)),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(child: Text(item.label, style: AppTextStyles.bodySmall)),
                  Text('₹${_fmt(item.value)}', style: AppTextStyles.labelSmall.copyWith(color: item.color, fontWeight: FontWeight.w700)),
                  const SizedBox(width: AppSpacing.sm),
                  Text('${(item.value / item.total * 100).round()}%', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
                ],
              ),
            )),
          ],
        ),
      );

  String _fmt(int v) => v >= 1000 ? '${(v / 1000).toStringAsFixed(1)}k' : '$v';
}

class _MonthBar extends StatelessWidget {
  const _MonthBar({required this.month, required this.income, required this.expense, this.current = false});
  final String month;
  final double income, expense;
  final bool current;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 10,
                height: income * 70,
                decoration: BoxDecoration(
                  color: current ? AppColors.primary : AppColors.primaryContainer.withValues(alpha: 0.4),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
              const SizedBox(width: 2),
              Container(
                width: 10,
                height: expense * 70,
                decoration: BoxDecoration(
                  color: current ? AppColors.error : AppColors.error.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(3),
                ),
              ),
            ],
          ),
          const SizedBox(height: 4),
          Text(month, style: AppTextStyles.caption.copyWith(
            color: current ? AppColors.primary : AppColors.onSurfaceVariant,
            fontWeight: current ? FontWeight.w700 : FontWeight.w400,
          )),
        ],
      );
}

// ── Transactions Tab ─────────────────────────────────────────────────────────

class _TransactionsTab extends StatelessWidget {
  const _TransactionsTab();

  static const _txns = [
    _Txn(date: '14 Apr', desc: 'Honey sold to FPO — 18 kg', amount: 5040, type: 'income', category: 'Honey Sales'),
    _Txn(date: '12 Apr', desc: 'Sugar syrup (25 kg)', amount: -875, type: 'expense', category: 'Feed'),
    _Txn(date: '10 Apr', desc: 'Mustard honey — Ramesh Traders', amount: 8400, type: 'income', category: 'Honey Sales'),
    _Txn(date: '08 Apr', desc: 'Oxalic acid treatment', amount: -350, type: 'expense', category: 'Medications'),
    _Txn(date: '05 Apr', desc: 'Beeswax — 4 kg', amount: 1800, type: 'income', category: 'Wax Sales'),
    _Txn(date: '03 Apr', desc: 'Transport — Haridwar', amount: -700, type: 'expense', category: 'Transport'),
    _Txn(date: '01 Apr', desc: 'Propolis extract — 500g', amount: 1600, type: 'income', category: 'Propolis'),
    _Txn(date: '28 Mar', desc: 'New hive box — 2 units', amount: -1200, type: 'expense', category: 'Equipment'),
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
      itemCount: _txns.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
      itemBuilder: (_, i) => _TxnTile(txn: _txns[i]),
    );
  }
}

class _Txn {
  const _Txn({required this.date, required this.desc, required this.amount, required this.type, required this.category});
  final String date, desc, type, category;
  final int amount;
}

class _TxnTile extends StatelessWidget {
  const _TxnTile({required this.txn});
  final _Txn txn;

  @override
  Widget build(BuildContext context) {
    final isIncome = txn.type == 'income';
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        boxShadow: AppColors.ambientShadow,
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isIncome ? AppColors.secondary.withValues(alpha: 0.1) : AppColors.error.withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isIncome ? Icons.arrow_upward_rounded : Icons.arrow_downward_rounded,
              color: isIncome ? AppColors.secondary : AppColors.error,
              size: AppSpacing.iconSm,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(txn.desc, style: AppTextStyles.bodyMedium, maxLines: 1, overflow: TextOverflow.ellipsis),
                Text('${txn.category} • ${txn.date}', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
              ],
            ),
          ),
          Text(
            '${isIncome ? '+' : ''}₹${txn.amount.abs()}',
            style: AppTextStyles.titleSmall.copyWith(
              color: isIncome ? AppColors.secondary : AppColors.error,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
