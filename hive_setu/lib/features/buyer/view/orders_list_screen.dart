import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/app_header.dart';

class OrdersListScreen extends StatefulWidget {
  const OrdersListScreen({super.key});

  @override
  State<OrdersListScreen> createState() => _OrdersListScreenState();
}

class _OrdersListScreenState extends State<OrdersListScreen> with SingleTickerProviderStateMixin {
  late TabController _tabCtrl;
  final _tabs = ['All', 'Processing', 'Shipped', 'Delivered'];

  @override
  void initState() {
    super.initState();
    _tabCtrl = TabController(length: _tabs.length, vsync: this);
  }

  @override
  void dispose() {
    _tabCtrl.dispose();
    super.dispose();
  }

  static final _orders = [
    _Order(id: '#ORD-2853', items: 'Mustard Honey × 50kg, Acacia × 25kg', total: '₹29,113', status: 'Processing', date: 'Apr 29', color: AppColors.primary),
    _Order(id: '#ORD-2847', items: 'Mustard Honey × 100kg', total: '₹33,600', status: 'Shipped', date: 'Apr 26', color: AppColors.buyerBlue),
    _Order(id: '#ORD-2831', items: 'Beeswax × 20kg', total: '₹5,880', status: 'Delivered', date: 'Apr 22', color: AppColors.secondary),
    _Order(id: '#ORD-2819', items: 'Propolis × 5kg', total: '₹8,400', status: 'Delivered', date: 'Apr 20', color: AppColors.secondary),
    _Order(id: '#ORD-2801', items: 'Jamun Honey × 30kg', total: '₹11,970', status: 'Delivered', date: 'Apr 15', color: AppColors.secondary),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(title: 'My Orders', subtitle: 'मेरे ऑर्डर'),
      body: Column(
        children: [
          Container(
            color: AppColors.surface,
            child: TabBar(
              controller: _tabCtrl,
              labelColor: AppColors.buyerBlue,
              unselectedLabelColor: AppColors.onSurfaceVariant,
              indicatorColor: AppColors.buyerBlue,
              labelStyle: AppTextStyles.labelMedium,
              tabs: _tabs.map((t) => Tab(text: t)).toList(),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabCtrl,
              children: _tabs.map((tab) {
                final filtered = tab == 'All' ? _orders : _orders.where((o) => o.status == tab).toList();
                if (filtered.isEmpty) {
                  return Center(child: Column(mainAxisSize: MainAxisSize.min, children: [
                    const Text('📦', style: TextStyle(fontSize: 48)),
                    const SizedBox(height: AppSpacing.md),
                    Text('No $tab orders', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceVariant)),
                  ]));
                }
                return ListView.separated(
                  padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
                  itemCount: filtered.length,
                  separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
                  itemBuilder: (_, i) => _OrderCard(order: filtered[i]),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

class _Order {
  const _Order({required this.id, required this.items, required this.total, required this.status, required this.date, required this.color});
  final String id, items, total, status, date;
  final Color color;
}

class _OrderCard extends StatelessWidget {
  const _OrderCard({required this.order});
  final _Order order;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppSpacing.cardRadius), boxShadow: AppColors.ambientShadow),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(order.id, style: AppTextStyles.labelMedium.copyWith(color: AppColors.onSurface)),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 2),
            decoration: BoxDecoration(color: order.color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(AppSpacing.radiusFull)),
            child: Text(order.status, style: AppTextStyles.labelSmall.copyWith(color: order.color, fontWeight: FontWeight.w700)),
          ),
        ]),
        const SizedBox(height: AppSpacing.sm),
        Text(order.items, style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceVariant)),
        const SizedBox(height: AppSpacing.sm),
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text(order.date, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
          Text(order.total, style: AppTextStyles.titleSmall.copyWith(color: AppColors.primary, fontWeight: FontWeight.w700)),
        ]),
      ]),
    );
  }
}
