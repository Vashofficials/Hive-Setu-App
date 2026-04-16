import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/app_header.dart';

class BeeHealthScreen extends StatelessWidget {
  const BeeHealthScreen({super.key});

  static const _pests = [
    _Pest(name: 'Varroa Mite', emoji: '🔴', risk: 'High', symptoms: 'Deformed wings, reduced colony size', treatment: 'Oxalic acid, Apivar strips'),
    _Pest(name: 'American Foulbrood', emoji: '🟡', risk: 'Medium', symptoms: 'Sunken cappings, ropy test positive', treatment: 'Burn infected combs, antibiotic'),
    _Pest(name: 'Nosema', emoji: '🟡', risk: 'Medium', symptoms: 'Dysentery, crawling bees near entrance', treatment: 'Fumagillin, clean water source'),
    _Pest(name: 'Small Hive Beetle', emoji: '🟠', risk: 'Medium', symptoms: 'Slimey mess, fermentation smell', treatment: 'Beetle traps, strong colonies'),
    _Pest(name: 'Tropilaelaps', emoji: '🔴', risk: 'High', symptoms: 'Similar to Varroa, brood damage', treatment: 'Broodless treatment, miticides'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeader(title: 'Bee Health & Pests', subtitle: 'मधुमक्खी स्वास्थ्य'),
      body: ListView.separated(
        padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
        itemCount: _pests.length,
        separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
        itemBuilder: (_, i) => _PestCard(pest: _pests[i]),
      ),
    );
  }
}

class _Pest {
  const _Pest({required this.name, required this.emoji, required this.risk, required this.symptoms, required this.treatment});
  final String name, emoji, risk, symptoms, treatment;
}

class _PestCard extends StatefulWidget {
  const _PestCard({required this.pest});
  final _Pest pest;
  @override
  State<_PestCard> createState() => _PestCardState();
}

class _PestCardState extends State<_PestCard> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final riskColor = widget.pest.risk == 'High' ? AppColors.error : AppColors.amberAlert;
    return GestureDetector(
      onTap: () => setState(() => _expanded = !_expanded),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(AppSpacing.md),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
          border: Border.all(color: AppColors.outlineVariant),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(widget.pest.emoji, style: const TextStyle(fontSize: 28)),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.pest.name, style: AppTextStyles.titleSmall),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(color: riskColor.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(AppSpacing.radiusFull)),
                        child: Text('${widget.pest.risk} Risk', style: AppTextStyles.labelSmall.copyWith(color: riskColor, fontWeight: FontWeight.w700)),
                      ),
                    ],
                  ),
                ),
                Icon(_expanded ? Icons.expand_less_rounded : Icons.expand_more_rounded, color: AppColors.onSurfaceVariant),
              ],
            ),
            if (_expanded) ...[
              const SizedBox(height: AppSpacing.md),
              const Divider(color: AppColors.outlineVariant),
              const SizedBox(height: AppSpacing.sm),
              _DetailRow(label: 'Symptoms', value: widget.pest.symptoms, icon: '🔍'),
              const SizedBox(height: AppSpacing.sm),
              _DetailRow(label: 'Treatment', value: widget.pest.treatment, icon: '💊'),
            ],
          ],
        ),
      ),
    );
  }
}

class _DetailRow extends StatelessWidget {
  const _DetailRow({required this.label, required this.value, required this.icon});
  final String label, value, icon;
  @override
  Widget build(BuildContext context) => Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(icon, style: const TextStyle(fontSize: 16)),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: AppTextStyles.labelSmall.copyWith(color: AppColors.onSurfaceVariant)),
                Text(value, style: AppTextStyles.bodySmall),
              ],
            ),
          ),
        ],
      );
}
