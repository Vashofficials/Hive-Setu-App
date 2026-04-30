import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/router/app_router.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_header.dart';

class SupplierProfileScreen extends StatelessWidget {
  const SupplierProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppHeader(title: 'Supplier Profile', subtitle: 'आपूर्तिकर्ता प्रोफ़ाइल'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          // FPO Header
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppSpacing.cardRadius), boxShadow: AppColors.ambientShadow),
            child: Column(children: [
              Row(children: [
                CircleAvatar(radius: 32, backgroundColor: AppColors.fpoPurple.withValues(alpha: 0.1),
                  child: const Text('🏛️', style: TextStyle(fontSize: 28))),
                const SizedBox(width: AppSpacing.lg),
                Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Text('Western UP Beekeepers FPO', style: AppTextStyles.titleMedium.copyWith(fontWeight: FontWeight.w700)),
                  Text('Muzaffarnagar, Uttar Pradesh', style: AppTextStyles.bodySmall.copyWith(color: AppColors.onSurfaceVariant)),
                  const SizedBox(height: AppSpacing.xs),
                  Row(children: [
                    _Tag(label: 'Verified ✓', color: AppColors.secondary),
                    const SizedBox(width: AppSpacing.xs),
                    _Tag(label: 'NBHM', color: AppColors.govtTeal),
                  ]),
                ])),
              ]),
              const SizedBox(height: AppSpacing.lg),
              Row(children: const [
                Expanded(child: _MinStat(emoji: '👥', value: '482', label: 'Members')),
                Expanded(child: _MinStat(emoji: '🍯', value: '48T', label: 'Annual Yield')),
                Expanded(child: _MinStat(emoji: '⭐', value: '4.8', label: 'Rating')),
                Expanded(child: _MinStat(emoji: '📦', value: '320+', label: 'Orders')),
              ]),
            ]),
          ),
          const SizedBox(height: AppSpacing.xl),

          // Products
          Text('Products Available', style: AppTextStyles.sectionTitle),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            height: 130,
            child: ListView(scrollDirection: Axis.horizontal, children: const [
              _ProductCard(name: 'Mustard Honey', price: '₹320/kg', grade: 'A', emoji: '🍯'),
              _ProductCard(name: 'Acacia Honey', price: '₹420/kg', grade: 'A', emoji: '🌳'),
              _ProductCard(name: 'Jamun Honey', price: '₹380/kg', grade: 'A', emoji: '🫐'),
              _ProductCard(name: 'Beeswax', price: '₹280/kg', grade: 'B+', emoji: '🕯️'),
            ]),
          ),
          const SizedBox(height: AppSpacing.xl),

          // Certifications
          Text('Certifications', style: AppTextStyles.sectionTitle),
          const SizedBox(height: AppSpacing.md),
          _CertCard(title: 'FSSAI License', detail: 'License No: 12345678901234', icon: Icons.verified_user_rounded),
          _CertCard(title: 'Organic Certification', detail: 'Certified by APEDA • Valid till Dec 2026', icon: Icons.eco_rounded),
          _CertCard(title: 'NBHM Registered', detail: 'Registration No: NBHM-UP-2022-0178', icon: Icons.policy_rounded),
          const SizedBox(height: AppSpacing.xl),

          // Contact
          Text('Contact Info', style: AppTextStyles.sectionTitle),
          const SizedBox(height: AppSpacing.md),
          Container(
            padding: const EdgeInsets.all(AppSpacing.lg),
            decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppSpacing.cardRadius), boxShadow: AppColors.ambientShadow),
            child: Column(children: [
              _ContactRow(icon: Icons.phone_rounded, label: '+91 98765 43210'),
              _ContactRow(icon: Icons.email_rounded, label: 'info@wupbeekeepers.org'),
              _ContactRow(icon: Icons.language_rounded, label: 'www.wupbeekeepers.org'),
              _ContactRow(icon: Icons.location_on_rounded, label: 'Jansath Road, Muzaffarnagar 251001'),
            ]),
          ),
          const SizedBox(height: AppSpacing.xxl),

          // CTA
          AppButton(label: 'Send Bulk Enquiry', onPressed: () => context.push(AppRoutes.bulkEnquiry), width: double.infinity),
          const SizedBox(height: AppSpacing.massive),
        ]),
      ),
    );
  }
}

class _Tag extends StatelessWidget {
  const _Tag({required this.label, required this.color});
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

class _MinStat extends StatelessWidget {
  const _MinStat({required this.emoji, required this.value, required this.label});
  final String emoji, value, label;

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Text(emoji, style: const TextStyle(fontSize: 18)),
      Text(value, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.w700)),
      Text(label, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
    ]);
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({required this.name, required this.price, required this.grade, required this.emoji});
  final String name, price, grade, emoji;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130, margin: const EdgeInsets.only(right: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppSpacing.cardRadius), boxShadow: AppColors.ambientShadow),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(emoji, style: const TextStyle(fontSize: 28)),
        const Spacer(),
        Text(name, style: AppTextStyles.labelMedium.copyWith(fontWeight: FontWeight.w700)),
        Text(price, style: AppTextStyles.caption.copyWith(color: AppColors.primary)),
        _Tag(label: 'Grade $grade', color: AppColors.secondary),
      ]),
    );
  }
}

class _CertCard extends StatelessWidget {
  const _CertCard({required this.title, required this.detail, required this.icon});
  final String title, detail;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(AppSpacing.radiusMd), boxShadow: AppColors.ambientShadow),
        child: Row(children: [
          Container(width: 40, height: 40, decoration: BoxDecoration(color: AppColors.secondary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(AppSpacing.radiusMd)),
            child: Icon(icon, color: AppColors.secondary, size: 20)),
          const SizedBox(width: AppSpacing.md),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: AppTextStyles.titleSmall.copyWith(fontWeight: FontWeight.w700)),
            Text(detail, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
          ])),
        ]),
      ),
    );
  }
}

class _ContactRow extends StatelessWidget {
  const _ContactRow({required this.icon, required this.label});
  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Row(children: [
        Icon(icon, size: 18, color: AppColors.buyerBlue),
        const SizedBox(width: AppSpacing.md),
        Text(label, style: AppTextStyles.bodyMedium),
      ]),
    );
  }
}
