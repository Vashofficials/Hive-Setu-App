import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_header.dart';

class CameraScreen extends StatelessWidget {
  const CameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppHeader(
        title: 'Camera',
        backgroundColor: AppColors.black,
        foregroundColor: AppColors.white,
      ),
      body: Stack(
        children: [
          // Camera preview placeholder
          Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color(0xFF1A1A1A),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.camera_alt_rounded, size: 80, color: AppColors.white.withValues(alpha: 0.3)),
                  const SizedBox(height: AppSpacing.md),
                  Text('Camera Preview', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.white.withValues(alpha: 0.4))),
                  const SizedBox(height: AppSpacing.sm),
                  Text('Grant camera permission to use', style: AppTextStyles.caption.copyWith(color: AppColors.white.withValues(alpha: 0.3))),
                ],
              ),
            ),
          ),
          // Mode selector
          Positioned(
            top: 16,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: ['Hive', 'Flora', 'Bee', 'Document']
                  .map((m) => Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 6),
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                          decoration: BoxDecoration(
                            color: m == 'Hive' ? AppColors.primary : AppColors.black.withValues(alpha: 0.5),
                            borderRadius: BorderRadius.circular(AppSpacing.radiusFull),
                          ),
                          child: Text(m, style: AppTextStyles.labelSmall.copyWith(color: AppColors.white)),
                        ),
                      ))
                  .toList(),
            ),
          ),
          // Bottom controls
          Positioned(
            bottom: 48,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.photo_library_rounded, color: AppColors.white, size: 32),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 72, height: 72,
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      shape: BoxShape.circle,
                      border: Border.all(color: AppColors.white, width: 4),
                      boxShadow: [BoxShadow(color: AppColors.white.withValues(alpha: 0.3), blurRadius: 20)],
                    ),
                    child: const Icon(Icons.camera_alt_rounded, color: AppColors.onSurface, size: 32),
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.flip_camera_ios_rounded, color: AppColors.white, size: 32),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
