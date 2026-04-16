import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_spacing.dart';
import '../constants/app_text_styles.dart';

class OfflineSyncBar extends StatefulWidget {
  const OfflineSyncBar({
    super.key,
    required this.isOffline,
    this.pendingSyncCount = 0,
  });

  final bool isOffline;
  final int pendingSyncCount;

  @override
  State<OfflineSyncBar> createState() => _OfflineSyncBarState();
}

class _OfflineSyncBarState extends State<OfflineSyncBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _heightAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _heightAnimation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    );
    if (widget.isOffline) _controller.forward();
  }

  @override
  void didUpdateWidget(OfflineSyncBar oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isOffline != oldWidget.isOffline) {
      if (widget.isOffline) {
        _controller.forward();
      } else {
        _controller.reverse();
      }
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizeTransition(
      sizeFactor: _heightAnimation,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.lg,
          vertical: AppSpacing.sm,
        ),
        decoration: const BoxDecoration(
          color: AppColors.amberAlert,
        ),
        child: Row(
          children: [
            const Icon(
              Icons.wifi_off_rounded,
              size: AppSpacing.iconSm,
              color: AppColors.onSurface,
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                widget.pendingSyncCount > 0
                    ? 'Offline — ${widget.pendingSyncCount} item(s) pending sync'
                    : 'You\'re offline. Data saved locally.',
                style: AppTextStyles.labelMedium.copyWith(
                  color: AppColors.onSurface,
                ),
              ),
            ),
            if (widget.pendingSyncCount > 0)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: AppColors.onSurface.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                ),
                child: Text(
                  '${widget.pendingSyncCount}',
                  style: AppTextStyles.labelSmall.copyWith(
                    color: AppColors.onSurface,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
