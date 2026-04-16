import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/app_header.dart';

class BestPracticesScreen extends StatefulWidget {
  const BestPracticesScreen({super.key});
  @override
  State<BestPracticesScreen> createState() => _BestPracticesScreenState();
}

class _BestPracticesScreenState extends State<BestPracticesScreen> {
  String _selected = 'all';

  static const _categories = ['all', 'seasonal', 'health', 'feeding', 'harvesting'];

  static const _tips = [
    _Tip(title: 'Spring Inspection Checklist', category: 'seasonal', emoji: '🌸', isGood: true,
        body: 'Check for queen activity, brood pattern, and stores. Replace old combs.'),
    _Tip(title: 'Avoid Pesticide Exposure', category: 'health', emoji: '☠️', isGood: false,
        body: 'Never place hives near pesticide-treated crops. Coordinate with farmers.'),
    _Tip(title: 'Sugar Syrup Feeding Ratio', category: 'feeding', emoji: '🍬', isGood: true,
        body: 'Use 1:1 ratio in spring to stimulate brood, 2:1 in autumn for winter prep.'),
    _Tip(title: 'Harvesting at Right Moisture', category: 'harvesting', emoji: '💧', isGood: true,
        body: 'Extract honey only when moisture < 20%. Use refractometer to check.'),
    _Tip(title: 'Varroa Mite Treatment', category: 'health', emoji: '🔬', isGood: true,
        body: 'Apply oxalic acid treatment in broodless periods for best efficacy.'),
  ];

  @override
  Widget build(BuildContext context) {
    final filtered = _selected == 'all'
        ? _tips
        : _tips.where((t) => t.category == _selected).toList();

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeader(title: 'Best Practices', subtitle: 'करें और न करें'),
      body: Column(
        children: [
          SizedBox(
            height: 48,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPaddingH, vertical: 6),
              itemCount: _categories.length,
              separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
              itemBuilder: (context, i) {
                final cat = _categories[i];
                final isActive = _selected == cat;
                return GestureDetector(
                  onTap: () => setState(() => _selected = cat),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                    decoration: BoxDecoration(
                      color: isActive ? AppColors.primary : AppColors.surfaceVariant,
                      borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                      border: Border.all(color: isActive ? AppColors.primary : AppColors.outlineVariant),
                    ),
                    child: Text(
                      cat[0].toUpperCase() + cat.substring(1),
                      style: AppTextStyles.chipLabel.copyWith(
                        color: isActive ? AppColors.white : AppColors.onSurface,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
              itemCount: filtered.length,
              separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
              itemBuilder: (context, i) => _TipCard(tip: filtered[i]),
            ),
          ),
        ],
      ),
    );
  }
}

class _Tip {
  const _Tip({required this.title, required this.category, required this.emoji, required this.isGood, required this.body});
  final String title, category, emoji, body;
  final bool isGood;
}

class _TipCard extends StatelessWidget {
  const _TipCard({required this.tip});
  final _Tip tip;

  @override
  Widget build(BuildContext context) {
    final color = tip.isGood ? AppColors.secondary : AppColors.error;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        border: Border.all(color: AppColors.outlineVariant),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.03), blurRadius: 8, offset: const Offset(0, 2))],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
            ),
            child: Center(child: Text(tip.emoji, style: const TextStyle(fontSize: 22))),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(child: Text(tip.title, style: AppTextStyles.titleSmall.copyWith(color: AppColors.onSurface))),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                      ),
                      child: Text(
                        tip.isGood ? '✓ Do' : '✗ Don\'t',
                        style: AppTextStyles.labelSmall.copyWith(color: color, fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(tip.body, style: AppTextStyles.bodySmall.copyWith(color: AppColors.onSurfaceVariant)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
