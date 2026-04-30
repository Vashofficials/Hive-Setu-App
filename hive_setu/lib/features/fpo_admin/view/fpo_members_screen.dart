import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/router/app_router.dart';
import '../../../core/widgets/app_header.dart';
import '../../../core/widgets/app_input.dart';

class FpoMembersScreen extends StatefulWidget {
  const FpoMembersScreen({super.key});

  @override
  State<FpoMembersScreen> createState() => _FpoMembersScreenState();
}

class _FpoMembersScreenState extends State<FpoMembersScreen> {
  final _searchController = TextEditingController();
  String _query = '';

  static const _members = [
    _Member(id: 'M-001', name: 'Ramesh Kumar', role: 'Beekeeper', hives: 24, status: 'Active'),
    _Member(id: 'M-002', name: 'Madhav Ram', role: 'Honey Collector', hives: 0, status: 'Active'),
    _Member(id: 'M-003', name: 'Suresh K.', role: 'Beekeeper', hives: 12, status: 'Active'),
    _Member(id: 'M-004', name: 'Anita Devi', role: 'Beekeeper', hives: 8, status: 'Inactive'),
  ];

  List<_Member> get _filtered => _query.isEmpty
      ? _members
      : _members.where((m) => m.name.toLowerCase().contains(_query.toLowerCase()) || m.role.toLowerCase().contains(_query.toLowerCase())).toList();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

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
              controller: _searchController,
              hint: 'Search members...',
              prefixIcon: const Icon(Icons.search_rounded, color: AppColors.onSurfaceVariant),
              onChanged: (v) => setState(() => _query = v),
            ),
          ),
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.screenPaddingH),
              itemCount: _filtered.length,
              separatorBuilder: (_, __) => const SizedBox(height: AppSpacing.md),
              itemBuilder: (context, i) => _MemberCard(member: _filtered[i]),
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
  const _Member({required this.id, required this.name, required this.role, required this.hives, required this.status});
  final String id, name, role, status;
  final int hives;
}

class _MemberCard extends StatelessWidget {
  const _MemberCard({required this.member});
  final _Member member;

  @override
  Widget build(BuildContext context) {
    final isActive = member.status == 'Active';
    final roleColor = member.role == 'Beekeeper' ? AppColors.primary : AppColors.secondary;
    return GestureDetector(
      onTap: () => context.push(AppRoutes.fpoMemberDetail, extra: member.id),
      child: Container(
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
            const SizedBox(width: AppSpacing.sm),
            const Icon(Icons.chevron_right_rounded, color: AppColors.onSurfaceVariant, size: 18),
          ],
        ),
      ),
    );
  }
}
