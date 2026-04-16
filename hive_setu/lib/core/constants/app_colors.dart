import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // Primary — Honey Amber
  static const Color primary = Color(0xFF8C4F00);
  static const Color primaryContainer = Color(0xFFF7941D);
  static const Color onPrimary = Color(0xFFFFFFFF);
  static const Color onPrimaryContainer = Color(0xFF2C1600);

  // Secondary — Forest Green
  static const Color secondary = Color(0xFF1D6C2E);
  static const Color secondaryContainer = Color(0xFFB7F2C5);
  static const Color onSecondary = Color(0xFFFFFFFF);
  static const Color onSecondaryContainer = Color(0xFF002109);

  // Tertiary — Beeswax Gold
  static const Color tertiary = Color(0xFFF59B00);
  static const Color tertiaryContainer = Color(0xFFFFE09A);
  static const Color onTertiary = Color(0xFF261900);
  static const Color onTertiaryContainer = Color(0xFF261900);

  // Neutrals
  static const Color surface = Color(0xFFFFFFFF);
  static const Color surfaceVariant = Color(0xFFF3EDE3);
  static const Color onSurface = Color(0xFF1A1B20);
  static const Color onSurfaceVariant = Color(0xFF524438);
  static const Color outline = Color(0xFF8C7E6F);
  static const Color outlineVariant = Color(0xFFE0D5C5);
  static const Color background = Color(0xFFF5F2ED);
  static const Color onBackground = Color(0xFF1A1B20);

  // Error
  static const Color error = Color(0xFFD64045);
  static const Color onError = Color(0xFFFFFFFF);
  static const Color errorContainer = Color(0xFFFFDAD6);
  static const Color onErrorContainer = Color(0xFF410002);

  // Semantic / Role Colors
  static const Color amberAlert = Color(0xFFF59B00);
  static const Color govtTeal = Color(0xFF0E7490);
  static const Color buyerBlue = Color(0xFF1967D2);
  static const Color fpoPurple = Color(0xFF6B21A8);
  static const Color fieldOfficerRed = Color(0xFFD64045);

  // Night Hive Nav (Pure Black for contrast)
  static const Color nightHive = Color(0xFF000000);
  static const Color nightHiveItem = Color(0xFFBFA07A);
  static const Color nightHiveItemActive = Color(0xFFF7941D);

  // Misc
  static const Color white = Color(0xFFFFFFFF);
  static const Color black = Color(0xFF000000);
  static const Color transparent = Color(0x00000000);
  static const Color divider = Color(0xFFE0D5C5);
  static const Color shimmerBase = Color(0xFFE8E0D5);
  static const Color shimmerHighlight = Color(0xFFF5F0E8);

  // Gradients
  static const LinearGradient pollenPillGradient = LinearGradient(
    colors: [Color(0xFF8C4F00), Color(0xFFF7941D)],
    begin: Alignment.topLeft,
    end: Alignment(0.7, 0.7), // roughly 135 degrees
  );

  static const LinearGradient amberGradient = LinearGradient(
    colors: [Color(0xFFF7941D), Color(0xFFE07B00)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient greenGradient = LinearGradient(
    colors: [Color(0xFF2E9147), Color(0xFF1D6C2E)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient splashGradient = LinearGradient(
    colors: [Color(0xFF5C2D00), Color(0xFF8C4F00), Color(0xFFF7941D)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // Elevation & Depth
  static final List<BoxShadow> ambientShadow = [
    BoxShadow(
      color: const Color(0x00000000).withValues(alpha: 0.04),
      blurRadius: 2,
      offset: const Offset(0, 1),
    ),
    BoxShadow(
      color: const Color(0x33A69F94).withValues(alpha: 0.08),
      blurRadius: 12,
      offset: const Offset(0, 4),
    ),
    BoxShadow(
      color: const Color(0x33A69F94).withValues(alpha: 0.12),
      blurRadius: 24,
      offset: const Offset(0, 12),
    ),
  ];

  static final List<BoxShadow> amberShadow = [
    BoxShadow(
      color: const Color(0xFF926D1B).withValues(alpha: 0.05),
      blurRadius: 8,
      offset: const Offset(0, 4),
    ),
    BoxShadow(
      color: const Color(0xFF926D1B).withValues(alpha: 0.1),
      blurRadius: 24,
      offset: const Offset(0, 12),
    ),
  ];
}
