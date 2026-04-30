import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/router/app_router.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_input.dart';

class ProfileSetupScreen extends StatefulWidget {
  const ProfileSetupScreen({super.key, this.role = 'beekeeper'});
  final String role;

  @override
  State<ProfileSetupScreen> createState() => _ProfileSetupScreenState();
}

class _ProfileSetupScreenState extends State<ProfileSetupScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _stateController = TextEditingController();
  final _districtController = TextEditingController();
  final _hivesController = TextEditingController();
  bool _isLoading = false;

  static const _states = [
    'Uttar Pradesh', 'Rajasthan', 'Maharashtra', 'Bihar',
    'West Bengal', 'Madhya Pradesh', 'Gujarat', 'Karnataka',
    'Odisha', 'Jharkhand', 'Assam', 'Punjab',
  ];

  String? _selectedState;

  @override
  void dispose() {
    _nameController.dispose();
    _stateController.dispose();
    _districtController.dispose();
    _hivesController.dispose();
    super.dispose();
  }

  Future<void> _saveProfile() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(milliseconds: 1000));
    if (mounted) {
      setState(() => _isLoading = false);
      _navigateToDashboard();
    }
  }

  void _navigateToDashboard() {
    if (widget.role == 'beekeeper') {
      context.go(AppRoutes.home);
    } else if (widget.role == 'collector') {
      context.go(AppRoutes.harvestLog);
    } else if (widget.role == 'buyer') {
      context.go(AppRoutes.marketplace);
    } else if (widget.role == 'fpo') {
      context.go(AppRoutes.fpoDashboard);
    } else if (widget.role == 'field_officer') {
      context.go(AppRoutes.alertFeed);
    } else {
      context.go(AppRoutes.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
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
                const SizedBox(height: AppSpacing.xxl),

                // Header
                Container(
                  width: 64,
                  height: 64,
                  decoration: BoxDecoration(
                    gradient: AppColors.pollenPillGradient,
                    borderRadius:
                        BorderRadius.circular(AppSpacing.radiusXl),
                  ),
                  child: const Icon(
                    Icons.person_outline_rounded,
                    color: AppColors.white,
                    size: 32,
                  ),
                ),
                const SizedBox(height: AppSpacing.lg),

                Text(
                  'अपना प्रोफाइल बनाएं',
                  style: AppTextStyles.headlineMedium.copyWith(
                    color: AppColors.onSurface,
                  ),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(
                  'Set up your profile to get started',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),

                const SizedBox(height: AppSpacing.xxxl),

                // Avatar Picker
                Center(
                  child: Stack(
                    children: [
                      Container(
                        width: 90,
                        height: 90,
                        decoration: BoxDecoration(
                          color: AppColors.surface,
                          shape: BoxShape.circle,
                          boxShadow: AppColors.ambientShadow,
                        ),
                        child: const Icon(
                          Icons.person_rounded,
                          size: 48,
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 30,
                          height: 30,
                          decoration: const BoxDecoration(
                            gradient: AppColors.pollenPillGradient,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt_rounded,
                            size: 16,
                            color: AppColors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: AppSpacing.xxxl),

                AppInput(
                  label: 'Full Name / पूरा नाम',
                  hint: 'Ramesh Kumar',
                  controller: _nameController,
                  textInputAction: TextInputAction.next,
                  validator: (v) =>
                      v == null || v.isEmpty ? 'Name is required' : null,
                ),

                const SizedBox(height: AppSpacing.lg),

                // State Dropdown
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'State / राज्य',
                      style: AppTextStyles.inputLabel.copyWith(
                        color: AppColors.onSurface,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    DropdownButtonFormField<String>(
                      value: _selectedState,
                      hint: Text(
                        'Select your state',
                        style: AppTextStyles.inputHint.copyWith(
                          color: AppColors.onSurfaceVariant,
                        ),
                      ),
                      items: _states
                          .map((s) => DropdownMenuItem(
                                value: s,
                                child: Text(s,
                                    style: AppTextStyles.bodyMedium),
                              ))
                          .toList(),
                      onChanged: (v) =>
                          setState(() => _selectedState = v),
                      validator: (v) =>
                          v == null ? 'Please select a state' : null,
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: AppColors.surface,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.lg,
                          vertical: AppSpacing.md,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppSpacing.radiusMd),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: AppSpacing.lg),

                AppInput(
                  label: 'District / जिला',
                  hint: 'e.g. Muzaffarnagar',
                  controller: _districtController,
                  textInputAction: TextInputAction.next,
                ),

                const SizedBox(height: AppSpacing.lg),

                AppInput(
                  label: 'Number of Hives / छत्तों की संख्या',
                  hint: 'e.g. 25',
                  controller: _hivesController,
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.done,
                  prefixIcon: const Icon(
                    Icons.hive_outlined,
                    size: AppSpacing.iconSm,
                    color: AppColors.onSurfaceVariant,
                  ),
                ),

                const SizedBox(height: AppSpacing.huge),

                AppButton(
                  label: 'Save Profile & Continue',
                  onPressed: _isLoading ? null : _saveProfile,
                  isLoading: _isLoading,
                  width: double.infinity,
                ),

                const SizedBox(height: AppSpacing.lg),

                Center(
                  child: TextButton(
                    onPressed: _navigateToDashboard,
                    child: Text(
                      'Skip for now',
                      style: AppTextStyles.labelLarge.copyWith(
                        color: AppColors.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: AppSpacing.xxl),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
