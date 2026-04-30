import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/router/app_router.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_header.dart';

class ProductDetailScreen extends StatefulWidget {
  const ProductDetailScreen({super.key});

  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen>
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(
        title: 'Wild Forest Honey',
        showBackButton: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.favorite_border_rounded),
            onPressed: () {},
          ),
          IconButton(
            icon: const Icon(Icons.share_outlined),
            onPressed: () {},
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          labelColor: AppColors.buyerBlue,
          unselectedLabelColor: AppColors.onSurfaceVariant,
          indicatorColor: AppColors.buyerBlue,
          indicatorSize: TabBarIndicatorSize.label,
          labelStyle: AppTextStyles.labelMedium,
          tabs: const [
            Tab(text: 'Overview'),
            Tab(text: 'Traceability'),
            Tab(text: 'Quality'),
          ],
        ),
      ),
      body: Column(
        children: [
          // Product image header — shared across tabs
          Container(
            height: 200,
            width: double.infinity,
            color: AppColors.primaryContainer.withValues(alpha: 0.15),
            child: Stack(
              children: [
                const Center(child: Text('🍯', style: TextStyle(fontSize: 90))),
                Positioned(
                  bottom: AppSpacing.md,
                  left: AppSpacing.md,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.secondary,
                      borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                    ),
                    child: Text('✓ Certified Organic', style: AppTextStyles.labelSmall.copyWith(color: AppColors.white)),
                  ),
                ),
                Positioned(
                  bottom: AppSpacing.md,
                  right: AppSpacing.md,
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: AppSpacing.sm, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.onSurface.withValues(alpha: 0.6),
                      borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Icon(Icons.star_rounded, color: AppColors.amberAlert, size: 14),
                        const SizedBox(width: 2),
                        Text('4.8  (120)', style: AppTextStyles.caption.copyWith(color: AppColors.white)),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Price strip
          Container(
            color: AppColors.surface,
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPaddingH, vertical: AppSpacing.sm),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Sundarbans FPO', style: AppTextStyles.bodySmall.copyWith(color: AppColors.onSurfaceVariant)),
                    Text('₹650 / kg', style: AppTextStyles.headlineMedium.copyWith(color: AppColors.buyerBlue)),
                  ],
                ),
                Row(
                  children: [
                    AppButton(
                      label: 'Add to Cart',
                      variant: AppButtonVariant.nest,
                      size: AppButtonSize.small,
                      onPressed: () {},
                    ),
                    const SizedBox(width: AppSpacing.sm),
                    AppButton(
                      label: 'Buy Now',
                      size: AppButtonSize.small,
                      onPressed: () => context.push(AppRoutes.checkout),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Tabs
          Expanded(
            child: TabBarView(
              controller: _tabController,
              children: const [
                _OverviewTab(),
                _TraceabilityTab(),
                _QualityTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Overview Tab ─────────────────────────────────────────────────────────────

class _OverviewTab extends StatelessWidget {
  const _OverviewTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.md),
          Text('About this Product', style: AppTextStyles.sectionTitle),
          const SizedBox(height: AppSpacing.sm),
          Text(
            'Raw, unfiltered honey collected by tribal honey hunters from the deep Sundarbans mangroves. Known for its distinct woody flavor and high medicinal value. Crystallizes naturally in cold weather.',
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceVariant, height: 1.6),
          ),
          const SizedBox(height: AppSpacing.xl),
          Text('Key Highlights', style: AppTextStyles.sectionTitle),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: const [
              _Tag('Raw & Unfiltered'),
              _Tag('No Added Sugar'),
              _Tag('Forest Honey'),
              _Tag('High Antioxidants'),
              _Tag('Dark Amber Color'),
              _Tag('Low Moisture 17%'),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          Text('Nutritional Info (per 100g)', style: AppTextStyles.sectionTitle),
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
              boxShadow: AppColors.ambientShadow,
            ),
            child: Column(
              children: const [
                _NutRow(label: 'Calories', value: '304 kcal'),
                _NutRow(label: 'Carbohydrates', value: '82.4 g'),
                _NutRow(label: 'Sugars (natural)', value: '79.6 g'),
                _NutRow(label: 'Protein', value: '0.3 g'),
                _NutRow(label: 'Moisture', value: '17%'),
                _NutRow(label: 'HMF', value: '<10 mg/kg', last: true),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
        ],
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag(this.label);
  final String label;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.xs),
        decoration: BoxDecoration(
          color: AppColors.buyerBlue.withValues(alpha: 0.08),
          borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
          border: Border.all(color: AppColors.buyerBlue.withValues(alpha: 0.2)),
        ),
        child: Text(label, style: AppTextStyles.labelSmall.copyWith(color: AppColors.buyerBlue)),
      );
}

class _NutRow extends StatelessWidget {
  const _NutRow({required this.label, required this.value, this.last = false});
  final String label, value;
  final bool last;

  @override
  Widget build(BuildContext context) => Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(label, style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceVariant)),
                Text(value, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          if (!last) const Divider(height: 1, color: AppColors.outlineVariant),
        ],
      );
}

// ── Traceability Tab ─────────────────────────────────────────────────────────

class _TraceabilityTab extends StatelessWidget {
  const _TraceabilityTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.md),
          Text('Product Journey', style: AppTextStyles.sectionTitle),
          const SizedBox(height: AppSpacing.md),
          _TraceStep(step: 1, title: 'Harvested', subtitle: 'Sundarbans Forest Block A', date: '08 Apr 2026', icon: '🌿', color: AppColors.secondary),
          _TraceStep(step: 2, title: 'Collected by HC', subtitle: 'Honey Collector: Sukumar Das (HC-042)', date: '09 Apr 2026', icon: '👨‍🌾', color: AppColors.primary),
          _TraceStep(step: 3, title: 'Submitted to FPO', subtitle: 'Sundarbans FPO Processing Unit', date: '10 Apr 2026', icon: '🏭', color: AppColors.govtTeal),
          _TraceStep(step: 4, title: 'Quality Tested', subtitle: 'FSSAI Lab — Certificate FSSAI-2026-0441', date: '11 Apr 2026', icon: '🔬', color: AppColors.fpoPurple),
          _TraceStep(step: 5, title: 'Listed on Marketplace', subtitle: 'Available for purchase', date: '12 Apr 2026', icon: '🛒', color: AppColors.buyerBlue, isLast: true),
          const SizedBox(height: AppSpacing.xl),
          Text('Certifications', style: AppTextStyles.sectionTitle),
          const SizedBox(height: AppSpacing.md),
          _CertTile(cert: 'FSSAI License', number: 'FSSAI-WB-2024-88A2', issued: 'Jan 2024'),
          _CertTile(cert: 'Organic India Certified', number: 'OI/WB/2024/0042', issued: 'Feb 2024'),
          _CertTile(cert: 'FPO Registration', number: 'FPO-WB-2022-0189', issued: 'Mar 2022'),
          const SizedBox(height: AppSpacing.xxl),
        ],
      ),
    );
  }
}

class _TraceStep extends StatelessWidget {
  const _TraceStep({required this.step, required this.title, required this.subtitle, required this.date, required this.icon, required this.color, this.isLast = false});
  final int step;
  final String title, subtitle, date, icon;
  final Color color;
  final bool isLast;

  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(color: color.withValues(alpha: 0.15), shape: BoxShape.circle),
                child: Center(child: Text(icon, style: const TextStyle(fontSize: 16))),
              ),
              if (!isLast)
                Container(width: 2, height: 40, color: color.withValues(alpha: 0.2)),
            ],
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(bottom: isLast ? 0 : AppSpacing.xs),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.titleSmall),
                  Text(subtitle, style: AppTextStyles.bodySmall.copyWith(color: AppColors.onSurfaceVariant)),
                  Text(date, style: AppTextStyles.caption.copyWith(color: color, fontWeight: FontWeight.w600)),
                  const SizedBox(height: AppSpacing.md),
                ],
              ),
            ),
          ),
        ],
      );
}

class _CertTile extends StatelessWidget {
  const _CertTile({required this.cert, required this.number, required this.issued});
  final String cert, number, issued;

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          boxShadow: AppColors.ambientShadow,
        ),
        child: Row(
          children: [
            const Text('🏅', style: TextStyle(fontSize: 24)),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(cert, style: AppTextStyles.titleSmall),
                  Text(number, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
                  Text('Issued: $issued', style: AppTextStyles.caption.copyWith(color: AppColors.secondary, fontWeight: FontWeight.w600)),
                ],
              ),
            ),
            const Icon(Icons.verified_rounded, color: AppColors.secondary, size: AppSpacing.iconSm),
          ],
        ),
      );
}

// ── Quality Tab ──────────────────────────────────────────────────────────────

class _QualityTab extends StatelessWidget {
  const _QualityTab();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.all(AppSpacing.md),
            decoration: BoxDecoration(
              gradient: AppColors.greenGradient,
              borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
            ),
            child: Row(
              children: [
                const Text('🏆', style: TextStyle(fontSize: 36)),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Grade A — Premium Quality', style: AppTextStyles.titleMedium.copyWith(color: AppColors.white)),
                      Text('FSSAI Lab Certified — April 2026', style: AppTextStyles.caption.copyWith(color: AppColors.white.withValues(alpha: 0.8))),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Text('Lab Test Parameters', style: AppTextStyles.sectionTitle),
          const SizedBox(height: AppSpacing.md),
          _QualityParam(label: 'Moisture Content', value: '17%', standard: '≤20%', pass: true),
          _QualityParam(label: 'HMF (Hydroxymethylfurfural)', value: '8 mg/kg', standard: '≤40 mg/kg', pass: true),
          _QualityParam(label: 'Diastase Activity', value: '12.4 DN', standard: '≥8 DN', pass: true),
          _QualityParam(label: 'Brix (Sugar Content)', value: '82°', standard: '≥75°', pass: true),
          _QualityParam(label: 'Electrical Conductivity', value: '0.8 mS/cm', standard: '≤0.8 mS/cm', pass: true),
          _QualityParam(label: 'Antibiotic Residues', value: 'Not Detected', standard: 'Absent', pass: true),
          const SizedBox(height: AppSpacing.xl),
          Text('Customer Reviews', style: AppTextStyles.sectionTitle),
          const SizedBox(height: AppSpacing.md),
          _ReviewTile(name: 'Arjun M.', rating: 5, comment: 'Best wild honey I\'ve ever had. Pure, dark and rich. Highly recommend!', date: '08 Apr'),
          _ReviewTile(name: 'Kavitha S.', rating: 5, comment: 'Ordered for medicinal use. Authentic taste, fast delivery from FPO.', date: '01 Apr'),
          _ReviewTile(name: 'Rohan P.', rating: 4, comment: 'Very good quality. Slight crystallization which is actually a sign of purity.', date: '22 Mar'),
          const SizedBox(height: AppSpacing.xxl),
        ],
      ),
    );
  }
}

class _QualityParam extends StatelessWidget {
  const _QualityParam({required this.label, required this.value, required this.standard, required this.pass});
  final String label, value, standard;
  final bool pass;

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          boxShadow: AppColors.ambientShadow,
        ),
        child: Row(
          children: [
            Icon(pass ? Icons.check_circle_rounded : Icons.cancel_rounded,
                color: pass ? AppColors.secondary : AppColors.error,
                size: AppSpacing.iconSm),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(label, style: AppTextStyles.bodySmall),
                  Text('Standard: $standard', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
                ],
              ),
            ),
            Text(value, style: AppTextStyles.labelMedium.copyWith(
              color: pass ? AppColors.secondary : AppColors.error,
              fontWeight: FontWeight.w700,
            )),
          ],
        ),
      );
}

class _ReviewTile extends StatelessWidget {
  const _ReviewTile({required this.name, required this.rating, required this.comment, required this.date});
  final String name, comment, date;
  final int rating;

  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.md),
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
                CircleAvatar(radius: 16, backgroundColor: AppColors.buyerBlue.withValues(alpha: 0.1),
                  child: Text(name[0], style: AppTextStyles.labelMedium.copyWith(color: AppColors.buyerBlue))),
                const SizedBox(width: AppSpacing.sm),
                Text(name, style: AppTextStyles.titleSmall),
                const Spacer(),
                ...List.generate(rating, (_) => const Icon(Icons.star_rounded, color: AppColors.amberAlert, size: 14)),
                const SizedBox(width: AppSpacing.sm),
                Text(date, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
              ],
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(comment, style: AppTextStyles.bodySmall.copyWith(color: AppColors.onSurfaceVariant, height: 1.5)),
          ],
        ),
      );
}
