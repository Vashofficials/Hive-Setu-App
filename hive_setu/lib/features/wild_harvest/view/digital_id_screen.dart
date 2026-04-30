import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';
import '../../../core/constants/app_spacing.dart';
import '../../../core/constants/app_text_styles.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_header.dart';

class DigitalIdScreen extends StatelessWidget {
  const DigitalIdScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: const AppHeader(title: 'Digital Harvest ID', subtitle: 'HC5 — डिजिटल पहचान'),
      body: Padding(
        padding: const EdgeInsets.all(AppSpacing.screenPaddingH),
        child: Column(
          children: [
            // ID Card
            Container(
              decoration: BoxDecoration(
                gradient: AppColors.splashGradient,
                borderRadius: BorderRadius.circular(AppSpacing.cardRadius),
                boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.3), blurRadius: 20, offset: const Offset(0, 8))],
              ),
              child: Stack(
                children: [
                  Positioned(right: -20, top: -20, child: Container(width: 120, height: 120, decoration: BoxDecoration(color: AppColors.white.withValues(alpha: 0.05), shape: BoxShape.circle))),
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.xl),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(children: [
                          const Text('🐝', style: TextStyle(fontSize: 32)),
                          const SizedBox(width: 12),
                          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text('HIVE SETU', style: AppTextStyles.labelLarge.copyWith(color: AppColors.white.withValues(alpha: 0.8), letterSpacing: 2)),
                            Text('Wild Honey Collector ID', style: AppTextStyles.caption.copyWith(color: AppColors.white.withValues(alpha: 0.6))),
                          ]),
                        ]),
                        const SizedBox(height: AppSpacing.xl),
                        Text('Madhav Ram', style: AppTextStyles.headlineSmall.copyWith(color: AppColors.white)),
                        const SizedBox(height: 4),
                        Text('ID: HC-2024-001', style: AppTextStyles.bodyMedium.copyWith(color: AppColors.white.withValues(alpha: 0.8))),
                        Text('FPO: Sundarbans Honey Producers Co-op', style: AppTextStyles.caption.copyWith(color: AppColors.white.withValues(alpha: 0.7))),
                        const SizedBox(height: AppSpacing.xl),
                        Row(children: [
                          // Mock QR Code
                          Container(
                            width: 72, height: 72,
                            decoration: BoxDecoration(color: AppColors.white, borderRadius: BorderRadius.circular(8)),
                            child: CustomPaint(painter: _QrPainter()),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                            Text('Season: 2025–26', style: AppTextStyles.caption.copyWith(color: AppColors.white.withValues(alpha: 0.7))),
                            Text('Total: 142 kg certified', style: AppTextStyles.bodySmall.copyWith(color: AppColors.white, fontWeight: FontWeight.w600)),
                            Text('Expires: 31 Mar 2027', style: AppTextStyles.caption.copyWith(color: AppColors.white.withValues(alpha: 0.6))),
                          ])),
                        ]),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xxl),
            AppButton(
              label: '📥  Download PDF',
              onPressed: () {},
              width: double.infinity,
            ),
            const SizedBox(height: AppSpacing.md),
            SizedBox(
              width: double.infinity,
              child: OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  foregroundColor: AppColors.primary,
                  side: BorderSide(color: AppColors.primary.withValues(alpha: 0.3)),
                  padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSpacing.radiusMd)),
                ),
                child: Text('📤  Share', style: AppTextStyles.buttonSmall.copyWith(color: AppColors.primary)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QrPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final p = Paint()..color = Colors.black;
    final cell = size.width / 8;
    final pattern = [
      [1,1,1,1,1,1,1,0],[1,0,0,0,0,0,1,0],[1,0,1,1,1,0,1,0],
      [1,0,1,0,1,0,1,0],[1,0,1,1,1,0,1,0],[1,0,0,0,0,0,1,0],
      [1,1,1,1,1,1,1,0],[0,1,0,1,0,0,0,1],
    ];
    for (int r = 0; r < pattern.length; r++) {
      for (int c = 0; c < pattern[r].length; c++) {
        if (pattern[r][c] == 1) canvas.drawRect(Rect.fromLTWH(c * cell, r * cell, cell, cell), p);
      }
    }
  }
  @override
  bool shouldRepaint(covariant CustomPainter o) => false;
}
