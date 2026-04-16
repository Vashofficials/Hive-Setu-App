import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_text_styles.dart';

enum AppButtonVariant { primary, secondary, nest, ghost, danger }

enum AppButtonSize { large, medium, small }

class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.variant = AppButtonVariant.primary,
    this.size = AppButtonSize.large,
    this.icon,
    this.trailing,
    this.isLoading = false,
    this.isDisabled = false,
    this.width,
  });

  final String label;
  final VoidCallback? onPressed;
  final AppButtonVariant variant;
  final AppButtonSize size;
  final Widget? icon;
  final Widget? trailing;
  final bool isLoading;
  final bool isDisabled;
  final double? width;

  double get _height => switch (size) {
        AppButtonSize.large => AppSpacing.buttonHeight,
        AppButtonSize.medium => 44.0,
        AppButtonSize.small => AppSpacing.buttonHeightSm,
      };

  double get _fontSize => switch (size) {
        AppButtonSize.large => 16.0,
        AppButtonSize.medium => 14.0,
        AppButtonSize.small => 13.0,
      };

  double get _paddingH => switch (size) {
        AppButtonSize.large => AppSpacing.xxl,
        AppButtonSize.medium => AppSpacing.xl,
        AppButtonSize.small => AppSpacing.lg,
      };

  @override
  Widget build(BuildContext context) {
    final bool disabled = isDisabled || isLoading || onPressed == null;

    if (variant == AppButtonVariant.primary) {
      return _PollenPillButton(
        label: label,
        onPressed: disabled ? null : onPressed,
        icon: icon,
        trailing: trailing,
        isLoading: isLoading,
        height: _height,
        fontSize: _fontSize,
        paddingH: _paddingH,
        width: width,
      );
    }

    final style = _buildStyle(disabled);

    return SizedBox(
      width: width,
      height: _height,
      child: ElevatedButton(
        style: style,
        onPressed: disabled ? null : onPressed,
        child: _child,
      ),
    );
  }

  ButtonStyle _buildStyle(bool disabled) {
    return switch (variant) {
      AppButtonVariant.secondary => ElevatedButton.styleFrom(
          backgroundColor: AppColors.secondary,
          foregroundColor: AppColors.onSecondary,
          disabledBackgroundColor: AppColors.onSurface.withValues(alpha: 0.12),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
          ),
          textStyle: AppTextStyles.buttonText.copyWith(fontSize: _fontSize),
          padding: EdgeInsets.symmetric(horizontal: _paddingH),
        ),
      AppButtonVariant.nest => ElevatedButton.styleFrom(
          backgroundColor: AppColors.surfaceVariant,
          foregroundColor: AppColors.primary,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
          ),
          textStyle: AppTextStyles.buttonText.copyWith(fontSize: _fontSize),
          padding: EdgeInsets.symmetric(horizontal: _paddingH),
        ),
      AppButtonVariant.ghost => TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
          ),
          textStyle: AppTextStyles.buttonText.copyWith(fontSize: _fontSize),
          padding: EdgeInsets.symmetric(horizontal: _paddingH),
        ),
      AppButtonVariant.danger => ElevatedButton.styleFrom(
          backgroundColor: AppColors.error,
          foregroundColor: AppColors.onError,
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
          ),
          textStyle: AppTextStyles.buttonText.copyWith(fontSize: _fontSize),
          padding: EdgeInsets.symmetric(horizontal: _paddingH),
        ),
      _ => ElevatedButton.styleFrom(),
    };
  }

  Widget get _child => Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (isLoading) ...[
            const SizedBox(
              width: 16,
              height: 16,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
          ] else if (icon != null) ...[
            icon!,
            const SizedBox(width: AppSpacing.sm),
          ],
          Text(label),
          if (trailing != null) ...[
            const SizedBox(width: AppSpacing.sm),
            trailing!,
          ],
        ],
      );
}

class _PollenPillButton extends StatefulWidget {
  const _PollenPillButton({
    required this.label,
    required this.onPressed,
    this.icon,
    this.trailing,
    this.isLoading = false,
    required this.height,
    required this.fontSize,
    required this.paddingH,
    this.width,
  });

  final String label;
  final VoidCallback? onPressed;
  final Widget? icon;
  final Widget? trailing;
  final bool isLoading;
  final double height;
  final double fontSize;
  final double paddingH;
  final double? width;

  @override
  State<_PollenPillButton> createState() => _PollenPillButtonState();
}

class _PollenPillButtonState extends State<_PollenPillButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 1.02).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
    _glowAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool disabled = widget.onPressed == null;

    return GestureDetector(
      onTapDown: disabled ? null : (_) => _controller.forward(),
      onTapUp: disabled
          ? null
          : (_) {
              _controller.reverse();
              widget.onPressed?.call();
            },
      onTapCancel: disabled ? null : () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) => Stack(
          alignment: Alignment.center,
          children: [
            // Interaction Glow
            if (!disabled)
              Transform.scale(
                scale: 1.0 + (_glowAnimation.value * 0.1),
                child: Container(
                  width: (widget.width ?? 200) * 1.1,
                  height: widget.height * 1.2,
                  decoration: BoxDecoration(
                    color: AppColors.primaryContainer.withValues(alpha: 0.1 * _glowAnimation.value),
                    borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.primaryContainer.withValues(alpha: 0.3 * _glowAnimation.value),
                        blurRadius: 20,
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),
            Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                width: widget.width,
                height: widget.height,
                padding: EdgeInsets.symmetric(horizontal: widget.paddingH),
                decoration: BoxDecoration(
                  gradient: disabled ? null : AppColors.pollenPillGradient,
                  color: disabled ? AppColors.onSurface.withValues(alpha: 0.12) : null,
                  borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                  boxShadow: disabled ? null : AppColors.ambientShadow,
                ),
                child: Row(
                  mainAxisSize: widget.width == null ? MainAxisSize.min : MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    if (widget.isLoading) ...[
                      const SizedBox(
                        width: 18,
                        height: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(AppColors.white),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                    ] else if (widget.icon != null) ...[
                      widget.icon!,
                      const SizedBox(width: AppSpacing.sm),
                    ],
                    Text(
                      widget.label,
                      style: AppTextStyles.buttonText.copyWith(
                        fontSize: widget.fontSize,
                        color: disabled
                            ? AppColors.onSurface.withValues(alpha: 0.38)
                            : AppColors.white,
                      ),
                    ),
                    if (widget.trailing != null) ...[
                      const SizedBox(width: AppSpacing.sm),
                      widget.trailing!,
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
