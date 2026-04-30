import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_header.dart';

class FpoStockScreen extends StatefulWidget {
  const FpoStockScreen({super.key});

  @override
  State<FpoStockScreen> createState() => _FpoStockScreenState();
}

class _FpoStockScreenState extends State<FpoStockScreen>
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
        title: 'Stock & Listings',
        subtitle: 'स्टॉक प्रबंधन',
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.fpoPurple,
          unselectedLabelColor: AppColors.onSurfaceVariant,
          indicatorColor: AppColors.fpoPurple,
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle: AppTextStyles.labelMedium,
          tabs: const [
            Tab(text: 'Stock Overview'),
            Tab(text: 'Listing Queue'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: const [
          _StockOverviewTab(),
          _ListingQueueTab(),
        ],
      ),
    );
  }
}

// ── Stock Overview Tab ────────────────────────────────────────────────────────

class _StockOverviewTab extends StatelessWidget {
  const _StockOverviewTab();

  static const _stocks = [
    _StockItem(type: 'Wild Forest Honey', qty: 312, unit: 'kg', grade: 'A+', members: 8, emoji: '🍯'),
    _StockItem(type: 'Mustard Honey', qty: 185, unit: 'kg', grade: 'A', members: 12, emoji: '🌻'),
    _StockItem(type: 'Eucalyptus Honey', qty: 94, unit: 'kg', grade: 'A', members: 5, emoji: '🌿'),
    _StockItem(type: 'Natural Beeswax', qty: 48, unit: 'kg', grade: 'B+', members: 6, emoji: '🕯️'),
    _StockItem(type: 'Propolis Extract', qty: 12, unit: 'L', grade: 'A', members: 3, emoji: '🟤'),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Summary strip
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF6B21A8), Color(0xFF9333EA)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _SummaryChip(label: 'Total Stock', value: '651 kg', icon: '📦'),
                _SummaryChip(label: 'Ready to List', value: '486 kg', icon: '✅'),
                _SummaryChip(label: 'In Transit', value: '165 kg', icon: '🚚'),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Text('By Product Type', style: AppTextStyles.sectionTitle),
          const SizedBox(height: AppSpacing.md),
          ..._stocks.map((s) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: _StockCard(stock: s),
              )),
          const SizedBox(height: AppSpacing.xxl),
        ],
      ),
    );
  }
}

class _SummaryChip extends StatelessWidget {
  const _SummaryChip({required this.label, required this.value, required this.icon});
  final String label, value, icon;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 22)),
          const SizedBox(height: 4),
          Text(value, style: AppTextStyles.titleMedium.copyWith(color: AppColors.white, fontWeight: FontWeight.w700)),
          Text(label, style: AppTextStyles.caption.copyWith(color: AppColors.white.withValues(alpha: 0.8))),
        ],
      );
}

class _StockItem {
  const _StockItem({required this.type, required this.qty, required this.unit, required this.grade, required this.members, required this.emoji});
  final String type, unit, grade, emoji;
  final int qty, members;
}

class _StockCard extends StatelessWidget {
  const _StockCard({required this.stock});
  final _StockItem stock;

  Color get _gradeColor => switch (stock.grade) {
        'A+' => AppColors.secondary,
        'A' => AppColors.govtTeal,
        _ => AppColors.amberAlert,
      };

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
            Text(stock.emoji, style: const TextStyle(fontSize: 28)),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(stock.type, style: AppTextStyles.titleSmall),
                  Text('${stock.members} members contributed', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('${stock.qty} ${stock.unit}', style: AppTextStyles.titleMedium.copyWith(color: AppColors.fpoPurple, fontWeight: FontWeight.w700)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: _gradeColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                  ),
                  child: Text('Grade ${stock.grade}', style: AppTextStyles.labelSmall.copyWith(color: _gradeColor, fontWeight: FontWeight.w700)),
                ),
              ],
            ),
          ],
        ),
      );
}

// ── Listing Queue Tab ─────────────────────────────────────────────────────────

class _ListingQueueTab extends StatefulWidget {
  const _ListingQueueTab();

  @override
  State<_ListingQueueTab> createState() => _ListingQueueTabState();
}

class _ListingQueueTabState extends State<_ListingQueueTab> {
  static final _listings = [
    _Listing(id: 'LST-081', product: 'Wild Forest Honey', member: 'Ramesh Kumar', qty: 18, grade: 'A+', price: 700, status: 'Pending'),
    _Listing(id: 'LST-080', product: 'Mustard Honey', member: 'Suresh K.', qty: 22, grade: 'A', price: 560, status: 'Pending'),
    _Listing(id: 'LST-079', product: 'Natural Beeswax', member: 'Anita Devi', qty: 5, grade: 'B+', price: 450, status: 'Approved'),
    _Listing(id: 'LST-078', product: 'Eucalyptus Honey', member: 'Madhav Ram', qty: 14, grade: 'A', price: 620, status: 'Rejected'),
  ];

  @override
  Widget build(BuildContext context) {
    final pending = _listings.where((l) => l.status == 'Pending').toList();
    final processed = _listings.where((l) => l.status != 'Pending').toList();

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
      children: [
        if (pending.isNotEmpty) ...[
          Row(
            children: [
              Expanded(child: Text('Pending Approval (${pending.length})', style: AppTextStyles.sectionTitle)),
              TextButton(
                onPressed: () => _bulkApprove(pending),
                child: Text('Approve All', style: AppTextStyles.labelMedium.copyWith(color: AppColors.fpoPurple)),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          ...pending.map((l) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: _ListingCard(
                  listing: l,
                  onApprove: () => _updateStatus(l, 'Approved'),
                  onReject: () => _updateStatus(l, 'Rejected'),
                ),
              )),
          const SizedBox(height: AppSpacing.lg),
        ],
        if (processed.isNotEmpty) ...[
          Text('Processed', style: AppTextStyles.sectionTitle),
          const SizedBox(height: AppSpacing.sm),
          ...processed.map((l) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: _ListingCard(listing: l),
              )),
        ],
        const SizedBox(height: AppSpacing.xxl),
      ],
    );
  }

  void _updateStatus(_Listing listing, String status) {
    setState(() => listing.status = status);
  }

  void _bulkApprove(List<_Listing> pending) {
    setState(() {
      for (final l in pending) {
        l.status = 'Approved';
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${pending.length} listings approved'),
        backgroundColor: AppColors.secondary,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}

class _Listing {
  _Listing({required this.id, required this.product, required this.member, required this.qty, required this.grade, required this.price, required this.status});
  final String id, product, member, grade;
  final int qty, price;
  String status;
}

class _ListingCard extends StatelessWidget {
  const _ListingCard({required this.listing, this.onApprove, this.onReject});
  final _Listing listing;
  final VoidCallback? onApprove;
  final VoidCallback? onReject;

  Color get _statusColor => switch (listing.status) {
        'Approved' => AppColors.secondary,
        'Rejected' => AppColors.error,
        _ => AppColors.amberAlert,
      };

  @override
  Widget build(BuildContext context) {
    final isPending = listing.status == 'Pending';
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        boxShadow: AppColors.ambientShadow,
        border: isPending ? Border.all(color: AppColors.fpoPurple.withValues(alpha: 0.3)) : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(listing.product, style: AppTextStyles.titleSmall),
                    Text('${listing.member} • ${listing.qty} kg • Grade ${listing.grade}', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('₹${listing.price}/kg', style: AppTextStyles.titleSmall.copyWith(color: AppColors.fpoPurple, fontWeight: FontWeight.w700)),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                    decoration: BoxDecoration(
                      color: _statusColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                    ),
                    child: Text(listing.status, style: AppTextStyles.labelSmall.copyWith(color: _statusColor, fontWeight: FontWeight.w700)),
                  ),
                ],
              ),
            ],
          ),
          if (isPending) ...[
            const SizedBox(height: AppSpacing.md),
            const Divider(height: 1, color: AppColors.outlineVariant),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Expanded(
                  child: AppButton(
                    label: 'Reject',
                    variant: AppButtonVariant.ghost,
                    size: AppButtonSize.small,
                    onPressed: onReject,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: AppButton(
                    label: 'Approve',
                    size: AppButtonSize.small,
                    onPressed: onApprove,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}
