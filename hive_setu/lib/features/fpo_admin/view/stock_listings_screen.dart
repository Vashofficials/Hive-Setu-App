import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/app_header.dart';

class StockListingsScreen extends StatefulWidget {
  const StockListingsScreen({super.key});

  @override
  State<StockListingsScreen> createState() => _StockListingsScreenState();
}

class _StockListingsScreenState extends State<StockListingsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(title: 'Stock & Listings', subtitle: 'स्टॉक और सूची'),
      body: Column(
        children: [
          // Aggregated Stats
          Padding(
            padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
            child: Row(children: const [
              Expanded(child: _StockStat(label: 'Total Stock', value: '1,240 kg', emoji: '🍯', color: AppColors.primary)),
              SizedBox(width: AppSpacing.md),
              Expanded(child: _StockStat(label: 'Listed', value: '820 kg', emoji: '🏷️', color: AppColors.secondary)),
              SizedBox(width: AppSpacing.md),
              Expanded(child: _StockStat(label: 'Pending', value: '6', emoji: '⏳', color: AppColors.fpoPurple)),
            ]),
          ),
          Container(
            color: AppColors.surface,
            child: TabBar(
              controller: _tabCtrl,
              labelColor: AppColors.fpoPurple, unselectedLabelColor: AppColors.onSurfaceVariant, indicatorColor: AppColors.fpoPurple,
              labelStyle: AppTextStyles.labelMedium,
              tabs: const [Tab(text: 'All Stock'), Tab(text: 'Pending'), Tab(text: 'Approved')],
            ),
          ),
          Expanded(
            child: TabBarView(controller: _tabCtrl, children: [
              _buildList(_allListings),
              _buildList(_allListings.where((l) => l.status == 'Pending').toList()),
              _buildList(_allListings.where((l) => l.status == 'Approved').toList()),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildList(List<_Listing> listings) {
    if (listings.isEmpty) {
      return Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
        const Text('📦', style: TextStyle(fontSize: 48)),
        const SizedBox(height: AppSpacing.md),
        Text('No listings', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceVariant)),
      ]));
    }
    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
      itemCount: listings.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
      itemBuilder: (_, i) => _ListingCard(listing: listings[i]),
    );
  }

  static final _allListings = [
    _Listing(product: 'Mustard Honey', member: 'Ramesh K.', qty: '45 kg', grade: 'A', status: 'Pending', date: 'Apr 28'),
    _Listing(product: 'Acacia Honey', member: 'Suresh P.', qty: '30 kg', grade: 'A', status: 'Pending', date: 'Apr 27'),
    _Listing(product: 'Multiflora Honey', member: 'Vikram S.', qty: '60 kg', grade: 'B+', status: 'Approved', date: 'Apr 25'),
    _Listing(product: 'Beeswax', member: 'Amit R.', qty: '15 kg', grade: 'A', status: 'Approved', date: 'Apr 24'),
    _Listing(product: 'Jamun Honey', member: 'Deepak T.', qty: '25 kg', grade: 'A', status: 'Pending', date: 'Apr 23'),
    _Listing(product: 'Litchi Honey', member: 'Pradeep M.', qty: '35 kg', grade: 'B+', status: 'Approved', date: 'Apr 22'),
  ];
}

class _StockStat extends StatelessWidget {
  const _StockStat({required this.label, required this.value, required this.emoji, required this.color});
  final String label, value, emoji;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppSpacing.radiusMd), boxShadow: AppColors.ambientShadow),
      child: Column(children: [
        Text(emoji, style: const TextStyle(fontSize: 20)),
        const SizedBox(height: 2),
        Text(value, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.w700, color: color)),
        Text(label, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
      ]),
    );
  }
}

class _Listing {
  const _Listing({required this.product, required this.member, required this.qty, required this.grade, required this.status, required this.date});
  final String product, member, qty, grade, status, date;
}

class _ListingCard extends StatelessWidget {
  const _ListingCard({required this.listing});
  final _Listing listing;

  @override
  Widget build(BuildContext context) {
    final isPending = listing.status == 'Pending';
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppSpacing.cardRadius), boxShadow: AppColors.ambientShadow),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          const Text('🍯', style: TextStyle(fontSize: 24)),
          const SizedBox(width: AppSpacing.md),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(listing.product, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.w700)),
            Text('by ${listing.member} • ${listing.date}', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
          ])),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 2),
            decoration: BoxDecoration(color: (isPending ? AppColors.primary : AppColors.secondary).withValues(alpha: 0.1), borderRadius: BorderRadius.circular(AppSpacing.radiusFull)),
            child: Text(listing.status, style: AppTextStyles.labelSmall.copyWith(color: isPending ? AppColors.primary : AppColors.secondary, fontWeight: FontWeight.w700)),
          ),
        ]),
        const SizedBox(height: AppSpacing.sm),
        Row(children: [
          Text('${listing.qty} • Grade ${listing.grade}', style: AppTextStyles.labelMedium.copyWith(color: AppColors.primary)),
          const Spacer(),
          if (isPending) ...[
            _ActionChip(label: 'Approve', color: AppColors.secondary, icon: Icons.check_rounded),
            const SizedBox(width: AppSpacing.sm),
            _ActionChip(label: 'Reject', color: AppColors.error, icon: Icons.close_rounded),
          ],
        ]),
      ]),
    );
  }
}

class _ActionChip extends StatelessWidget {
  const _ActionChip({required this.label, required this.color, required this.icon});
  final String label;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 4),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(AppSpacing.radiusFull)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 14, color: color),
        const SizedBox(width: 2),
        Text(label, style: AppTextStyles.labelSmall.copyWith(color: color, fontWeight: FontWeight.w700)),
      ]),
    );
  }
}
