import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/app_header.dart';
import '../../../core/widgets/app_input.dart';

class FpoMembersScreen extends StatelessWidget {
  const FpoMembersScreen({super.key});

  static const _members = [
    _Member(name: 'Ramesh Kumar', role: 'Beekeeper', hives: 24, status: 'Active'),
    _Member(name: 'Madhav Ram', role: 'Honey Collector', hives: 0, status: 'Active'),
    _Member(name: 'Suresh K.', role: 'Beekeeper', hives: 12, status: 'Active'),
    _Member(name: 'Anita Devi', role: 'Beekeeper', hives: 8, status: 'Inactive'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeader(title: 'FPO Members', subtitle: 'संगठन के सदस्य'),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
            child: AppInput(
              controller: TextEditingController(),
              hint: 'Search members...',
              prefixIcon: const Icon(Icons.search_rounded, color: AppColors.onSurfaceVariant),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPaddingH),
              itemCount: _members.length,
              separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
              itemBuilder: (context, i) => _MemberCard(member: _members[i]),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: AppColors.fpoPurple,
        foregroundColor: AppColors.white,
        child: const Icon(Icons.person_add_rounded),
      ),
    );
  }
}

class _Member {
  const _Member({required this.name, required this.role, required this.hives, required this.status});
  final String name, role, status;
  final int hives;
}

class _MemberCard extends StatelessWidget {
  const _MemberCard({required this.member});
  final _Member member;

  @override
  Widget build(BuildContext context) {
    final isActive = member.status == 'Active';
    final roleColor = member.role == 'Beekeeper' ? AppColors.primary : AppColors.secondary;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
        border: Border.all(color: AppColors.outlineVariant),
      ),
      child: Row(
        children: [
          CircleAvatar(
            backgroundColor: roleColor.withValues(alpha: 0.1),
            child: Text(member.name[0], style: AppTextStyles.titleMedium.copyWith(color: roleColor)),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(member.name, style: AppTextStyles.titleSmall),
                Text('${member.role} • ${member.hives > 0 ? '${member.hives} hives' : 'Wild'}', style: AppTextStyles.caption.copyWith(color: AppColors.onSurfaceVariant)),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
            decoration: BoxDecoration(
              color: isActive ? AppColors.secondary.withValues(alpha: 0.1) : AppColors.onSurfaceVariant.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
            ),
            child: Text(member.status, style: AppTextStyles.labelSmall.copyWith(color: isActive ? AppColors.secondary : AppColors.onSurfaceVariant, fontWeight: FontWeight.w700)),
          ),
        ],
      ),
    );
  }
}
