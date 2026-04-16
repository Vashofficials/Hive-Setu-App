import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/router/app_router.dart';
import '../../../core/widgets/app_header.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});
  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  bool _notifications = true;
  bool _offlineSync = true;
  bool _locationTracking = false;
  bool _biometrics = false;
  String _language = 'Hindi';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeader(title: 'Settings', subtitle: 'सेटिंग्स'),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
        children: [
          _SettingSection(title: 'Preferences'),
          _SettingTile(
            icon: Icons.language_rounded,
            label: 'App Language',
            value: _language,
            color: AppColors.govtTeal,
            onTap: () {},
          ),
          _SwitchTile(
            icon: Icons.notifications_rounded,
            label: 'Push Notifications',
            value: _notifications,
            color: AppColors.primary,
            onChanged: (v) => setState(() => _notifications = v),
          ),
          _SwitchTile(
            icon: Icons.sync_rounded,
            label: 'Offline Data Sync',
            value: _offlineSync,
            color: AppColors.secondary,
            onChanged: (v) => setState(() => _offlineSync = v),
          ),
          const SizedBox(height: AppSpacing.lg),
          _SettingSection(title: 'Privacy & Security'),
          _SwitchTile(
            icon: Icons.location_on_rounded,
            label: 'Location Tracking',
            value: _locationTracking,
            color: AppColors.buyerBlue,
            onChanged: (v) => setState(() => _locationTracking = v),
          ),
          _SwitchTile(
            icon: Icons.fingerprint_rounded,
            label: 'Biometric Login',
            value: _biometrics,
            color: AppColors.fpoPurple,
            onChanged: (v) => setState(() => _biometrics = v),
          ),
          const SizedBox(height: AppSpacing.lg),
          _SettingSection(title: 'About'),
          _SettingTile(icon: Icons.info_outline_rounded, label: 'App Version', value: '1.0.0', color: AppColors.onSurfaceVariant, onTap: () {}),
          _SettingTile(icon: Icons.privacy_tip_outlined, label: 'Privacy Policy', value: '', color: AppColors.onSurfaceVariant, onTap: () {}),
          _SettingTile(icon: Icons.document_scanner_outlined, label: 'Terms of Service', value: '', color: AppColors.onSurfaceVariant, onTap: () {}),
          const SizedBox(height: AppSpacing.xl),
          // Logout
          GestureDetector(
            onTap: () => context.go(AppRoutes.phoneLogin),
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.error.withValues(alpha: 0.05),
                borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                border: Border.all(color: AppColors.error.withValues(alpha: 0.2)),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.logout_rounded, color: AppColors.error),
                  const SizedBox(width: AppSpacing.sm),
                  Text('Logout', style: AppTextStyles.titleSmall.copyWith(color: AppColors.error)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SettingSection extends StatelessWidget {
  const _SettingSection({required this.title});
  final String title;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
        child: Text(title, style: AppTextStyles.sectionTitle.copyWith(color: AppColors.onSurfaceVariant)),
      );
}

class _SettingTile extends StatelessWidget {
  const _SettingTile({required this.icon, required this.label, required this.value, required this.color, required this.onTap});
  final IconData icon;
  final String label, value;
  final Color color;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onTap,
        child: Container(
          margin: const EdgeInsets.only(bottom: AppSpacing.sm),
          padding: const EdgeInsets.all(AppSpacing.md),
          decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(AppSpacing.cardRadius), border: Border.all(color: AppColors.outlineVariant)),
          child: Row(
            children: [
              Container(width: 36, height: 36, decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                  child: Icon(icon, color: color, size: AppSpacing.iconSm)),
              const SizedBox(width: AppSpacing.md),
              Expanded(child: Text(label, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w500))),
              if (value.isNotEmpty) Text(value, style: AppTextStyles.bodySmall.copyWith(color: AppColors.onSurfaceVariant)),
              const Icon(Icons.chevron_right_rounded, color: AppColors.onSurfaceVariant),
            ],
          ),
        ),
      );
}

class _SwitchTile extends StatelessWidget {
  const _SwitchTile({required this.icon, required this.label, required this.value, required this.color, required this.onChanged});
  final IconData icon;
  final String label;
  final bool value;
  final Color color;
  final ValueChanged<bool> onChanged;
  @override
  Widget build(BuildContext context) => Container(
        margin: const EdgeInsets.only(bottom: AppSpacing.sm),
        padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md, vertical: AppSpacing.sm),
        decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(AppSpacing.cardRadius), border: Border.all(color: AppColors.outlineVariant)),
        child: Row(
          children: [
            Container(width: 36, height: 36, decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(8)),
                child: Icon(icon, color: color, size: AppSpacing.iconSm)),
            const SizedBox(width: AppSpacing.md),
            Expanded(child: Text(label, style: AppTextStyles.bodyMedium.copyWith(fontWeight: FontWeight.w500))),
            Switch(value: value, onChanged: onChanged, activeColor: color),
          ],
        ),
      );
}
