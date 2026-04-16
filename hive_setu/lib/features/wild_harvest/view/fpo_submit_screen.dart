import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_header.dart';

class FpoSubmitScreen extends StatefulWidget {
  const FpoSubmitScreen({super.key});
  @override
  State<FpoSubmitScreen> createState() => _FpoSubmitScreenState();
}

class _FpoSubmitScreenState extends State<FpoSubmitScreen> {
  bool _signed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeader(title: 'FPO Submission', subtitle: 'HC4 — एफपीओ प्रस्तुति'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SummaryRow(label: 'FPO Name', value: 'Sundarbans Honey Producers Co-op'),
            _SummaryRow(label: 'Harvest Location', value: 'Sundarbans Forest Block A'),
            _SummaryRow(label: 'Honey Type', value: 'Wild Forest Honey'),
            _SummaryRow(label: 'Quantity', value: '18 kg'),
            _SummaryRow(label: 'Date', value: '12 April 2026'),
            _SummaryRow(label: 'Collector ID', value: 'HC-2024-001'),
            const SizedBox(height: AppSpacing.xl),
            Text('Digital Signature', style: AppTextStyles.sectionTitle),
            const SizedBox(height: AppSpacing.md),
            GestureDetector(
              onTap: () => setState(() => _signed = true),
              child: Container(
                height: 120,
                decoration: BoxDecoration(
                  color: _signed ? AppColors.secondary.withValues(alpha: 0.05) : AppColors.surfaceVariant,
                  borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                  border: Border.all(color: _signed ? AppColors.secondary : AppColors.outlineVariant, width: _signed ? 2 : 1),
                ),
                child: Center(
                  child: _signed
                      ? Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                          const Icon(Icons.check_circle_rounded, color: AppColors.secondary, size: 40),
                          const SizedBox(height: 8),
                          Text('Signed', style: AppTextStyles.titleSmall.copyWith(color: AppColors.secondary)),
                        ])
                      : Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                          const Icon(Icons.gesture_rounded, color: AppColors.onSurfaceVariant, size: 40),
                          const SizedBox(height: 8),
                          Text('Tap to sign', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceVariant)),
                        ]),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
            AppButton(label: 'Submit to FPO', onPressed: _signed ? () {} : null, width: double.infinity),
          ],
        ),
      ),
    );
  }
}

class _SummaryRow extends StatelessWidget {
  const _SummaryRow({required this.label, required this.value});
  final String label, value;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
        child: Row(
          children: [
            SizedBox(width: 130, child: Text(label, style: AppTextStyles.bodySmall.copyWith(color: AppColors.onSurfaceVariant))),
            Expanded(child: Text(value, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w600))),
          ],
        ),
      );
}
