import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_text_styles.dart';

class AppHeader extends StatelessWidget implements PreferredSizeWidget {
  const AppHeader({
    super.key,
    required this.title,
    this.subtitle,
    this.leading,
    this.actions,
    this.badge,
    this.badgeColor,
    this.bottom,
    this.backgroundColor,
    this.foregroundColor,
    this.centerTitle = false,
    this.showBackButton = true,
    this.onBack,
  });

  final String title;
  final String? subtitle;
  final Widget? leading;
  final List<Widget>? actions;
  final String? badge;
  final Color? badgeColor;
  final PreferredSizeWidget? bottom;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final bool centerTitle;
  final bool showBackButton;
  final VoidCallback? onBack;

  @override
  Size get preferredSize => Size.fromHeight(
        bottom != null
            ? AppSpacing.appBarHeight + bottom!.preferredSize.height
            : AppSpacing.appBarHeight,
      );

  @override
  Widget build(BuildContext context) {
    final canPop = Navigator.canPop(context);
    final fgColor = foregroundColor ?? AppColors.onSurface;

    return AppBar(
      backgroundColor: backgroundColor ?? AppColors.surface,
      foregroundColor: fgColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: centerTitle,
      leading: leading ??
          (showBackButton && canPop
              ? IconButton(
                  onPressed: onBack ?? () => Navigator.pop(context),
                  icon: Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: AppColors.surfaceVariant,
                      borderRadius:
                          BorderRadius.circular(AppSpacing.radiusMd),
                    ),
                    child: Icon(
                      Icons.arrow_back_ios_new_rounded,
                      size: 16,
                      color: fgColor,
                    ),
                  ),
                )
              : null),
      title: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Column(
            crossAxisAlignment: centerTitle
                ? CrossAxisAlignment.center
                : CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title,
                style: AppTextStyles.appBarTitle.copyWith(color: fgColor),
              ),
              if (subtitle != null)
                Text(
                  subtitle!,
                  style: AppTextStyles.caption.copyWith(
                    color: fgColor.withValues(alpha: 0.7),
                  ),
                ),
            ],
          ),
          if (badge != null) ...[
            const SizedBox(width: AppSpacing.sm),
            Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.sm,
                vertical: 2,
              ),
              decoration: BoxDecoration(
                color: badgeColor ?? AppColors.primaryContainer,
                borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
              ),
              child: Text(
                badge!,
                style: AppTextStyles.labelSmall.copyWith(
                  color: AppColors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ],
        ],
      ),
      actions: [
        if (actions != null) ...actions!,
        const SizedBox(width: AppSpacing.sm),
      ],
      bottom: bottom,
    );
  }
}
