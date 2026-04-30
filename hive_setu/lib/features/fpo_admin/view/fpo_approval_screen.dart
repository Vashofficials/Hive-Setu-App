import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_header.dart';

class FpoApprovalScreen extends StatelessWidget {
  const FpoApprovalScreen({super.key});

  static const _requests = [
    _Request(name: 'Ramesh Kumar', type: 'Harvest Log', desc: 'Mustard Honey • 20kg', date: 'Today, 10:00 AM'),
    _Request(name: 'Suresh K.', type: 'Member Join', desc: 'Beekeeper • 12 Hives', date: 'Yesterday'),
    _Request(name: 'Madhav Ram', type: 'Wild Harvest', desc: 'Sundarbans Honey • 18kg', date: '12 Apr 2026'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeader(title: 'Approvals & Logistics', subtitle: 'मंजूरी कतार'),
      body: ListView.separated(
        padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
        itemCount: _requests.length,
        separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
        itemBuilder: (context, i) => _RequestCard(request: _requests[i]),
      ),
    );
  }
}

class _Request {
  const _Request({required this.name, required this.type, required this.desc, required this.date});
  final String name, type, desc, date;
}

class _RequestCard extends StatelessWidget {
  const _RequestCard({required this.request});
  final _Request request;

  @override
  Widget build(BuildContext context) {
    return Container(
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(color: AppColors.amberAlert.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(AppSpacing.radiusFull)),
                child: Text(request.type, style: AppTextStyles.labelSmall.copyWith(color: AppColors.amberAlert, fontWeight: FontWeight.w700)),
              ),
              Text(request.date, style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(request.name, style: AppTextStyles.titleSmall),
          Text(request.desc, style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceVariant)),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: AppButton(
                  label: 'Reject',
                  variant: AppButtonVariant.ghost,
                  onPressed: () {},
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: AppButton(
                  label: 'Approve',
                  onPressed: () {},
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
