import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/router/app_router.dart';
import '../../../core/widgets/night_hive_nav.dart';
import '../../../core/widgets/offline_sync_bar.dart';
import '../../../core/widgets/section_title.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _navIndex = 0;

  static const _navItems = [
    NightHiveNavItem(
      icon: Icons.home_outlined,
      activeIcon: Icons.home_rounded,
      label: 'Home',
    ),
    NightHiveNavItem(
      icon: Icons.hive_outlined,
      activeIcon: Icons.hive_rounded,
      label: 'Apiary',
    ),
    NightHiveNavItem(
      icon: Icons.calendar_today_outlined,
      activeIcon: Icons.calendar_today_rounded,
      label: 'Calendar',
    ),
    NightHiveNavItem(
      icon: Icons.store_outlined,
      activeIcon: Icons.store_rounded,
      label: 'Market',
    ),
    NightHiveNavItem(
      icon: Icons.person_outline_rounded,
      activeIcon: Icons.person_rounded,
      label: 'Profile',
    ),
  ];

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
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.screenPaddingH,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildListDelegate([
                      const SizedBox(height: AppSpacing.lg),
                      _buildAlertBanner(),
                      const SizedBox(height: AppSpacing.xl),
                      _buildStatCards(),
                      const SizedBox(height: AppSpacing.xl),
                      SectionTitle(
                        title: 'Quick Actions',
                        subtitle: 'तुरंत कार्य',
                      ),
                      const SizedBox(height: AppSpacing.md),
                      _buildQuickActions(),
                      const SizedBox(height: AppSpacing.xl),
                      SectionTitle(
                        title: 'Today\'s Activity',
                        subtitle: 'आज की गतिविधि',
                        onTrailingTap: () => context.push(AppRoutes.calendar),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      _buildActivityList(),
                      const SizedBox(height: AppSpacing.xl),
                      SectionTitle(
                        title: 'Market Prices',
                        subtitle: 'बाजार भाव',
                        onTrailingTap: () =>
                            context.push(AppRoutes.marketplace),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      _buildMarketPrices(),
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
        onTap: (i) {
          setState(() => _navIndex = i);
          switch (i) {
            case 1: context.push(AppRoutes.apiary); break;
            case 2: context.push(AppRoutes.calendar); break;
            case 3: context.push(AppRoutes.marketplace); break;
            case 4: context.push(AppRoutes.beekeeperProfile); break;
          }
        },
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
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenPaddingH,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'नमस्ते, Ramesh 🙏',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: AppColors.onSurface,
                      ),
                    ),
                    Text(
                      'Muzaffarnagar, Uttar Pradesh',
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 12,
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              // Notification Bell
              Stack(
                children: [
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(
                          AppSpacing.radiusMd),
                      border: Border.all(
                        color: AppColors.outlineVariant,
                      ),
                    ),
                    child: const Icon(
                      Icons.notifications_outlined,
                      size: AppSpacing.iconMd,
                      color: AppColors.onSurface,
                    ),
                  ),
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(
                        color: AppColors.error,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: AppSpacing.sm),
              CircleAvatar(
                radius: 22,
                backgroundColor: AppColors.primaryContainer,
                child: Text(
                  'R',
                  style: AppTextStyles.titleMedium.copyWith(
                    color: AppColors.white,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAlertBanner() {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.amberAlert.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(
          color: AppColors.amberAlert.withValues(alpha: 0.4),
        ),
      ),
      child: Row(
        children: [
          Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: AppColors.amberAlert.withValues(alpha: 0.2),
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: const Center(
              child: Text('⚠️', style: TextStyle(fontSize: 18)),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Varroa Alert — Check Hive 3',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: AppColors.onSurface,
                  ),
                ),
                Text(
                  'Mite infestation detected. Inspect today.',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 11,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          const Icon(
            Icons.chevron_right_rounded,
            color: AppColors.amberAlert,
          ),
        ],
      ),
    );
  }

  Widget _buildStatCards() {
    final stats = [
      _Stat(label: 'Total Hives', value: '24', icon: '🏠', color: AppColors.primary),
      _Stat(label: 'Active Colonies', value: '21', icon: '🐝', color: AppColors.secondary),
      _Stat(label: 'Honey (kg)', value: '142', icon: '🍯', color: AppColors.tertiary),
      _Stat(label: 'Alerts', value: '3', icon: '🔔', color: AppColors.error),
    ];

    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisSpacing: AppSpacing.md,
      mainAxisSpacing: AppSpacing.md,
      childAspectRatio: 1.6,
      children: stats.map((s) => _StatCard(stat: s)).toList(),
    );
  }

  Widget _buildQuickActions() {
    final actions = [
      _Action(label: 'My Apiary', icon: Icons.hive_rounded, route: AppRoutes.apiary, color: AppColors.primary),
      _Action(label: 'Log Harvest', icon: Icons.inventory_2_rounded, route: AppRoutes.hiveProducts, color: AppColors.secondary),
      _Action(label: 'Best Practices', icon: Icons.menu_book_rounded, route: AppRoutes.bestPractices, color: AppColors.govtTeal),
      _Action(label: 'Health Check', icon: Icons.health_and_safety_rounded, route: AppRoutes.beeHealth, color: AppColors.error),
      _Action(label: 'Flora Map', icon: Icons.eco_rounded, route: AppRoutes.flora, color: AppColors.secondary),
      _Action(label: 'Chat Support', icon: Icons.support_agent_rounded, route: AppRoutes.chatSupport, color: AppColors.fpoPurple),
    ];

    return GridView.count(
      crossAxisCount: 3,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: AppSpacing.md,
      crossAxisSpacing: AppSpacing.md,
      children: actions
          .map((a) => _QuickAction(
                action: a,
                onTap: () => context.push(a.route),
              ))
          .toList(),
    );
  }

  Widget _buildActivityList() {
    final activities = [
      _Activity(time: '8:00 AM', title: 'Hive 3 — Inspection', done: true, type: '🔍'),
      _Activity(time: '10:30 AM', title: 'Honey Extraction — Hives 5,6', done: false, type: '🍯'),
      _Activity(time: '2:00 PM', title: 'Feed Sugar Syrup — Hive 12', done: false, type: '🌿'),
    ];

    return Column(
      children: activities
          .map((a) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.md),
                child: _ActivityTile(activity: a),
              ))
          .toList(),
    );
  }

  Widget _buildMarketPrices() {
    final prices = [
      _Price(name: 'Mustard Honey', price: '₹280/kg', change: '+12'),
      _Price(name: 'Acacia Honey', price: '₹420/kg', change: '+5'),
      _Price(name: 'Jamun Honey', price: '₹380/kg', change: '-8'),
    ];

    return Column(
      children: prices
          .map((p) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: _PriceTile(price: p),
              ))
          .toList(),
    );
  }
}

class _Stat {
  const _Stat({required this.label, required this.value, required this.icon, required this.color});
  final String label, value, icon;
  final Color color;
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.stat});
  final _Stat stat;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(stat.icon, style: const TextStyle(fontSize: 24)),
              Container(
                width: 6,
                height: 6,
                decoration: BoxDecoration(
                  color: stat.color,
                  shape: BoxShape.circle,
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                stat.value,
                style: AppTextStyles.statValue.copyWith(color: stat.color),
              ),
              Text(
                stat.label,
                style: AppTextStyles.statLabel.copyWith(
                  color: AppColors.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _Action {
  const _Action({required this.label, required this.icon, required this.route, required this.color});
  final String label, route;
  final IconData icon;
  final Color color;
}

class _QuickAction extends StatelessWidget {
  const _QuickAction({required this.action, required this.onTap});
  final _Action action;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          border: Border.all(color: AppColors.outlineVariant),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: action.color.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
              child: Icon(action.icon, color: action.color, size: AppSpacing.iconMd),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              action.label,
              style: AppTextStyles.labelSmall.copyWith(
                color: AppColors.onSurface,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _Activity {
  const _Activity({required this.time, required this.title, required this.done, required this.type});
  final String time, title, type;
  final bool done;
}

class _ActivityTile extends StatelessWidget {
  const _ActivityTile({required this.activity});
  final _Activity activity;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Row(
        children: [
          Text(activity.type, style: const TextStyle(fontSize: 24)),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity.title,
                  style: AppTextStyles.titleSmall.copyWith(
                    color: activity.done
                        ? AppColors.onSurfaceVariant
                        : AppColors.onSurface,
                    decoration: activity.done
                        ? TextDecoration.lineThrough
                        : null,
                  ),
                ),
                Text(
                  activity.time,
                  style: AppTextStyles.caption.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: activity.done
                  ? AppColors.secondary.withValues(alpha: 0.15)
                  : AppColors.surfaceVariant,
              shape: BoxShape.circle,
              border: Border.all(
                color: activity.done
                    ? AppColors.secondary
                    : AppColors.outlineVariant,
              ),
            ),
            child: activity.done
                ? const Icon(
                    Icons.check_rounded,
                    size: 14,
                    color: AppColors.secondary,
                  )
                : null,
          ),
        ],
      ),
    );
  }
}

class _Price {
  const _Price({required this.name, required this.price, required this.change});
  final String name, price, change;
}

class _PriceTile extends StatelessWidget {
  const _PriceTile({required this.price});
  final _Price price;

  @override
  Widget build(BuildContext context) {
    final isUp = price.change.startsWith('+');
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Row(
        children: [
          const Text('🍯', style: TextStyle(fontSize: 20)),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              price.name,
              style: AppTextStyles.bodyMedium.copyWith(
                color: AppColors.onSurface,
              ),
            ),
          ),
          Text(
            price.price,
            style: AppTextStyles.titleSmall.copyWith(
              color: AppColors.primary,
              fontWeight: FontWeight.w700,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.sm,
              vertical: 2,
            ),
            decoration: BoxDecoration(
              color: isUp
                  ? AppColors.secondary.withValues(alpha: 0.1)
                  : AppColors.error.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
            ),
            child: Text(
              price.change,
              style: AppTextStyles.labelSmall.copyWith(
                color: isUp ? AppColors.secondary : AppColors.error,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
