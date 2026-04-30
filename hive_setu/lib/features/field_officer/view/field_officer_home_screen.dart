import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/router/app_router.dart';

class FieldOfficerHomeScreen extends StatefulWidget {
  const FieldOfficerHomeScreen({super.key});

  @override
  State<FieldOfficerHomeScreen> createState() => _FieldOfficerHomeScreenState();
}

class _FieldOfficerHomeScreenState extends State<FieldOfficerHomeScreen>
    with TickerProviderStateMixin {
  int _navIndex = 0;

  static const _navItems = [
    _NavItem(icon: Icons.home_rounded, label: 'Home'),
    _NavItem(icon: Icons.map_rounded, label: 'Map'),
    _NavItem(icon: Icons.assignment_rounded, label: 'Visits'),
    _NavItem(icon: Icons.card_giftcard_rounded, label: 'Schemes'),
    _NavItem(icon: Icons.bar_chart_rounded, label: 'Reports'),
  ];

  void _onNavTap(int index) {
    if (index == _navIndex) return;
    switch (index) {
      case 1: context.push(AppRoutes.districtMap); return;
      case 2: context.push(AppRoutes.fieldVisit); return;
      case 3: context.push(AppRoutes.schemeBeneficiaries); return;
      case 4: context.push(AppRoutes.alertFeed); return;
    }
    setState(() => _navIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            _buildHeader(),
            const SizedBox(height: AppSpacing.lg),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPaddingH),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildStatGrid(),
                  const SizedBox(height: AppSpacing.xl),
                  Text('District Hotspot Map', style: AppTextStyles.sectionTitle),
                  const SizedBox(height: AppSpacing.md),
                  _buildMapPlaceholder(),
                  const SizedBox(height: AppSpacing.xl),
                  Text('Open Incidents', style: AppTextStyles.sectionTitle),
                  const SizedBox(height: AppSpacing.md),
                  ..._incidents.map((inc) => Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.md),
                        child: _IncidentCard(incident: inc),
                      )),
                  const SizedBox(height: AppSpacing.xl),
                  Text("Today's Schedule", style: AppTextStyles.sectionTitle),
                  const SizedBox(height: AppSpacing.md),
                  ..._schedule.map((s) => Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: _ScheduleTile(item: s),
                      )),
                  const SizedBox(height: AppSpacing.xxl),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: _buildNav(),
    );
  }

  Widget _buildHeader() => Container(
        padding: const EdgeInsets.fromLTRB(
            AppSpacing.screenPaddingH, AppSpacing.lg, AppSpacing.screenPaddingH, AppSpacing.xl),
        decoration: const BoxDecoration(
          color: AppColors.govtTeal,
          borderRadius: BorderRadius.vertical(bottom: Radius.circular(AppSpacing.cardRadius + 4)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Field Officer', style: AppTextStyles.caption.copyWith(color: AppColors.white.withValues(alpha: 0.8))),
                    Text('Arjun Sharma', style: AppTextStyles.titleLarge.copyWith(color: AppColors.white)),
                    Text('Muzaffarnagar District, UP', style: AppTextStyles.bodySmall.copyWith(color: AppColors.white.withValues(alpha: 0.75))),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(AppSpacing.sm),
                  decoration: BoxDecoration(
                    color: AppColors.white.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                  ),
                  child: Column(
                    children: [
                      const Text('🏛️', style: TextStyle(fontSize: 22)),
                      Text('Govt.', style: AppTextStyles.caption.copyWith(color: AppColors.white)),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
              decoration: BoxDecoration(
                color: AppColors.white.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
              ),
              child: Row(
                children: [
                  const Icon(Icons.notifications_active_rounded, color: AppColors.white, size: 16),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      '3 new incidents reported in your district today',
                      style: AppTextStyles.caption.copyWith(color: AppColors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  static const _stats = [
    _Stat(label: 'Registered\nBeekeepers', value: '142', icon: '👨‍🌾', color: AppColors.govtTeal),
    _Stat(label: 'Active\nColonies', value: '1,840', icon: '🐝', color: AppColors.secondary),
    _Stat(label: 'Open\nIncidents', value: '7', icon: '⚠️', color: AppColors.error),
    _Stat(label: 'Inspections\nDue', value: '12', icon: '🔍', color: AppColors.amberAlert),
  ];

  Widget _buildStatGrid() => GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        mainAxisSpacing: AppSpacing.md,
        crossAxisSpacing: AppSpacing.md,
        childAspectRatio: 1.8,
        children: _stats.map((s) => _StatCard(stat: s)).toList(),
      );

  Widget _buildMapPlaceholder() => GestureDetector(
        onTap: () => context.push(AppRoutes.districtMap),
        child: Container(
          height: 160,
          decoration: BoxDecoration(
            color: AppColors.govtTeal.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            border: Border.all(color: AppColors.govtTeal.withValues(alpha: 0.2)),
          ),
          child: Stack(
            children: [
              Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('🗺️', style: TextStyle(fontSize: 36)),
                    const SizedBox(height: AppSpacing.sm),
                    Text('Muzaffarnagar District', style: AppTextStyles.titleSmall.copyWith(color: AppColors.govtTeal)),
                    Text('Tap to view hotspot map', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
                  ],
                ),
              ),
              // Mock hotspot dots
              Positioned(top: 40, left: 60, child: _HotDot(color: AppColors.error)),
              Positioned(top: 70, left: 120, child: _HotDot(color: AppColors.amberAlert)),
              Positioned(top: 90, right: 80, child: _HotDot(color: AppColors.error)),
              Positioned(bottom: 40, left: 90, child: _HotDot(color: AppColors.secondary)),
              Positioned(
                top: AppSpacing.sm,
                right: AppSpacing.sm,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppColors.govtTeal,
                    borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                  ),
                  child: const Text('Open Map', style: TextStyle(color: AppColors.white, fontSize: 11, fontWeight: FontWeight.w600)),
                ),
              ),
            ],
          ),
        ),
      );

  static const _incidents = [
    _Incident(id: 'INC-047', title: 'Varroa Outbreak', beekeeper: 'Ramesh Kumar', location: 'Charthawal, MZN', severity: 'High', daysAgo: 1),
    _Incident(id: 'INC-046', title: 'Pesticide Exposure', beekeeper: 'Anita Devi', location: 'Shamli Border', severity: 'Critical', daysAgo: 2),
    _Incident(id: 'INC-045', title: 'Queen Loss ×3', beekeeper: 'Suresh K.', location: 'Roorkee Garden', severity: 'Medium', daysAgo: 3),
  ];

  static const _schedule = [
    _ScheduleItem(time: '09:00 AM', title: 'Field Visit — Ramesh Kumar', location: 'Charthawal Farm', done: true),
    _ScheduleItem(time: '11:30 AM', title: 'Incident Inspection — INC-047', location: 'Charthawal, MZN', done: false),
    _ScheduleItem(time: '02:00 PM', title: 'Subsidy Verification — 5 Beekeepers', location: 'Block Office', done: false),
    _ScheduleItem(time: '04:30 PM', title: 'Colony Health Survey — Muzaffarnagar FPO', location: 'FPO Office', done: false),
  ];

  Widget _buildNav() => Container(
        decoration: BoxDecoration(
          color: AppColors.nightHive,
          boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.2), blurRadius: 12)],
        ),
        child: SafeArea(
          top: false,
          child: SizedBox(
            height: 64,
            child: Row(
              children: _navItems.asMap().entries.map((e) {
                final active = e.key == _navIndex;
                return Expanded(
                  child: GestureDetector(
                    onTap: () => _onNavTap(e.key),
                    behavior: HitTestBehavior.opaque,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(e.value.icon, size: 22, color: active ? AppColors.govtTeal : AppColors.nightHiveItem),
                        const SizedBox(height: 3),
                        Text(e.value.label, style: TextStyle(fontSize: 10, color: active ? AppColors.govtTeal : AppColors.nightHiveItem, fontWeight: active ? FontWeight.w700 : FontWeight.w400)),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      );
}

class _HotDot extends StatelessWidget {
  const _HotDot({required this.color});
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.8),
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.white, width: 1.5),
        ),
      );
}

class _NavItem {
  const _NavItem({required this.icon, required this.label});
  final IconData icon;
  final String label;
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
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          boxShadow: AppColors.ambientShadow,
        ),
        child: Row(
          children: [
            Text(stat.icon, style: const TextStyle(fontSize: 24)),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(stat.value, style: AppTextStyles.titleLarge.copyWith(color: stat.color, fontWeight: FontWeight.w700)),
                  Text(stat.label, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant, height: 1.2)),
                ],
              ),
            ),
          ],
        ),
      );
}

class _Incident {
  const _Incident({required this.id, required this.title, required this.beekeeper, required this.location, required this.severity, required this.daysAgo});
  final String id, title, beekeeper, location, severity;
  final int daysAgo;
}

class _IncidentCard extends StatelessWidget {
  const _IncidentCard({required this.incident});
  final _Incident incident;

  Color get _severityColor => switch (incident.severity) {
        'Critical' => AppColors.error,
        'High' => AppColors.amberAlert,
        _ => AppColors.govtTeal,
      };

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: () => context.push(AppRoutes.incidentDetail, extra: incident.id),
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            boxShadow: AppColors.ambientShadow,
            border: Border(left: BorderSide(color: _severityColor, width: 3)),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: _severityColor.withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                          ),
                          child: Text(incident.severity, style: AppTextStyles.labelSmall.copyWith(color: _severityColor, fontWeight: FontWeight.w700)),
                        ),
                        const SizedBox(width: AppSpacing.sm),
                        Text(incident.id, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(incident.title, style: AppTextStyles.titleSmall),
                    Text('${incident.beekeeper} • ${incident.location}', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('${incident.daysAgo}d ago', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
                  const Icon(Icons.chevron_right_rounded, color: AppColors.onSurfaceVariant),
                ],
              ),
            ],
          ),
        ),
      );
}

class _ScheduleItem {
  const _ScheduleItem({required this.time, required this.title, required this.location, required this.done});
  final String time, title, location;
  final bool done;
}

class _ScheduleTile extends StatelessWidget {
  const _ScheduleTile({required this.item});
  final _ScheduleItem item;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: item.done ? AppColors.surfaceVariant : AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
          boxShadow: item.done ? null : AppColors.ambientShadow,
        ),
        child: Row(
          children: [
            SizedBox(
              width: 68,
              child: Text(item.time, style: AppTextStyles.caption.copyWith(color: item.done ? AppColors.onSurfaceVariant : AppColors.govtTeal, fontWeight: FontWeight.w600)),
            ),
            Container(width: 1, height: 32, color: AppColors.outlineVariant),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(item.title, style: AppTextStyles.bodySmall.copyWith(
                    fontWeight: FontWeight.w500,
                    decoration: item.done ? TextDecoration.lineThrough : null,
                    color: item.done ? AppColors.onSurfaceVariant : AppColors.onSurface,
                  )),
                  Text(item.location, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
                ],
              ),
            ),
            if (item.done) const Icon(Icons.check_circle_rounded, color: AppColors.secondary, size: 18),
          ],
        ),
      );
}
