import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_header.dart';
import '../../../core/widgets/app_input.dart';

class FpoBroadcastScreen extends StatelessWidget {
  const FpoBroadcastScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeader(title: 'Broadcast Advisory', subtitle: 'प्रसारण संदेश'),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(color: AppColors.fpoPurple.withValues(alpha: 0.05), borderRadius: BorderRadius.circular(AppSpacing.cardRadius), border: Border.all(color: AppColors.fpoPurple.withValues(alpha: 0.2))),
              child: Row(
                children: [
                  const Icon(Icons.campaign_rounded, color: AppColors.fpoPurple),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(child: Text('Send push notifications and SMS to all FPO members.', style: AppTextStyles.bodySmall.copyWith(color: AppColors.onSurfaceVariant))),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            AppInput(label: 'Advisory Title', controller: TextEditingController()),
            const SizedBox(height: AppSpacing.md),
            AppInput(label: 'Message Content', controller: TextEditingController(), maxLines: 5, hint: 'Write your message in Hindi/English...'),
            const SizedBox(height: AppSpacing.md),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Tag / Priority', style: AppTextStyles.inputLabel),
                const SizedBox(height: AppSpacing.xs),
                Wrap(
                  spacing: 8,
                  children: [
                    ChoiceChip(label: const Text('Weather'), selected: false, onSelected: (_) {}),
                    ChoiceChip(label: const Text('Disease Alert'), selected: true, selectedColor: AppColors.error.withValues(alpha: 0.2), labelStyle: const TextStyle(color: AppColors.error), onSelected: (_) {}),
                    ChoiceChip(label: const Text('Meeting'), selected: false, onSelected: (_) {}),
                    ChoiceChip(label: const Text('Market Rate'), selected: false, onSelected: (_) {}),
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xxl),
            AppButton(
              label: 'Send Broadcast',
              width: double.infinity,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
