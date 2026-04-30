import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/router/app_router.dart';
import '../../../core/utils/role_store.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_input.dart';

class PhoneLoginScreen extends StatefulWidget {
  const PhoneLoginScreen({super.key});

  @override
  State<PhoneLoginScreen> createState() => _PhoneLoginScreenState();
}

class _PhoneLoginScreenState extends State<PhoneLoginScreen>
    with SingleTickerProviderStateMixin {
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;
  String _selectedRole = 'beekeeper';

  late AnimationController _fadeController;
  late Animation<double> _fadeIn;

  static const _roles = [
    _Role(id: 'beekeeper', label: 'Beekeeper', labelHi: 'मधुमक्खी पालक', icon: '🐝'),
    _Role(id: 'collector', label: 'Honey Collector', labelHi: 'शहद संग्रहक', icon: '🍯'),
    _Role(id: 'buyer', label: 'Buyer', labelHi: 'खरीदार', icon: '🛒'),
    _Role(id: 'fpo', label: 'FPO Admin', labelHi: 'एफपीओ अधिकारी', icon: '🏛️'),
    _Role(id: 'field_officer', label: 'Field Officer', labelHi: 'क्षेत्र अधिकारी', icon: '🔭'),
  ];

  @override
  void initState() {
    super.initState();
    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward();
    _fadeIn = CurvedAnimation(parent: _fadeController, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _fadeController.dispose();
    super.dispose();
  }

  Future<void> _sendOtp() async {
    if (!_formKey.currentState!.validate()) return;
    RoleStore.set(_selectedRole);
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 1200));
    if (mounted) {
      setState(() => _isLoading = false);
      context.go(AppRoutes.otp, extra: _phoneController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeIn,
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenPaddingH,
              vertical: AppSpacing.screenPaddingV,
            ),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppSpacing.xl),

                  // Back Button
                  GestureDetector(
                    onTap: () => context.go(AppRoutes.language),
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                        color: AppColors.surfaceVariant,
                        borderRadius:
                            BorderRadius.circular(AppSpacing.radiusMd),
                      ),
                      child: const Icon(
                        Icons.arrow_back_ios_new_rounded,
                        size: 16,
                        color: AppColors.onSurface,
                      ),
                    ),
                  ),

                  const SizedBox(height: AppSpacing.xxxl),

                  Text(
                    'लॉगिन करें',
                    style: AppTextStyles.headlineMedium.copyWith(
                      color: AppColors.onSurface,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    'Enter your mobile number to continue',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),

                  const SizedBox(height: AppSpacing.xxxl),

                  // Role Selector
                  Text(
                    'I am a...',
                    style: AppTextStyles.labelLarge.copyWith(
                      color: AppColors.onSurface,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  SizedBox(
                    height: 80,
                    child: ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: _roles.length,
                      separatorBuilder: (_, __) =>
                          const SizedBox(width: AppSpacing.sm),
                      itemBuilder: (context, index) {
                        final role = _roles[index];
                        final isSelected = _selectedRole == role.id;
                        return _RoleChip(
                          role: role,
                          isSelected: isSelected,
                          onTap: () =>
                              setState(() => _selectedRole = role.id),
                        );
                      },
                    ),
                  ),

                  const SizedBox(height: AppSpacing.xxxl),

                  // Phone Input
                  AppInput(
                    label: 'Mobile Number',
                    hint: '10-digit mobile number',
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    textInputAction: TextInputAction.done,
                    maxLength: 10,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.only(left: 12, right: 4),
                      child: Text(
                        '🇮🇳 +91',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.onSurface,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your mobile number';
                      }
                      if (value.length != 10) {
                        return 'Please enter a valid 10-digit number';
                      }
                      return null;
                    },
                    onSubmitted: (_) => _sendOtp(),
                  ),

                  const SizedBox(height: AppSpacing.lg),

                  Text(
                    'You\'ll receive an OTP on this number',
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),

                  const SizedBox(height: AppSpacing.massive),

                  AppButton(
                    label: 'Send OTP',
                    onPressed: _isLoading ? null : _sendOtp,
                    isLoading: _isLoading,
                    width: double.infinity,
                  ),

                  const SizedBox(height: AppSpacing.xl),

                  // Terms
                  Center(
                    child: Text.rich(
                      TextSpan(
                        text: 'By continuing you agree to our ',
                        style: AppTextStyles.caption.copyWith(
                          color: AppColors.onSurfaceVariant,
                        ),
                        children: [
                          TextSpan(
                            text: 'Terms of Service',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const TextSpan(text: ' and '),
                          TextSpan(
                            text: 'Privacy Policy',
                            style: AppTextStyles.caption.copyWith(
                              color: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Role {
  const _Role({
    required this.id,
    required this.label,
    required this.labelHi,
    required this.icon,
  });

  final String id;
  final String label;
  final String labelHi;
  final String icon;
}

class _RoleChip extends StatelessWidget {
  const _RoleChip({
    required this.role,
    required this.isSelected,
    required this.onTap,
  });

  final _Role role;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.surface
              : AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          boxShadow: isSelected ? AppColors.ambientShadow : null,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(role.icon, style: const TextStyle(fontSize: 24)),
            const SizedBox(height: 4),
            Text(
              role.label,
              style: AppTextStyles.labelSmall.copyWith(
                color: isSelected ? AppColors.primary : AppColors.onSurface,
                fontWeight:
                    isSelected ? FontWeight.w700 : FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
