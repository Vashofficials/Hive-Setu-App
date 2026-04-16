import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/router/app_router.dart';
import '../../../core/widgets/app_header.dart';

class MoreScreen extends StatelessWidget {
  const MoreScreen({super.key});

  static final _items = [
    _MoreItem(icon: Icons.eco_rounded, label: 'Flora Identification', route: AppRoutes.flora, color: AppColors.secondary),
    _MoreItem(icon: Icons.health_and_safety_rounded, label: 'Bee Health & Pests', route: AppRoutes.beeHealth, color: AppColors.error),
    _MoreItem(icon: Icons.map_rounded, label: 'Location & Weather', route: AppRoutes.location, color: AppColors.govtTeal),
    _MoreItem(icon: Icons.camera_alt_rounded, label: 'Camera', route: AppRoutes.camera, color: AppColors.primary),
    _MoreItem(icon: Icons.trending_up_rounded, label: 'Migration Planning', route: AppRoutes.migration, color: AppColors.buyerBlue),
    _MoreItem(icon: Icons.store_rounded, label: 'Products for Sale', route: AppRoutes.productsSale, color: AppColors.secondary),
    _MoreItem(icon: Icons.support_agent_rounded, label: 'Chat Support', route: AppRoutes.chatSupport, color: AppColors.fpoPurple),
    _MoreItem(icon: Icons.settings_rounded, label: 'Settings', route: AppRoutes.settings, color: AppColors.onSurfaceVariant),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeader(title: 'More', subtitle: 'अधिक विकल्प', showBackButton: false),
      body: ListView.separated(
        padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
        itemCount: _items.length,
        separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.sm),
        itemBuilder: (context, i) {
          final item = _items[i];
          return GestureDetector(
            onTap: () => context.push(item.route),
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                border: Border.all(color: AppColors.outlineVariant),
              ),
              child: Row(
                children: [
                  Container(
                    width: 44, height: 44,
                    decoration: BoxDecoration(color: item.color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(AppSpacing.radiusMd)),
                    child: Icon(item.icon, color: item.color, size: AppSpacing.iconMd),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(child: Text(item.label, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600))),
                  const Icon(Icons.chevron_right_rounded, color: AppColors.onSurfaceVariant),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _MoreItem {
  const _MoreItem({required this.icon, required this.label, required this.route, required this.color});
  final IconData icon;
  final String label, route;
  final Color color;
}
