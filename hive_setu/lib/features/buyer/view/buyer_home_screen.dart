import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/router/app_router.dart';
import '../../../core/widgets/night_hive_nav.dart';
import '../../../core/widgets/offline_sync_bar.dart';
import '../../../core/widgets/section_title.dart';

class BuyerHomeScreen extends StatefulWidget {
  const BuyerHomeScreen({super.key});

  @override
  State<BuyerHomeScreen> createState() => _BuyerHomeScreenState();
}

class _BuyerHomeScreenState extends State<BuyerHomeScreen> {
  int _navIndex = 0;

  static const _navItems = [
    NightHiveNavItem(icon: Icons.home_outlined, activeIcon: Icons.home_rounded, label: 'Home'),
    NightHiveNavItem(icon: Icons.category_outlined, activeIcon: Icons.category_rounded, label: 'Browse'),
    NightHiveNavItem(icon: Icons.shopping_cart_outlined, activeIcon: Icons.shopping_cart_rounded, label: 'Cart'),
    NightHiveNavItem(icon: Icons.receipt_long_outlined, activeIcon: Icons.receipt_long_rounded, label: 'Orders'),
    NightHiveNavItem(icon: Icons.person_outline_rounded, activeIcon: Icons.person_rounded, label: 'Profile'),
  ];

  void _onNavTap(int i) {
    setState(() => _navIndex = i);
    switch (i) {
      case 1: context.push(AppRoutes.productCategories);
      case 2: context.push(AppRoutes.buyerCart);
      case 3: context.push(AppRoutes.buyerOrders);
      case 4: context.push(AppRoutes.beekeeperProfile);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Column(
        children: [
          const OfflineSyncBar(isOffline: false),
          Expanded(
            child: CustomScrollView(
              slivers: [
                _buildAppBar(),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPaddingH),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      const SizedBox(height: AppSpacing.lg),
                      _buildPromoBanner(),
                      const SizedBox(height: AppSpacing.xl),
                      _buildQuickButtons(),
                      const SizedBox(height: AppSpacing.xl),
                      SectionTitle(
                        title: 'Recommended for You',
                        subtitle: 'आपके लिए अनुशंसित',
                        onTrailingTap: () => context.push(AppRoutes.marketplace),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      _buildRecommendedProducts(),
                      const SizedBox(height: AppSpacing.xl),
                      SectionTitle(
                        title: 'Featured FPOs',
                        subtitle: 'प्रमुख एफपीओ',
                        onTrailingTap: () => context.push(AppRoutes.productCategories),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      _buildFpoList(),
                      const SizedBox(height: AppSpacing.xl),
                      SectionTitle(
                        title: 'Recent Orders',
                        subtitle: 'हाल के ऑर्डर',
                        onTrailingTap: () => context.push(AppRoutes.buyerOrders),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      _buildRecentOrders(),
                      const SizedBox(height: AppSpacing.massive),
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: NightHiveNav(
        items: _navItems,
        currentIndex: _navIndex,
        onTap: _onNavTap,
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      backgroundColor: AppColors.surface,
      floating: true,
      snap: true,
      elevation: 0,
      scrolledUnderElevation: 0,
      expandedHeight: 72,
      flexibleSpace: FlexibleSpaceBar(
        background: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPaddingH, vertical: AppSpacing.sm),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Welcome, Priya 🛒', style: AppTextStyles.headlineSmall.copyWith(color: AppColors.onSurface)),
                    Text('Mumbai, Maharashtra', style: AppTextStyles.bodySmall.copyWith(color: AppColors.onSurfaceVariant)),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () => context.push(AppRoutes.buyerCart),
                child: Stack(
                  children: [
                    Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                      ),
                      child: const Icon(Icons.shopping_cart_outlined, size: AppSpacing.iconMd, color: AppColors.onSurface),
                    ),
                    Positioned(
                      top: 6,
                      right: 6,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(color: AppColors.buyerBlue, shape: BoxShape.circle),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              const CircleAvatar(
                radius: 22,
                backgroundColor: AppColors.buyerBlue,
                child: Text('P', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w700, fontSize: 16)),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPromoBanner() {
    return Container(
      height: 130,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF1967D2), Color(0xFF4285F4)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      ),
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                  ),
                  child: Text('Limited Offer', style: AppTextStyles.labelSmall.copyWith(color: AppColors.white)),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text('Wild Honey Season\nNow Open!', style: AppTextStyles.titleLarge.copyWith(color: AppColors.white, height: 1.2)),
                const SizedBox(height: AppSpacing.sm),
                GestureDetector(
                  onTap: () => context.push(AppRoutes.productCategories),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.xs),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                    ),
                    child: Text('Shop Now', style: AppTextStyles.labelMedium.copyWith(color: AppColors.buyerBlue)),
                  ),
                ),
              ],
            ),
          ),
          const Text('🍯', style: TextStyle(fontSize: 64)),
        ],
      ),
    );
  }

  Widget _buildQuickButtons() {
    final btns = [
      _QBtn(label: 'Browse All', icon: Icons.category_rounded, color: AppColors.buyerBlue, route: AppRoutes.productCategories),
      _QBtn(label: 'Bulk Enquiry', icon: Icons.request_quote_rounded, color: AppColors.fpoPurple, route: AppRoutes.buyerBulkEnquiry),
      _QBtn(label: 'My Orders', icon: Icons.receipt_long_rounded, color: AppColors.secondary, route: AppRoutes.buyerOrders),
      _QBtn(label: 'My Cart', icon: Icons.shopping_cart_rounded, color: AppColors.primary, route: AppRoutes.buyerCart),
    ];

    return Row(
      children: btns.map((b) => Expanded(
        child: Padding(
          padding: EdgeInsets.only(right: b == btns.last ? 0 : AppSpacing.sm),
          child: GestureDetector(
            onTap: () => context.push(b.route),
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
              decoration: BoxDecoration(
                color: b.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
                border: Border.all(color: b.color.withValues(alpha: 0.2)),
              ),
              child: Column(
                children: [
                  Icon(b.icon, color: b.color, size: AppSpacing.iconMd),
                  const SizedBox(height: 4),
                  Text(b.label, style: AppTextStyles.labelSmall.copyWith(color: b.color), textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
          ),
        ),
      )).toList(),
    );
  }

  Widget _buildRecommendedProducts() {
    const products = [
      _Product(name: 'Wild Forest Honey', fpo: 'Sundarbans FPO', price: 650, rating: 4.8, emoji: '🍯'),
      _Product(name: 'Mustard Honey', fpo: 'Muzaffarnagar FPO', price: 280, rating: 4.5, emoji: '🌻'),
      _Product(name: 'Natural Beeswax', fpo: 'Almora Beekeepers', price: 450, rating: 4.9, emoji: '🕯️'),
    ];

    return SizedBox(
      height: 170,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: products.length,
        separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.md),
        itemBuilder: (_, i) => _ProductCard(product: products[i], onTap: () => context.push(AppRoutes.productDetail)),
      ),
    );
  }

  Widget _buildFpoList() {
    const fpos = [
      _Fpo(name: 'Sundarbans FPO', location: 'West Bengal', products: 12, rating: 4.8, emoji: '🌿'),
      _Fpo(name: 'Muzaffarnagar FPO', location: 'Uttar Pradesh', products: 8, rating: 4.6, emoji: '🌾'),
      _Fpo(name: 'Almora Beekeepers', location: 'Uttarakhand', products: 6, rating: 4.9, emoji: '🏔️'),
    ];

    return Column(
      children: fpos.map((f) => Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
        child: _FpoTile(fpo: f, onTap: () => context.push(AppRoutes.productCategories)),
      )).toList(),
    );
  }

  Widget _buildRecentOrders() {
    const orders = [
      _Order(id: 'ORD-1041', product: 'Wild Honey 2kg', status: 'Delivered', date: '10 Apr', amount: 1300),
      _Order(id: 'ORD-1039', product: 'Mustard Honey 5kg', status: 'In Transit', date: '07 Apr', amount: 1400),
    ];

    return Column(
      children: orders.map((o) => Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
        child: _OrderTile(order: o, onTap: () => context.push(AppRoutes.buyerOrderDetail, extra: o.id)),
      )).toList(),
    );
  }
}

// ── Data models + widgets ────────────────────────────────────────────────────

class _QBtn {
  const _QBtn({required this.label, required this.icon, required this.color, required this.route});
  final String label, route;
  final IconData icon;
  final Color color;
}

class _Product {
  const _Product({required this.name, required this.fpo, required this.price, required this.rating, required this.emoji});
  final String name, fpo, emoji;
  final int price;
  final double rating;
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.product, required this.onTap});
  final _Product product;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          width: 140,
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            boxShadow: AppColors.ambientShadow,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: AppColors.buyerBlue.withValues(alpha: 0.08),
                    borderRadius: const BorderRadius.vertical(top: Radius.circular(AppSpacing.cardRadius)),
                  ),
                  child: Center(child: Text(product.emoji, style: const TextStyle(fontSize: 40))),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(AppSpacing.sm),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(product.name, style: AppTextStyles.labelMedium, maxLines: 1, overflow: TextOverflow.ellipsis),
                    Text(product.fpo, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant), maxLines: 1, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 4),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('₹${product.price}/kg', style: AppTextStyles.labelSmall.copyWith(color: AppColors.buyerBlue, fontWeight: FontWeight.w700)),
                        Row(children: [
                          const Icon(Icons.star_rounded, color: AppColors.amberAlert, size: 12),
                          Text(product.rating.toString(), style: AppTextStyles.caption),
                        ]),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}

class _Fpo {
  const _Fpo({required this.name, required this.location, required this.products, required this.rating, required this.emoji});
  final String name, location, emoji;
  final int products;
  final double rating;
}

class _FpoTile extends StatelessWidget {
  const _FpoTile({required this.fpo, required this.onTap});
  final _Fpo fpo;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            boxShadow: AppColors.ambientShadow,
          ),
          child: Row(
            children: [
              Text(fpo.emoji, style: const TextStyle(fontSize: 28)),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(fpo.name, style: AppTextStyles.titleSmall),
                    Text('${fpo.location} • ${fpo.products} products', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
                  ],
                ),
              ),
              Row(children: [
                const Icon(Icons.star_rounded, color: AppColors.amberAlert, size: 14),
                const SizedBox(width: 2),
                Text(fpo.rating.toString(), style: AppTextStyles.labelSmall),
              ]),
              const SizedBox(width: AppSpacing.sm),
              const Icon(Icons.chevron_right_rounded, color: AppColors.onSurfaceVariant),
            ],
          ),
        ),
      );
}

class _Order {
  const _Order({required this.id, required this.product, required this.status, required this.date, required this.amount});
  final String id, product, status, date;
  final int amount;
}

class _OrderTile extends StatelessWidget {
  const _OrderTile({required this.order, required this.onTap});
  final _Order order;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final delivered = order.status == 'Delivered';
    return GestureDetector(
      onTap: onTap,
      child: Container(
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
                color: delivered ? AppColors.secondary.withValues(alpha: 0.1) : AppColors.buyerBlue.withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                delivered ? Icons.check_circle_outline_rounded : Icons.local_shipping_outlined,
                color: delivered ? AppColors.secondary : AppColors.buyerBlue,
                size: AppSpacing.iconSm,
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(order.product, style: AppTextStyles.titleSmall),
                  Text('${order.id} • ${order.date}', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text('₹${order.amount}', style: AppTextStyles.titleSmall.copyWith(color: AppColors.primary)),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  decoration: BoxDecoration(
                    color: delivered ? AppColors.secondary.withValues(alpha: 0.1) : AppColors.buyerBlue.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                  ),
                  child: Text(order.status, style: AppTextStyles.caption.copyWith(color: delivered ? AppColors.secondary : AppColors.buyerBlue, fontWeight: FontWeight.w600)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
