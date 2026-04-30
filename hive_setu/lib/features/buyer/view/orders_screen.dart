import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/router/app_router.dart';
import '../../../core/widgets/app_header.dart';

class OrdersScreen extends StatefulWidget {
  const OrdersScreen({super.key});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen>
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

  static const _all = [
    _OrderData(id: 'ORD-1041', product: 'Wild Forest Honey 2kg', fpo: 'Sundarbans FPO', status: 'Delivered', date: '10 Apr 2026', amount: 1300, emoji: '🍯'),
    _OrderData(id: 'ORD-1039', product: 'Mustard Honey 5kg', fpo: 'Muzaffarnagar FPO', status: 'In Transit', date: '07 Apr 2026', amount: 1400, emoji: '🌻'),
    _OrderData(id: 'ORD-1035', product: 'Natural Beeswax 1kg', fpo: 'Almora Beekeepers', status: 'Processing', date: '04 Apr 2026', amount: 450, emoji: '🕯️'),
    _OrderData(id: 'ORD-1030', product: 'Acacia Honey 3kg', fpo: 'Haryana FPO', status: 'Delivered', date: '28 Mar 2026', amount: 1440, emoji: '🌼'),
    _OrderData(id: 'ORD-1025', product: 'Propolis Extract', fpo: 'Bihar Beekeepers', status: 'Cancelled', date: '20 Mar 2026', amount: 320, emoji: '🟤'),
  ];

  @override
  Widget build(BuildContext context) {
    final active = _all.where((o) => o.status == 'In Transit' || o.status == 'Processing').toList();
    final delivered = _all.where((o) => o.status == 'Delivered').toList();
    final cancelled = _all.where((o) => o.status == 'Cancelled').toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(
        title: 'My Orders',
        subtitle: 'ऑर्डर इतिहास',
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.buyerBlue,
          unselectedLabelColor: AppColors.onSurfaceVariant,
          indicatorColor: AppColors.buyerBlue,
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle: AppTextStyles.labelMedium,
          tabs: [
            Tab(text: 'All (${_all.length})'),
            Tab(text: 'Active (${active.length})'),
            Tab(text: 'Delivered (${delivered.length})'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _OrderList(orders: _all),
          _OrderList(orders: active),
          _OrderList(orders: delivered),
        ],
      ),
    );
  }
}

class _OrderData {
  const _OrderData({required this.id, required this.product, required this.fpo, required this.status, required this.date, required this.amount, required this.emoji});
  final String id, product, fpo, status, date, emoji;
  final int amount;
}

class _OrderList extends StatelessWidget {
  const _OrderList({required this.orders});
  final List<_OrderData> orders;

  @override
  Widget build(BuildContext context) {
    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('📦', style: TextStyle(fontSize: 48)),
            const SizedBox(height: AppSpacing.md),
            Text('No orders here', style: AppTextStyles.titleMedium.copyWith(color: AppColors.onSurfaceVariant)),
          ],
        ),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
      itemCount: orders.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
      itemBuilder: (_, i) => _OrderCard(order: orders[i]),
    );
  }
}

class _OrderCard extends StatelessWidget {
  const _OrderCard({required this.order});
  final _OrderData order;

  Color get _statusColor => switch (order.status) {
        'Delivered' => AppColors.secondary,
        'In Transit' => AppColors.buyerBlue,
        'Processing' => AppColors.amberAlert,
        _ => AppColors.error,
      };

  IconData get _statusIcon => switch (order.status) {
        'Delivered' => Icons.check_circle_outline_rounded,
        'In Transit' => Icons.local_shipping_outlined,
        'Processing' => Icons.hourglass_empty_rounded,
        _ => Icons.cancel_outlined,
      };

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => context.push(AppRoutes.buyerOrderDetail, extra: order.id),
        child: Container(
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
                  Text(order.emoji, style: const TextStyle(fontSize: 28)),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(order.product, style: AppTextStyles.titleSmall),
                        Text(order.fpo, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: _statusColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(_statusIcon, color: _statusColor, size: 12),
                        const SizedBox(width: 4),
                        Text(order.status, style: AppTextStyles.caption.copyWith(color: _statusColor, fontWeight: FontWeight.w700)),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(order.id, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
                  Text(order.date, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
                  Text('₹${order.amount}', style: AppTextStyles.titleSmall.copyWith(color: AppColors.buyerBlue, fontWeight: FontWeight.w700)),
                ],
              ),
            ],
          ),
        ),
      );
}
