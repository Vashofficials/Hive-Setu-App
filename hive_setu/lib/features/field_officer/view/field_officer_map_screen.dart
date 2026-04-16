import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/app_header.dart';

class FieldOfficerMapScreen extends StatelessWidget {
  const FieldOfficerMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeader(title: 'District Heatmap', subtitle: 'रोग और उत्पादन मानचित्र'),
      body: Stack(
        children: [
          // Mock Map Background
          Container(
            width: double.infinity,
            height: double.infinity,
            color: const Color(0xFFE8E8E8), // Base map color
            child: CustomPaint(painter: _DistrictMapPainter()),
          ),
          // Legend
          Positioned(
            top: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.sm),
              decoration: BoxDecoration(color: AppColors.white.withValues(alpha: 0.9), borderRadius: BorderRadius.circular(AppSpacing.cardRadius), boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.1), blurRadius: 10)]),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Legend', style: AppTextStyles.labelMedium.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 4),
                  _LegendItem(color: AppColors.error, label: 'High Disease Risk'),
                  _LegendItem(color: AppColors.primary, label: 'High Yield Area'),
                  _LegendItem(color: AppColors.govtTeal, label: 'FPO Centre'),
                ],
              ),
            ),
          ),
          // Bottom Selected Info Card (mock)
          Positioned(
            bottom: 24,
            left: 16,
            right: 16,
            child: Container(
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.white,
                borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                boxShadow: [BoxShadow(color: AppColors.error.withValues(alpha: 0.2), blurRadius: 20, offset: const Offset(0, 8))],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    children: [
                      Container(width: 12, height: 12, decoration: const BoxDecoration(color: AppColors.error, shape: BoxShape.circle)),
                      const SizedBox(width: AppSpacing.sm),
                      Text('Cluster A Risk Profile', style: AppTextStyles.titleMedium),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text('12 apiaries in region currently reporting Varroa levels above threshold. 4 FPOs notified.', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.onSurfaceVariant)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LegendItem extends StatelessWidget {
  const _LegendItem({required this.color, required this.label});
  final Color color;
  final String label;
  @override
  Widget build(BuildContext context) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 2),
        child: Row(
          children: [
            Container(width: 12, height: 12, decoration: BoxDecoration(color: color.withValues(alpha: 0.7), shape: BoxShape.circle)),
            const SizedBox(width: AppSpacing.sm),
            Text(label, style: AppTextStyles.caption),
          ],
        ),
      );
}

class _DistrictMapPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final grid = Paint()..color = Colors.white..strokeWidth = 2;
    for (double i = 0; i < size.width; i += 60) {
      canvas.drawLine(Offset(i, 0), Offset(i, size.height), grid);
    }
    for (double i = 0; i < size.height; i += 60) {
      canvas.drawLine(Offset(0, i), Offset(size.width, i), grid);
    }

    // High Yield areas (Primary)
    canvas.drawCircle(Offset(size.width * 0.3, size.height * 0.3), 60, Paint()..color = AppColors.primary.withValues(alpha: 0.3)..maskFilter = const MaskFilter.blur(BlurStyle.normal, 20));
    canvas.drawCircle(Offset(size.width * 0.7, size.height * 0.8), 80, Paint()..color = AppColors.primary.withValues(alpha: 0.2)..maskFilter = const MaskFilter.blur(BlurStyle.normal, 30));

    // High Disease Risk areas (Error)
    canvas.drawCircle(Offset(size.width * 0.6, size.height * 0.4), 50, Paint()..color = AppColors.error.withValues(alpha: 0.4)..maskFilter = const MaskFilter.blur(BlurStyle.normal, 15));

    // FPO Centres (Govt Teal)
    final fpoPaint = Paint()..color = AppColors.govtTeal;
    canvas.drawCircle(Offset(size.width * 0.3, size.height * 0.3), 8, fpoPaint);
    canvas.drawCircle(Offset(size.width * 0.65, size.height * 0.75), 8, fpoPaint);
    canvas.drawCircle(Offset(size.width * 0.5, size.height * 0.5), 8, fpoPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
