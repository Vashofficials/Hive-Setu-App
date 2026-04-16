import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/app_header.dart';

class HiveProductsScreen extends StatefulWidget {
  const HiveProductsScreen({super.key});
  @override
  State<HiveProductsScreen> createState() => _HiveProductsScreenState();
}

class _HiveProductsScreenState extends State<HiveProductsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(
        title: 'Hive Products',
        subtitle: 'उत्पाद ट्रैकिंग',
        bottom: TabBar(
          controller: _tab,
          labelColor: AppColors.primary,
          unselectedLabelColor: AppColors.onSurfaceVariant,
          indicatorColor: AppColors.primary,
          indicatorWeight: 3,
          labelStyle: AppTextStyles.labelMedium,
          tabs: const [
            Tab(text: 'Honey'),
            Tab(text: 'Wax'),
            Tab(text: 'Propolis'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tab,
        children: [
          _ProductList(items: _honeyItems),
          _ProductList(items: _waxItems),
          _ProductList(items: _propolisItems),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.primary,
        child: const Icon(Icons.add_rounded, color: AppColors.white),
      ),
    );
  }

  static const _honeyItems = [
    _Product(name: 'Mustard Honey', qty: '42 kg', date: '12 Apr 2026', hive: 'H-04,05,06'),
    _Product(name: 'Acacia Honey', qty: '28 kg', date: '05 Apr 2026', hive: 'H-01,02'),
    _Product(name: 'Jamun Honey', qty: '18 kg', date: '28 Mar 2026', hive: 'H-09,10'),
  ];
  static const _waxItems = [
    _Product(name: 'Beeswax Blocks', qty: '3.5 kg', date: '10 Apr 2026', hive: 'All'),
  ];
  static const _propolisItems = [
    _Product(name: 'Raw Propolis', qty: '450 g', date: '1 Apr 2026', hive: 'H-03'),
  ];
}

class _Product {
  const _Product({required this.name, required this.qty, required this.date, required this.hive});
  final String name, qty, date, hive;
}

class _ProductList extends StatelessWidget {
  const _ProductList({required this.items});
  final List<_Product> items;

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(child: Text('No records yet'));
    }
    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
      itemCount: items.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
      itemBuilder: (context, index) {
        final p = items[index];
        return Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            border: Border.all(color: AppColors.outlineVariant),
          ),
          child: Row(
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: AppColors.primaryContainer.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                ),
                child: const Center(child: Text('🍯', style: TextStyle(fontSize: 24))),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(p.name, style: AppTextStyles.titleSmall),
                    Text('Qty: ${p.qty}', style: AppTextStyles.bodySmall.copyWith(color: AppColors.primary, fontWeight: FontWeight.w600)),
                    Text('Hive: ${p.hive} • ${p.date}', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
                  ],
                ),
              ),
              const Icon(Icons.chevron_right_rounded, color: AppColors.onSurfaceVariant),
            ],
          ),
        );
      },
    );
  }
}
