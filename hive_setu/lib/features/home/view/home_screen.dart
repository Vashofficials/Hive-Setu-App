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
    NightHiveNavItem(icon: Icons.home_outlined, activeIcon: Icons.home_rounded, label: 'Home'),
    NightHiveNavItem(icon: Icons.hive_outlined, activeIcon: Icons.hive_rounded, label: 'Apiary'),
    NightHiveNavItem(icon: Icons.health_and_safety_outlined, activeIcon: Icons.health_and_safety_rounded, label: 'Health'),
    NightHiveNavItem(icon: Icons.inventory_2_outlined, activeIcon: Icons.inventory_2_rounded, label: 'Harvest'),
    NightHiveNavItem(icon: Icons.person_outline_rounded, activeIcon: Icons.person_rounded, label: 'Profile'),
  ];

  void _onNavTap(int i) {
    setState(() => _navIndex = i);
    switch (i) {
      case 1: context.push(AppRoutes.apiary);
      case 2: context.push(AppRoutes.beeHealth);
      case 3: context.push(AppRoutes.harvestLog);
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
                      _buildWeatherStrip(),
                      const SizedBox(height: AppSpacing.xl),
                      _buildColoniesOverview(),
                      const SizedBox(height: AppSpacing.xl),
                      SectionTitle(
                        title: 'Quick Actions',
                        subtitle: 'तुरंत कार्य',
                      ),
                      const SizedBox(height: AppSpacing.md),
                      _buildQuickActions(),
                      const SizedBox(height: AppSpacing.xl),
                      SectionTitle(
                        title: "Today's Tasks",
                        subtitle: 'आज के काम',
                        onTrailingTap: () => context.push(AppRoutes.calendar),
                      ),
                      const SizedBox(height: AppSpacing.md),
                      _buildTaskList(),
                      const SizedBox(height: AppSpacing.xl),
                      SectionTitle(
                        title: 'Market Prices',
                        subtitle: 'बाजार भाव',
                        onTrailingTap: () => context.push(AppRoutes.marketplace),
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
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.screenPaddingH,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'नमस्ते, Ramesh 🙏',
                      style: AppTextStyles.headlineSmall.copyWith(color: AppColors.onSurface),
                    ),
                    Text(
                      'Muzaffarnagar, Uttar Pradesh',
                      style: AppTextStyles.bodySmall.copyWith(color: AppColors.onSurfaceVariant),
                    ),
                  ],
                ),
              ),
              Stack(
                children: [
                  GestureDetector(
                    onTap: () => context.push(AppRoutes.alert),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceVariant,
                        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                      ),
                      child: const Icon(Icons.notifications_outlined, size: AppSpacing.iconMd, color: AppColors.onSurface),
                    ),
                  ),
                  Positioned(
                    top: 6,
                    right: 6,
                    child: Container(
                      width: 10,
                      height: 10,
                      decoration: const BoxDecoration(color: AppColors.error, shape: BoxShape.circle),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: AppSpacing.sm),
              GestureDetector(
                onTap: () => context.push(AppRoutes.beekeeperProfile),
                child: const CircleAvatar(
                  radius: 22,
                  backgroundColor: AppColors.primaryContainer,
                  child: Text('R', style: TextStyle(color: AppColors.white, fontWeight: FontWeight.w700, fontSize: 16)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildWeatherStrip() {
    const days = [
      _Weather(day: 'Today', icon: '☀️', high: 34, low: 22, desc: 'Clear'),
      _Weather(day: 'Tue', icon: '⛅', high: 31, low: 20, desc: 'Partly Cloudy'),
      _Weather(day: 'Wed', icon: '🌧️', high: 27, low: 19, desc: 'Light Rain'),
      _Weather(day: 'Thu', icon: '☀️', high: 33, low: 21, desc: 'Clear'),
    ];

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        gradient: AppColors.greenGradient,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.wb_sunny_outlined, color: AppColors.white, size: AppSpacing.iconSm),
              const SizedBox(width: AppSpacing.xs),
              Text('Weather Forecast', style: AppTextStyles.labelMedium.copyWith(color: AppColors.white.withValues(alpha: 0.85))),
              const Spacer(),
              Text('Muzaffarnagar', style: AppTextStyles.caption.copyWith(color: AppColors.white.withValues(alpha: 0.7))),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: days.map((w) => _WeatherDay(weather: w)).toList(),
          ),
          const SizedBox(height: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 4),
            decoration: BoxDecoration(
              color: AppColors.white.withValues(alpha: 0.15),
              borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('🌸', style: TextStyle(fontSize: 12)),
                const SizedBox(width: 4),
                Text('Mustard bloom in 8 days — good foraging window', style: AppTextStyles.caption.copyWith(color: AppColors.white)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildColoniesOverview() {
    return Container(
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Colonies Overview', style: AppTextStyles.sectionTitle),
              GestureDetector(
                onTap: () => context.push(AppRoutes.apiary),
                child: Text('View All', style: AppTextStyles.labelMedium.copyWith(color: AppColors.primary)),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(child: _ColonyStatus(count: '21', label: 'Healthy', color: AppColors.secondary, icon: '✅')),
              Expanded(child: _ColonyStatus(count: '1', label: 'At-risk', color: AppColors.amberAlert, icon: '⚠️')),
              Expanded(child: _ColonyStatus(count: '2', label: 'Critical', color: AppColors.error, icon: '🔴')),
              Expanded(child: _ColonyStatus(count: '24', label: 'Total', color: AppColors.primary, icon: '🏠')),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          // Proportional bar
          ClipRRect(
            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
            child: Row(
              children: [
                Expanded(flex: 21, child: Container(height: 6, color: AppColors.secondary)),
                Expanded(flex: 1, child: Container(height: 6, color: AppColors.amberAlert)),
                Expanded(flex: 2, child: Container(height: 6, color: AppColors.error)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions() {
    final actions = [
      _Action(label: 'Add Inspection', icon: Icons.search_rounded, route: AppRoutes.inspectionWizard, color: AppColors.primary),
      _Action(label: 'Record Harvest', icon: Icons.inventory_2_rounded, route: AppRoutes.hiveProducts, color: AppColors.secondary),
      _Action(label: 'Log Migration', icon: Icons.map_outlined, route: AppRoutes.migration, color: AppColors.govtTeal),
      _Action(label: 'Sell Honey', icon: Icons.storefront_rounded, route: AppRoutes.productsSale, color: AppColors.buyerBlue),
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
          .map((a) => _QuickAction(action: a, onTap: () => context.push(a.route)))
          .toList(),
    );
  }

  Widget _buildTaskList() {
    const tasks = [
      _Task(time: '8:00 AM', title: 'Hive H-03 Inspection', done: true, icon: '🔍'),
      _Task(time: '10:30 AM', title: 'Honey Extraction — H-05, H-06', done: false, icon: '🍯'),
      _Task(time: '2:00 PM', title: 'Feed Sugar Syrup — H-12', done: false, icon: '🌿'),
      _Task(time: '4:00 PM', title: 'Varroa treatment — H-03', done: false, icon: '💊'),
    ];

    return Column(
      children: tasks
          .map((t) => Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                child: _TaskTile(task: t),
              ))
          .toList(),
    );
  }

  Widget _buildMarketPrices() {
    const prices = [
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

// ── Data models ─────────────────────────────────────────────────────────────

class _Weather {
  const _Weather({required this.day, required this.icon, required this.high, required this.low, required this.desc});
  final String day, icon, desc;
  final int high, low;
}

class _WeatherDay extends StatelessWidget {
  const _WeatherDay({required this.weather});
  final _Weather weather;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(weather.day, style: AppTextStyles.caption.copyWith(color: AppColors.white.withValues(alpha: 0.75))),
          const SizedBox(height: 4),
          Text(weather.icon, style: const TextStyle(fontSize: 22)),
          const SizedBox(height: 4),
          Text('${weather.high}°', style: AppTextStyles.labelMedium.copyWith(color: AppColors.white, fontWeight: FontWeight.w700)),
          Text('${weather.low}°', style: AppTextStyles.caption.copyWith(color: AppColors.white.withValues(alpha: 0.65))),
        ],
      );
}

class _ColonyStatus extends StatelessWidget {
  const _ColonyStatus({required this.count, required this.label, required this.color, required this.icon});
  final String count, label, icon;
  final Color color;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(icon, style: const TextStyle(fontSize: 18)),
          const SizedBox(height: 2),
          Text(count, style: AppTextStyles.statValue.copyWith(color: color, fontSize: 22)),
          Text(label, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
        ],
      );
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
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
            boxShadow: AppColors.ambientShadow,
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
                style: AppTextStyles.labelSmall.copyWith(color: AppColors.onSurface),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      );
}

class _Task {
  const _Task({required this.time, required this.title, required this.done, required this.icon});
  final String time, title, icon;
  final bool done;
}

class _TaskTile extends StatelessWidget {
  const _TaskTile({required this.task});
  final _Task task;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          boxShadow: AppColors.ambientShadow,
        ),
        child: Row(
          children: [
            Text(task.icon, style: const TextStyle(fontSize: 22)),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    task.title,
                    style: AppTextStyles.titleSmall.copyWith(
                      color: task.done ? AppColors.onSurfaceVariant : AppColors.onSurface,
                      decoration: task.done ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  Text(task.time, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
                ],
              ),
            ),
            Container(
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                color: task.done ? AppColors.secondary.withValues(alpha: 0.15) : AppColors.surfaceVariant,
                shape: BoxShape.circle,
              ),
              child: task.done ? const Icon(Icons.check_rounded, size: 14, color: AppColors.secondary) : null,
            ),
          ],
        ),
      );
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
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
        boxShadow: AppColors.ambientShadow,
      ),
      child: Row(
        children: [
          const Text('🍯', style: TextStyle(fontSize: 20)),
          const SizedBox(width: AppSpacing.md),
          Expanded(child: Text(price.name, style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurface))),
          Text(price.price, style: AppTextStyles.titleSmall.copyWith(color: AppColors.primary, fontWeight: FontWeight.w700)),
          const SizedBox(width: AppSpacing.sm),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 2),
            decoration: BoxDecoration(
              color: isUp ? AppColors.secondary.withValues(alpha: 0.1) : AppColors.error.withValues(alpha: 0.1),
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
