import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_header.dart';

class SchemeScreen extends StatefulWidget {
  const SchemeScreen({super.key});

  @override
  State<SchemeScreen> createState() => _SchemeScreenState();
}

class _SchemeScreenState extends State<SchemeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;
  String _selectedScheme = 'All Schemes';
  String _query = '';

  static const _schemeFilters = ['All Schemes', 'NBHM Subsidy', 'PM-KISAN', 'State Beekeeping', 'Training'];

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

  static const _beneficiaries = [
    _Beneficiary(
      id: 'BNF-0041',
      name: 'Ramesh Kumar',
      scheme: 'NBHM Subsidy',
      fpo: 'Muzaffarnagar FPO',
      status: 'Verified',
      amount: 25000,
      apiary: 'Charthawal Farm',
      docs: ['Aadhar', 'Land Certificate', 'Hive Registration'],
    ),
    _Beneficiary(
      id: 'BNF-0040',
      name: 'Anita Devi',
      scheme: 'State Beekeeping',
      fpo: 'Muzaffarnagar FPO',
      status: 'Pending Verification',
      amount: 15000,
      apiary: 'Roorkee Garden',
      docs: ['Aadhar', 'Bank Passbook'],
    ),
    _Beneficiary(
      id: 'BNF-0038',
      name: 'Suresh K.',
      scheme: 'NBHM Subsidy',
      fpo: 'Muzaffarnagar FPO',
      status: 'Verified',
      amount: 25000,
      apiary: 'Muzaffarnagar Apiary',
      docs: ['Aadhar', 'Land Certificate', 'Hive Registration', 'FPO Letter'],
    ),
    _Beneficiary(
      id: 'BNF-0035',
      name: 'Priya Singh',
      scheme: 'PM-KISAN',
      fpo: 'Muzaffarnagar FPO',
      status: 'Rejected',
      amount: 6000,
      apiary: 'Shamli Colony',
      docs: ['Aadhar'],
    ),
    _Beneficiary(
      id: 'BNF-0031',
      name: 'Madhav Ram',
      scheme: 'Training',
      fpo: 'Muzaffarnagar FPO',
      status: 'Enrolled',
      amount: 0,
      apiary: '—',
      docs: ['Aadhar', 'Photo ID'],
    ),
  ];

  List<_Beneficiary> get _filtered => _beneficiaries.where((b) {
        final matchScheme = _selectedScheme == 'All Schemes' || b.scheme == _selectedScheme;
        final matchQuery = _query.isEmpty || b.name.toLowerCase().contains(_query.toLowerCase()) || b.id.toLowerCase().contains(_query.toLowerCase());
        return matchScheme && matchQuery;
      }).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(
        title: 'Scheme Beneficiaries',
        subtitle: 'योजना लाभार्थी',
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.govtTeal,
          unselectedLabelColor: AppColors.onSurfaceVariant,
          indicatorColor: AppColors.govtTeal,
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle: AppTextStyles.labelMedium,
          tabs: const [
            Tab(text: 'Beneficiaries'),
            Tab(text: 'Schemes Overview'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildBeneficiaryList(),
          _buildSchemesOverview(),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: AppColors.govtTeal,
        foregroundColor: AppColors.white,
        icon: const Icon(Icons.person_add_rounded),
        label: const Text('Add Beneficiary'),
      ),
    );
  }

  Widget _buildBeneficiaryList() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
          child: Column(
            children: [
              // Search
              TextField(
                onChanged: (v) => setState(() => _query = v),
                style: AppTextStyles.bodySmall,
                decoration: InputDecoration(
                  hintText: 'Search by name or ID...',
                  hintStyle: AppTextStyles.bodySmall.copyWith(color: AppColors.onSurfaceVariant),
                  prefixIcon: const Icon(Icons.search_rounded, color: AppColors.onSurfaceVariant),
                  filled: true,
                  fillColor: AppColors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(AppSpacing.radiusMd), borderSide: BorderSide.none),
                  enabledBorder: OutlineInputBorder(borderRadius: BorderRadius.circular(AppSpacing.radiusMd), borderSide: BorderSide.none),
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              // Scheme filter chips
              SizedBox(
                height: 36,
                child: ListView.separated(
                  scrollDirection: Axis.horizontal,
                  itemCount: _schemeFilters.length,
                  separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
                  itemBuilder: (_, i) {
                    final scheme = _schemeFilters[i];
                    final selected = _selectedScheme == scheme;
                    return GestureDetector(
                      onTap: () => setState(() => _selectedScheme = scheme),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: selected ? AppColors.govtTeal : AppColors.white,
                          borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                          border: Border.all(color: selected ? AppColors.govtTeal : AppColors.outlineVariant),
                        ),
                        child: Text(scheme, style: AppTextStyles.labelSmall.copyWith(
                          color: selected ? AppColors.white : AppColors.onSurfaceVariant,
                          fontWeight: selected ? FontWeight.w700 : FontWeight.w400,
                        )),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: _filtered.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('🔍', style: TextStyle(fontSize: 40)),
                      const SizedBox(height: AppSpacing.md),
                      Text('No beneficiaries found', style: AppTextStyles.titleSmall.copyWith(color: AppColors.onSurfaceVariant)),
                    ],
                  ),
                )
              : ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPaddingH),
                  itemCount: _filtered.length,
                  separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
                  itemBuilder: (_, i) => _BeneficiaryCard(
                    beneficiary: _filtered[i],
                    onView: () => _showDetail(context, _filtered[i]),
                  ),
                ),
        ),
      ],
    );
  }

  Widget _buildSchemesOverview() {
    const schemes = [
      _SchemeInfo(name: 'NBHM Subsidy', shortName: 'NBHM', enrolled: 28, verified: 22, amount: '₹25,000/farmer', icon: '🏛️', color: AppColors.govtTeal),
      _SchemeInfo(name: 'PM-KISAN', shortName: 'PM-KISAN', enrolled: 14, verified: 12, amount: '₹6,000/year', icon: '🌾', color: AppColors.secondary),
      _SchemeInfo(name: 'State Beekeeping Dev.', shortName: 'State', enrolled: 9, verified: 5, amount: '₹15,000/farmer', icon: '🐝', color: AppColors.primary),
      _SchemeInfo(name: 'Beekeeping Training', shortName: 'Training', enrolled: 6, verified: 6, amount: 'Free', icon: '📚', color: AppColors.fpoPurple),
    ];

    return ListView(
      padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
      children: [
        // Summary
        Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.govtTeal.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            border: Border.all(color: AppColors.govtTeal.withValues(alpha: 0.2)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _SumChip(label: 'Total\nEnrolled', value: '57', color: AppColors.govtTeal),
              _SumChip(label: 'Verified', value: '45', color: AppColors.secondary),
              _SumChip(label: 'Pending', value: '8', color: AppColors.amberAlert),
              _SumChip(label: 'Rejected', value: '4', color: AppColors.error),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        Text('Active Schemes', style: AppTextStyles.sectionTitle),
        const SizedBox(height: AppSpacing.md),
        ...schemes.map((s) => Padding(
              padding: const EdgeInsets.only(bottom: AppSpacing.md),
              child: _SchemeCard(scheme: s),
            )),
        const SizedBox(height: AppSpacing.xxl),
      ],
    );
  }

  void _showDetail(BuildContext context, _Beneficiary b) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.surface,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(AppSpacing.cardRadius))),
      builder: (_) => DraggableScrollableSheet(
        initialChildSize: 0.7,
        maxChildSize: 0.95,
        minChildSize: 0.5,
        expand: false,
        builder: (_, ctrl) => ListView(
          controller: ctrl,
          padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
          children: [
            Center(
              child: Container(width: 40, height: 4, decoration: BoxDecoration(color: AppColors.outlineVariant, borderRadius: BorderRadius.circular(2))),
            ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                CircleAvatar(
                  backgroundColor: AppColors.govtTeal.withValues(alpha: 0.1),
                  child: Text(b.name[0], style: AppTextStyles.titleMedium.copyWith(color: AppColors.govtTeal)),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(b.name, style: AppTextStyles.titleMedium),
                      Text('${b.id} • ${b.scheme}', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
                    ],
                  ),
                ),
                _StatusBadge(status: b.status),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            _DetailRow(label: 'FPO', value: b.fpo),
            _DetailRow(label: 'Apiary', value: b.apiary),
            if (b.amount > 0) _DetailRow(label: 'Benefit Amount', value: '₹${b.amount.toString()}'),
            const SizedBox(height: AppSpacing.lg),
            Text('Documents', style: AppTextStyles.sectionTitle),
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: b.docs.map((d) => Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: AppColors.secondary.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                      border: Border.all(color: AppColors.secondary.withValues(alpha: 0.2)),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.check_circle_rounded, color: AppColors.secondary, size: 12),
                        const SizedBox(width: 4),
                        Text(d, style: AppTextStyles.labelSmall.copyWith(color: AppColors.secondary)),
                      ],
                    ),
                  )).toList(),
            ),
            const SizedBox(height: AppSpacing.xl),
            if (b.status == 'Pending Verification')
              AppButton(
                label: 'Verify & Approve',
                onPressed: () => Navigator.pop(context),
                width: double.infinity,
                icon: const Icon(Icons.verified_rounded, color: AppColors.white, size: 18),
              ),
            const SizedBox(height: AppSpacing.xxl),
          ],
        ),
      ),
    );
  }
}

class _Beneficiary {
  const _Beneficiary({required this.id, required this.name, required this.scheme, required this.fpo, required this.status, required this.amount, required this.apiary, required this.docs});
  final String id, name, scheme, fpo, status, apiary;
  final int amount;
  final List<String> docs;
}

class _BeneficiaryCard extends StatelessWidget {
  const _BeneficiaryCard({required this.beneficiary, required this.onView});
  final _Beneficiary beneficiary;
  final VoidCallback onView;

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onView,
        child: Container(
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(
            color: AppColors.surface,
            borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            boxShadow: AppColors.ambientShadow,
          ),
          child: Row(
            children: [
              CircleAvatar(
                backgroundColor: AppColors.govtTeal.withValues(alpha: 0.1),
                child: Text(beneficiary.name[0], style: AppTextStyles.titleSmall.copyWith(color: AppColors.govtTeal)),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(beneficiary.name, style: AppTextStyles.titleSmall),
                    Text('${beneficiary.scheme} • ${beneficiary.id}', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
                    if (beneficiary.amount > 0)
                      Text('₹${beneficiary.amount}', style: AppTextStyles.caption.copyWith(color: AppColors.govtTeal, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _StatusBadge(status: beneficiary.status),
                  const SizedBox(height: 4),
                  const Icon(Icons.chevron_right_rounded, color: AppColors.onSurfaceVariant, size: 16),
                ],
              ),
            ],
          ),
        ),
      );
}

class _StatusBadge extends StatelessWidget {
  const _StatusBadge({required this.status});
  final String status;

  Color get _color => switch (status) {
        'Verified' || 'Enrolled' => AppColors.secondary,
        'Pending Verification' => AppColors.amberAlert,
        'Rejected' => AppColors.error,
        _ => AppColors.govtTeal,
      };

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
        decoration: BoxDecoration(
          color: _color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
        ),
        child: Text(status, style: AppTextStyles.labelSmall.copyWith(color: _color, fontWeight: FontWeight.w700)),
      );
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value});
  final String label, value;

  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
        child: Row(
          children: [
            SizedBox(width: 100, child: Text(label, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant))),
            Expanded(child: Text(value, style: AppTextStyles.bodySmall.copyWith(fontWeight: FontWeight.w500))),
          ],
        ),
      );
}

class _SchemeInfo {
  const _SchemeInfo({required this.name, required this.shortName, required this.enrolled, required this.verified, required this.amount, required this.icon, required this.color});
  final String name, shortName, amount, icon;
  final int enrolled, verified;
  final Color color;
}

class _SchemeCard extends StatelessWidget {
  const _SchemeCard({required this.scheme});
  final _SchemeInfo scheme;

  @override
  Widget build(BuildContext context) {
    final frac = scheme.verified / scheme.enrolled;
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
            children: [
              Text(scheme.icon, style: const TextStyle(fontSize: 24)),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(scheme.name, style: AppTextStyles.titleSmall),
                    Text(scheme.amount, style: AppTextStyles.caption.copyWith(color: scheme.color, fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text('${scheme.enrolled}', style: AppTextStyles.titleMedium.copyWith(color: scheme.color, fontWeight: FontWeight.w700)),
                  Text('enrolled', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('Verified: ${scheme.verified}/${scheme.enrolled}', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
              Text('${(frac * 100).toStringAsFixed(0)}%', style: AppTextStyles.caption.copyWith(color: scheme.color, fontWeight: FontWeight.w600)),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: frac,
              minHeight: 6,
              backgroundColor: scheme.color.withValues(alpha: 0.1),
              valueColor: AlwaysStoppedAnimation<Color>(scheme.color),
            ),
          ),
        ],
      ),
    );
  }
}

class _SumChip extends StatelessWidget {
  const _SumChip({required this.label, required this.value, required this.color});
  final String label, value;
  final Color color;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(value, style: AppTextStyles.titleLarge.copyWith(color: color, fontWeight: FontWeight.w700)),
          Text(label, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant, height: 1.2), textAlign: TextAlign.center),
        ],
      );
}
