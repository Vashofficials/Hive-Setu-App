import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/app_header.dart';
import '../../../core/widgets/app_input.dart';

class FloraScreen extends StatefulWidget {
  const FloraScreen({super.key});
  @override
  State<FloraScreen> createState() => _FloraScreenState();
}

class _FloraScreenState extends State<FloraScreen> {
  final _search = TextEditingController();
  String _query = '';

  static const _flora = [
    _FloraItem(name: 'Mustard (Sarso)', season: 'Nov–Feb', region: 'Punjab, UP, Rajasthan', yield: 'High', emoji: '🌼'),
    _FloraItem(name: 'Litchi', season: 'Mar–Jun', region: 'Bihar, Uttarakhand', yield: 'Very High', emoji: '🍈'),
    _FloraItem(name: 'Eucalyptus', season: 'Jan–Mar', region: 'Himachal, Uttarakhand', yield: 'Medium', emoji: '🌿'),
    _FloraItem(name: 'Jamun', season: 'May–Jul', region: 'MP, UP, Rajasthan', yield: 'High', emoji: '🫐'),
    _FloraItem(name: 'Sunflower', season: 'Oct–Dec', region: 'Karnataka, Maharashtra', yield: 'High', emoji: '🌻'),
    _FloraItem(name: 'Acacia (Kikar)', season: 'Feb–Apr', region: 'Haryana, Punjab', yield: 'Very High', emoji: '🌸'),
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _query.isEmpty
        ? _flora
        : _flora.where((f) => f.name.toLowerCase().contains(_query.toLowerCase())).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeader(title: 'Flora Identification', subtitle: 'वनस्पति पहचान'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
            child: AppInput(
              controller: _search,
              hint: 'Search plants...',
              prefixIcon: const Icon(Icons.search_rounded, size: AppSpacing.iconSm, color: AppColors.onSurfaceVariant),
              onChanged: (v) => setState(() => _query = v),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPaddingH),
              itemCount: filtered.length,
              separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
              itemBuilder: (_, i) => _FloraCard(item: filtered[i]),
            ),
          ),
        ],
      ),
    );
  }
}

class _FloraItem {
  const _FloraItem({required this.name, required this.season, required this.region, required this.yield, required this.emoji});
  final String name, season, region, yield, emoji;
}

class _FloraCard extends StatelessWidget {
  const _FloraCard({required this.item});
  final _FloraItem item;

  @override
  Widget build(BuildContext context) {
    final yieldColor = item.yield == 'Very High' ? AppColors.secondary : AppColors.primary;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        boxShadow: AppColors.ambientShadow,
      ),
      child: Row(
        children: [
          Container(
            width: 56, height: 56,
            decoration: BoxDecoration(color: AppColors.secondary.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(AppSpacing.radiusLg)),
            child: Center(child: Text(item.emoji, style: const TextStyle(fontSize: 28))),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(item.name, style: AppTextStyles.titleSmall),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(color: yieldColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(AppSpacing.radiusFull)),
                      child: Text(item.yield, style: AppTextStyles.labelSmall.copyWith(color: yieldColor, fontWeight: FontWeight.w700)),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Text('Season: ${item.season}', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
                Text('Region: ${item.region}', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
