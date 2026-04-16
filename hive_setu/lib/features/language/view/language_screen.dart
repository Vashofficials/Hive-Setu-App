import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/router/app_router.dart';
import '../../../core/widgets/app_button.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen>
    with SingleTickerProviderStateMixin {
  String _selectedLang = 'hi';
  late AnimationController _controller;
  late Animation<double> _fadeIn;

  static const _languages = [
    _Language(code: 'hi', name: 'हिंदी', subtitle: 'Hindi', flag: '🇮🇳'),
    _Language(code: 'en', name: 'English', subtitle: 'English', flag: '🇬🇧'),
    _Language(code: 'mr', name: 'मराठी', subtitle: 'Marathi', flag: '🇮🇳'),
    _Language(code: 'bn', name: 'বাংলা', subtitle: 'Bengali', flag: '🇮🇳'),
    _Language(code: 'te', name: 'తెలుగు', subtitle: 'Telugu', flag: '🇮🇳'),
    _Language(code: 'ta', name: 'தமிழ்', subtitle: 'Tamil', flag: '🇮🇳'),
    _Language(code: 'gu', name: 'ગુજરાતી', subtitle: 'Gujarati', flag: '🇮🇳'),
    _Language(code: 'pa', name: 'ਪੰਜਾਬੀ', subtitle: 'Punjabi', flag: '🇮🇳'),
  ];

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    )..forward();
    _fadeIn = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: SafeArea(
        child: FadeTransition(
          opacity: _fadeIn,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.screenPaddingH,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: AppSpacing.huge),

                // Header
                Text(
                  '🐝',
                  style: const TextStyle(fontSize: 48),
                ),
                const SizedBox(height: AppSpacing.lg),
                Text(
                  'अपनी भाषा चुनें',
                  style: AppTextStyles.headlineMedium.copyWith(
                    color: AppColors.onSurface,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  'Choose your preferred language',
                  style: AppTextStyles.bodyMedium.copyWith(
                    color: AppColors.onSurfaceVariant,
                  ),
                ),

                const SizedBox(height: AppSpacing.xxxl),

                // Language Grid
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: AppSpacing.md,
                      mainAxisSpacing: AppSpacing.md,
                      childAspectRatio: 2.2,
                    ),
                    itemCount: _languages.length,
                    itemBuilder: (context, index) {
                      final lang = _languages[index];
                      final isSelected = _selectedLang == lang.code;
                      return _LanguageTile(
                        language: lang,
                        isSelected: isSelected,
                        onTap: () =>
                            setState(() => _selectedLang = lang.code),
                      );
                    },
                  ),
                ),

                const SizedBox(height: AppSpacing.xxl),
                AppButton(
                  label: 'आगे बढ़ें  •  Continue',
                  onPressed: () => context.go(AppRoutes.phoneLogin),
                  width: double.infinity,
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

class _Language {
  const _Language({
    required this.code,
    required this.name,
    required this.subtitle,
    required this.flag,
  });

  final String code;
  final String name;
  final String subtitle;
  final String flag;
}

class _LanguageTile extends StatelessWidget {
  const _LanguageTile({
    required this.language,
    required this.isSelected,
    required this.onTap,
  });

  final _Language language;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.primaryContainer.withValues(alpha: 0.15)
              : AppColors.surfaceVariant,
          borderRadius: BorderRadius.circular(AppSpacing.radiusLg),
          border: Border.all(
            color: isSelected
                ? AppColors.primaryContainer
                : AppColors.outlineVariant,
            width: isSelected ? 2 : 1,
          ),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.md,
          vertical: AppSpacing.sm,
        ),
        child: Row(
          children: [
            Text(
              language.flag,
              style: const TextStyle(fontSize: 24),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    language.name,
                    style: AppTextStyles.titleSmall.copyWith(
                      color: isSelected
                          ? AppColors.primary
                          : AppColors.onSurface,
                      fontWeight: isSelected
                          ? FontWeight.w700
                          : FontWeight.w500,
                    ),
                  ),
                  Text(
                    language.subtitle,
                    style: AppTextStyles.caption.copyWith(
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle_rounded,
                color: AppColors.primaryContainer,
                size: AppSpacing.iconSm,
              ),
          ],
        ),
      ),
    );
  }
}
