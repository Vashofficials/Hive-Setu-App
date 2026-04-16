import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_header.dart';
import '../../../core/widgets/app_input.dart';

class HarvestDetailScreen extends StatefulWidget {
  const HarvestDetailScreen({super.key});
  @override
  State<HarvestDetailScreen> createState() => _HarvestDetailScreenState();
}

class _HarvestDetailScreenState extends State<HarvestDetailScreen> {
  final _qty = TextEditingController(text: '18');
  final _notes = TextEditingController();
  String _honeyType = 'Wild Forest';
  bool _organic = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeader(title: 'Harvest Detail', subtitle: 'HC3 — संग्रह विवरण'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Photo preview
            Container(
              height: 180,
              decoration: BoxDecoration(
                color: AppColors.surfaceVariant,
                borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                border: Border.all(color: AppColors.outlineVariant),
              ),
              child: const Center(child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [Text('📸', style: TextStyle(fontSize: 48)), Text('Geo-tagged photo attached')],
              )),
            ),
            const SizedBox(height: AppSpacing.lg),
            // Location info
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(color: AppColors.secondary.withValues(alpha: 0.07), borderRadius: BorderRadius.circular(AppSpacing.radiusLg), border: Border.all(color: AppColors.secondary.withValues(alpha: 0.2))),
              child: Row(
                children: [
                  const Icon(Icons.location_on_rounded, color: AppColors.secondary),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                    Text('Sundarbans Forest Block A', style: AppTextStyles.titleSmall),
                    Text('29.4737°N, 77.7043°E • Altitude: 142m', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
                  ])),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            AppInput(label: 'Quantity (kg)', controller: _qty, keyboardType: TextInputType.number),
            const SizedBox(height: AppSpacing.md),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Honey Type', style: AppTextStyles.inputLabel),
                const SizedBox(height: AppSpacing.xs),
                Wrap(
                  spacing: 8,
                  children: ['Wild Forest', 'Rock Honey', 'Cliff Honey', 'Tree Hollow']
                      .map((t) => ChoiceChip(
                            label: Text(t),
                            selected: _honeyType == t,
                            onSelected: (_) => setState(() => _honeyType = t),
                            selectedColor: AppColors.primaryContainer.withValues(alpha: 0.2),
                            labelStyle: AppTextStyles.chipLabel.copyWith(color: _honeyType == t ? AppColors.primary : AppColors.onSurface),
                          ))
                      .toList(),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Certified Organic', style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600)),
                Switch(value: _organic, onChanged: (v) => setState(() => _organic = v), activeColor: AppColors.secondary),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            AppInput(label: 'Notes', controller: _notes, hint: 'Any additional observations...', maxLines: 3),
            const SizedBox(height: AppSpacing.xxl),
            AppButton(label: 'Save & Submit to FPO', onPressed: () {}, width: double.infinity),
          ],
        ),
      ),
    );
  }
}
