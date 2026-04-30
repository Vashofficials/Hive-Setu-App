import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/app_header.dart';

class MemberDetailScreen extends StatelessWidget {
  const MemberDetailScreen({super.key, this.memberId});
  final String? memberId;

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: AppColors.background,
        appBar: AppHeader(title: 'Member Details', subtitle: 'सदस्य विवरण'),
        body: Column(
          children: [
            // Profile Card
            Container(
              margin: const EdgeInsets.all(AppSpacing.screenPaddingH),
              padding: const EdgeInsets.all(AppSpacing.lg),
              decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppSpacing.cardRadius), boxShadow: AppColors.ambientShadow),
              child: Row(children: [
                CircleAvatar(radius: 32, backgroundColor: AppColors.fpoPurple.withValues(alpha: 0.1), child: Text('RK', style: AppTextStyles.titleMedium.copyWith(color: AppColors.fpoPurple, fontWeight: FontWeight.w700))),
                const SizedBox(width: AppSpacing.lg),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Ramesh Kumar', style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.w700)),
                  Text('Muzaffarnagar, UP', style: AppTextStyles.bodySmall.copyWith(color: AppColors.onSurfaceVariant)),
                  const SizedBox(height: AppSpacing.xs),
                  Row(children: [
                    _Badge(label: 'Active', color: AppColors.secondary),
                    const SizedBox(width: AppSpacing.sm),
                    _Badge(label: 'Since 2023', color: AppColors.fpoPurple),
                  ]),
                ])),
              ]),
            ),
            // Stats Row
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPaddingH),
              child: Row(children: const [
                Expanded(child: _MiniStat(label: 'Hives', value: '24', emoji: '🐝')),
                SizedBox(width: AppSpacing.sm),
                Expanded(child: _MiniStat(label: 'Yield/yr', value: '380 kg', emoji: '🍯')),
                SizedBox(width: AppSpacing.sm),
                Expanded(child: _MiniStat(label: 'Revenue', value: '₹1.2L', emoji: '📈')),
              ]),
            ),
            const SizedBox(height: AppSpacing.lg),
            // Tabs
            Container(
              color: AppColors.surface,
              child: const TabBar(
                labelColor: AppColors.fpoPurple, unselectedLabelColor: AppColors.onSurfaceVariant, indicatorColor: AppColors.fpoPurple,
                tabs: [Tab(text: 'Profile'), Tab(text: 'Apiaries'), Tab(text: 'Harvests'), Tab(text: 'Payments')],
              ),
            ),
            Expanded(
              child: TabBarView(children: [
                _ProfileTab(), _ApiariesTab(), _HarvestsTab(), _PaymentsTab(),
              ]),
            ),
          ],
        ),
      ),
    );
  }
}

class _Badge extends StatelessWidget {
  const _Badge({required this.label, required this.color});
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 2),
      decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(AppSpacing.radiusFull)),
      child: Text(label, style: AppTextStyles.labelSmall.copyWith(color: color, fontWeight: FontWeight.w700)),
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({required this.label, required this.value, required this.emoji});
  final String label, value, emoji;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppSpacing.radiusMd), boxShadow: AppColors.ambientShadow),
      child: Column(children: [
        Text(emoji, style: const TextStyle(fontSize: 20)),
        Text(value, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.w700)),
        Text(label, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
      ]),
    );
  }
}

class _ProfileTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(padding: const EdgeInsets.all(AppSpacing.screenPaddingH), children: const [
      _InfoRow(label: 'Phone', value: '+91 98765 43210', icon: Icons.phone_rounded),
      _InfoRow(label: 'Aadhaar', value: '•••• •••• 4521', icon: Icons.badge_rounded),
      _InfoRow(label: 'Bank A/C', value: 'SBI — ••••6789', icon: Icons.account_balance_rounded),
      _InfoRow(label: 'Joined', value: 'March 15, 2023', icon: Icons.calendar_today_rounded),
      _InfoRow(label: 'Training', value: 'NBHM Certified', icon: Icons.school_rounded),
    ]);
  }
}

class _ApiariesTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final apiaries = [
      {'name': 'Mustard Field Apiary', 'hives': '12', 'loc': 'Shamli Road'},
      {'name': 'Mango Orchard Site', 'hives': '8', 'loc': 'Saharanpur'},
      {'name': 'Home Garden Apiary', 'hives': '4', 'loc': 'Muzaffarnagar'},
    ];
    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
      itemCount: apiaries.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
      itemBuilder: (_, i) => Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppSpacing.radiusMd), boxShadow: AppColors.ambientShadow),
        child: Row(children: [
          const Text('🏠', style: TextStyle(fontSize: 28)),
          const SizedBox(width: AppSpacing.md),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(apiaries[i]['name']!, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.w700)),
            Text('📍 ${apiaries[i]['loc']}', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
          ])),
          Text('${apiaries[i]['hives']} hives', style: AppTextStyles.labelMedium.copyWith(color: AppColors.primary)),
        ]),
      ),
    );
  }
}

class _HarvestsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final harvests = [
      {'date': 'Apr 20', 'type': 'Mustard', 'qty': '45 kg', 'grade': 'A'},
      {'date': 'Mar 15', 'type': 'Multiflora', 'qty': '32 kg', 'grade': 'B+'},
      {'date': 'Feb 10', 'type': 'Eucalyptus', 'qty': '28 kg', 'grade': 'A'},
    ];
    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
      itemCount: harvests.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
      itemBuilder: (_, i) => Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppSpacing.radiusMd), boxShadow: AppColors.ambientShadow),
        child: Row(children: [
          const Text('🍯', style: TextStyle(fontSize: 24)),
          const SizedBox(width: AppSpacing.md),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text('${harvests[i]['type']} Honey', style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.w700)),
            Text(harvests[i]['date']!, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
          ])),
          Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Text(harvests[i]['qty']!, style: AppTextStyles.labelMedium.copyWith(color: AppColors.primary)),
            _Badge(label: 'Grade ${harvests[i]['grade']}', color: AppColors.secondary),
          ]),
        ]),
      ),
    );
  }
}

class _PaymentsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final payments = [
      {'date': 'Apr 22', 'amount': '₹14,400', 'mode': 'UPI', 'status': 'Paid'},
      {'date': 'Mar 18', 'amount': '₹9,600', 'mode': 'Bank', 'status': 'Paid'},
      {'date': 'Feb 12', 'amount': '₹8,400', 'mode': 'UPI', 'status': 'Paid'},
    ];
    return ListView.separated(
      padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
      itemCount: payments.length,
      separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
      itemBuilder: (_, i) => Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppSpacing.radiusMd), boxShadow: AppColors.ambientShadow),
        child: Row(children: [
          Container(width: 40, height: 40, decoration: BoxDecoration(color: AppColors.secondary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(AppSpacing.radiusMd)),
            child: const Icon(Icons.payments_rounded, color: AppColors.secondary, size: 20)),
          const SizedBox(width: AppSpacing.md),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(payments[i]['amount']!, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.w700)),
            Text('${payments[i]['date']} • ${payments[i]['mode']}', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
          ])),
          _Badge(label: payments[i]['status']!, color: AppColors.secondary),
        ]),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  const _InfoRow({required this.label, required this.value, required this.icon});
  final String label, value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.lg),
      child: Row(children: [
        Container(width: 40, height: 40, decoration: BoxDecoration(color: AppColors.fpoPurple.withValues(alpha: 0.08), borderRadius: BorderRadius.circular(AppSpacing.radiusMd)),
          child: Icon(icon, color: AppColors.fpoPurple, size: 20)),
        const SizedBox(width: AppSpacing.md),
        Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(label, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
          Text(value, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w500)),
        ])),
      ]),
    );
  }
}
