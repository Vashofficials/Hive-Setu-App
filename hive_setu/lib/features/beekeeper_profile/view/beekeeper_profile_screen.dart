import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_header.dart';

class BeekeeperProfileScreen extends StatelessWidget {
  const BeekeeperProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeader(title: 'My Profile', subtitle: 'मेरी प्रोफाइल', showBackButton: true),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Cover + Avatar
            Stack(
              clipBehavior: Clip.none,
              children: [
                Container(
                  height: 140,
                  width: double.infinity,
                  decoration: const BoxDecoration(gradient: AppColors.splashGradient),
                  child: const Center(child: Text('🌻🐝🌼', style: TextStyle(fontSize: 48))),
                ),
                Positioned(
                  bottom: -44,
                  left: 24,
                  child: Container(
                    width: 88, height: 88,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.surface,
                      boxShadow: AppColors.ambientShadow,
                    ),
                    child: const Center(child: Text('R', style: TextStyle(fontFamily: 'Poppins', fontSize: 36, fontWeight: FontWeight.w800, color: AppColors.primary))),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 60),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPaddingH),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Ramesh Kumar', style: AppTextStyles.headlineSmall),
                  Text('Muzaffarnagar, Uttar Pradesh', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceVariant)),
                  const SizedBox(height: AppSpacing.sm),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(AppSpacing.radiusFull)),
                    child: Text('🐝 Verified Beekeeper', style: AppTextStyles.labelMedium.copyWith(color: AppColors.primary, fontWeight: FontWeight.w700)),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  // Stats Row
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: const [
                      _ProfileStat(value: '24', label: 'Hives'),
                      _ProfileStat(value: '8 yrs', label: 'Experience'),
                      _ProfileStat(value: '142 kg', label: 'Season Yield'),
                      _ProfileStat(value: '4.8 ⭐', label: 'Rating'),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  Text('About', style: AppTextStyles.sectionTitle),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    'Experienced beekeeper from Muzaffarnagar with 8+ years of natural beekeeping. Specializes in Apis mellifera and migratory apiculture across North India.',
                    style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceVariant),
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  AppButton(label: 'Edit Profile', onPressed: () {}, variant: AppButtonVariant.nest, width: double.infinity),
                  const SizedBox(height: AppSpacing.xxl),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileStat extends StatelessWidget {
  const _ProfileStat({required this.value, required this.label});
  final String value, label;
  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(value, style: AppTextStyles.titleMedium.copyWith(color: AppColors.primary, fontWeight: FontWeight.w700)),
          Text(label, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
        ],
      );
}
