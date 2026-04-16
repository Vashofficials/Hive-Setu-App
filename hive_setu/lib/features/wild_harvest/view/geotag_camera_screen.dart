import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_header.dart';

class GeotagCameraScreen extends StatelessWidget {
  const GeotagCameraScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppHeader(title: 'Geo-Tag Camera', subtitle: 'HC2 — Location Capture', backgroundColor: AppColors.black, foregroundColor: AppColors.white),
      body: Stack(
        children: [
          Container(
            width: double.infinity, height: double.infinity,
            color: const Color(0xFF1A1A1A),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.camera_alt_rounded, size: 80, color: AppColors.white.withValues(alpha: 0.3)),
                  const SizedBox(height: AppSpacing.md),
                  Text('Camera Preview', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.white.withValues(alpha: 0.4))),
                ],
              ),
            ),
          ),
          // GPS Info bar
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: AppColors.black.withValues(alpha: 0.7),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  const Icon(Icons.location_on_rounded, color: AppColors.secondary, size: 16),
                  const SizedBox(width: 4),
                  Text('29.4737°N, 77.7043°E — GPS Locked', style: AppTextStyles.labelSmall.copyWith(color: AppColors.white)),
                  const Spacer(),
                  Container(
                    width: 8, height: 8,
                    decoration: const BoxDecoration(color: AppColors.secondary, shape: BoxShape.circle),
                  ),
                ],
              ),
            ),
          ),
          // Bottom panel
          Positioned(
            bottom: 32,
            left: 16,
            right: 16,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(AppSpacing.md),
                  decoration: BoxDecoration(color: AppColors.black.withValues(alpha: 0.7), borderRadius: BorderRadius.circular(AppSpacing.cardRadius)),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          _GeoInfo(label: 'Altitude', value: '142m'),
                          _GeoInfo(label: 'Accuracy', value: '±3m'),
                          _GeoInfo(label: 'Time', value: '14:22 IST'),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSpacing.md),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    IconButton(icon: const Icon(Icons.photo_library_rounded, color: AppColors.white, size: 32), onPressed: () {}),
                    GestureDetector(
                      onTap: () {},
                      child: Container(
                        width: 72, height: 72,
                        decoration: BoxDecoration(shape: BoxShape.circle, border: Border.all(color: AppColors.white, width: 4), color: AppColors.white.withValues(alpha: 0.1)),
                        child: const Icon(Icons.camera_alt_rounded, color: AppColors.white, size: 32),
                      ),
                    ),
                    IconButton(icon: const Icon(Icons.flip_camera_ios_rounded, color: AppColors.white, size: 32), onPressed: () {}),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _GeoInfo extends StatelessWidget {
  const _GeoInfo({required this.label, required this.value});
  final String label, value;
  @override
  Widget build(BuildContext context) => Column(
        children: [
          Text(value, style: AppTextStyles.titleSmall.copyWith(color: AppColors.white)),
          Text(label, style: AppTextStyles.caption.copyWith(color: AppColors.white.withValues(alpha: 0.6))),
        ],
      );
}
