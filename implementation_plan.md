# ApisSutra — Flutter MVVM Mobile App Implementation Plan

## Overview
Build the complete **ApisSutra** Flutter mobile app from scratch — India's beekeeping super-app.
35 screens, 6 roles, Clean Architecture, BLoC/Cubit state management, offline-first with Drift SQLite.

---

## User Review Required

> [!IMPORTANT]
> **Kotlin Version Conflict (2.3.0 vs 2.1.0):** The project is currently pulling in dependencies compiled with Kotlin 2.3.0, but the local build environment is defaulting to a 2.1.0 compiler, causing metadata version mismatches.
>
> **Updated Strategy:**
> 1. Upgrade the project to **Kotlin 2.3.20** (latest stable).
> 2. Perform a **Deep Clean**: `flutter clean` + `gradlew cleanBuildCache`.
> 3. Use the `--android-skip-build-dependency-validation` flag if we hit any final "warning-turned-error" metadata issues.
>
> **APK Signing:** I have verified `my-upload-key.keystore` exists in `android/app`. I will use the provided credentials for the final signed binary.

## Proposed Changes

### Android Build Configuration

#### [MODIFY] [settings.gradle.kts](file:///c:/Users/terab/StudioProjects/Hive%20Setu%20App/hive_setu/android/settings.gradle.kts)
- Set `org.jetbrains.kotlin.android` version to `2.3.20`.

#### [MODIFY] [build.gradle.kts](file:///c:/Users/terab/StudioProjects/Hive%20Setu%20App/hive_setu/android/app/build.gradle.kts)
- Ensure `compilerOptions` DSL is used for all Kotlin configurations.
- Verify `jvmTarget` is set to `JVM_17`.

---

## Open Questions

- None. Proceeding with the final attempt.

## Verification Plan

### Automated Tests
- `flutter build apk --release` (Primary)
- `flutter build apk --release --android-skip-build-dependency-validation` (Fallback)
- Locate final signed APK at `build/app/outputs/flutter-apk/app-release.apk`.

---

## Architecture

```
apissutra/
├── lib/
│   ├── core/
│   │   ├── constants/          # Colors, text styles, spacing
│   │   ├── router/             # GoRouter route definitions
│   │   ├── theme/              # ThemeData, AppTheme
│   │   ├── widgets/            # Shared widgets (AppButton, AppInput, OfflineSyncBar, etc.)
│   │   └── utils/              # Validators, formatters
│   ├── data/
│   │   ├── local/              # Drift DB, DAOs
│   │   ├── remote/             # Dio HTTP client, API services
│   │   └── repositories/       # Repository implementations
│   ├── domain/
│   │   ├── models/             # Pure Dart models
│   │   └── repositories/       # Abstract interfaces
│   └── features/
│       ├── splash/             # A1
│       ├── language/           # A2
│       ├── auth/               # A3, A4 (login + OTP)
│       ├── profile/            # A5, A6
│       ├── home/               # B1
│       ├── apiary/             # B2
│       ├── hive_products/      # B3
│       ├── best_practices/     # B4
│       ├── calendar/           # B5
│       ├── migration/          # B6
│       ├── products_sale/      # B7
│       ├── alert/              # B8
│       ├── flora/              # B9
│       ├── camera/             # B10
│       ├── location/           # B11
│       ├── bee_health/         # B12
│       ├── chat_support/       # B13
│       ├── beekeeper_profile/  # B14
│       ├── more/               # B15
│       ├── settings/           # B16
│       ├── wild_harvest/       # HC1–HC5
│       ├── marketplace/        # C1–C3
│       ├── fpo_admin/          # D1–D4
│       └── field_officer/      # E1–E2
```

Each feature folder has:
```
feature_name/
  ├── cubit/         state.dart + cubit.dart
  ├── view/          screen.dart
  └── widgets/       feature-specific widgets
```

---

## Design System Constants

```dart
// AppColors
static const primary = Color(0xFF8C4F00);
static const primaryContainer = Color(0xFFF7941D);
static const secondary = Color(0xFF1D6C2E);
static const surface = Color(0xFFFAF9FF);
static const onSurface = Color(0xFF1A1B20);
static const onSurfaceVariant = Color(0xFF49454F);
static const outlineVariant = Color(0xFFE0D5C5);
static const error = Color(0xFFD64045);
static const inverse = Color(0xFF000000);      // Night Hive nav
static const amberAlert = Color(0xFFF59B00);
static const govtTeal = Color(0xFF0E7490);
static const buyerBlue = Color(0xFF1967D2);
static const fpoPurple = Color(0xFF6B21A8);
```

---

## Dependencies (pubspec.yaml)

| Package | Purpose |
|---------|---------|
| `flutter_bloc` | BLoC/Cubit state management |
| `go_router` | Declarative routing |
| `google_fonts` | Poppins + Noto Sans Dev + Roboto Mono |
| `drift` + `drift_flutter` | Offline SQLite |
| `dio` + `retrofit` | HTTP client + codegen |
| `get_it` | Service locator DI |
| `injectable` | DI code generation |
| `freezed` | Immutable state models |
| `json_serializable` | JSON codegen |
| `google_maps_flutter` | Maps (B11, E2) |
| `geolocator` + `permission_handler` | GPS (HC2) |
| `image_picker` + `camera` | Camera (B10, HC2) |
| `firebase_messaging` | Push notifications |
| `shared_preferences` | Language/session prefs |
| `shimmer` | Loading skeletons |
| `lottie` | Splash animations |
| `fl_chart` | Charts (D1, F1) |
| `pinput` | OTP input boxes (A4) |
| `signature` | Digital signature canvas (HC4) |
| `qr_flutter` | QR code generator (HC5) |
| `pdf` + `printing` | PDF generation (HC5) |
| `intl` | Date formatting |

---

## Proposed Changes

### Phase 1 — Project Scaffold + Design System

#### [NEW] Flutter project creation + pubspec.yaml
#### [NEW] `lib/core/constants/app_colors.dart`
#### [NEW] `lib/core/constants/app_text_styles.dart`
#### [NEW] `lib/core/constants/app_spacing.dart`
#### [NEW] `lib/core/theme/app_theme.dart`
#### [NEW] `lib/core/router/app_router.dart` (GoRouter with all 34 routes)
#### [NEW] `lib/core/widgets/app_button.dart` (Pollen Pill gradient button)
#### [NEW] `lib/core/widgets/app_input.dart` (Clean Cell input field)
#### [NEW] `lib/core/widgets/offline_sync_bar.dart`
#### [NEW] `lib/core/widgets/night_hive_nav.dart` (Bottom nav)
#### [NEW] `lib/core/widgets/section_title.dart`
#### [NEW] `lib/core/widgets/app_header.dart` (Back arrow + pill badge header)
#### [NEW] `lib/main.dart` (BlocProvider tree, GoRouter, ThemeData)

---

### Phase 2 — Onboarding Flow (A1–A6)

#### [NEW] `features/splash/` — Splash screen with animations
#### [NEW] `features/language/` — Language selector
#### [NEW] `features/auth/` — Phone login + OTP verification
#### [NEW] `features/profile/` — Profile setup (empty + filled states)

---

### Phase 3 — Beekeeper Core (B1–B16)

#### [NEW] `features/home/` — Home Dashboard (B1)
#### [NEW] `features/apiary/` — My Apiary (B2)
#### [NEW] `features/hive_products/` — Hive Products Tracking (B3)
#### [NEW] `features/best_practices/` — Do's & Don'ts (B4)
#### [NEW] `features/calendar/` — Activity Calendar (B5)
#### [NEW] `features/migration/` — Migration Planning (B6)
#### [NEW] `features/products_sale/` — Products for Sale (B7)
#### [NEW] `features/alert/` — Alert & Companion (B8)
#### [NEW] `features/flora/` — Flora Identification (B9)
#### [NEW] `features/camera/` — Camera Screen (B10)
#### [NEW] `features/location/` — Location Map (B11)
#### [NEW] `features/bee_health/` — Bee Health/Pest Info (B12)
#### [NEW] `features/chat_support/` — Chat Support (B13)
#### [NEW] `features/beekeeper_profile/` — Beekeeper Profile (B14)
#### [NEW] `features/more/` — More Screen (B15)
#### [NEW] `features/settings/` — Settings (B16)

---

### Phase 4 — Honey Collector (HC1–HC5)

#### [NEW] `features/wild_harvest/` — HC1 Log, HC2 Geo-Tag Camera, HC3 Harvest Detail, HC4 FPO Submit, HC5 Digital ID

---

### Phase 5 — Buyer + FPO Admin + Field Officer (C1–C3, D1–D4, E1–E2)

#### [NEW] `features/marketplace/` — Buyer Marketplace, Product Detail, Cart/Checkout
#### [NEW] `features/fpo_admin/` — Dashboard, Members, Approval Queue, Broadcast Advisory
#### [NEW] `features/field_officer/` — Alert Feed, District Map

---

## Verification Plan

### Automated
- `flutter analyze` — zero errors, zero warnings
- `flutter test` — cubit unit tests for each major cubit

### Manual Verification
- `flutter run` on Android emulator / physical device
- Navigation flow: Splash → Language → Phone Login → OTP → Profile → Home
- BLoC state transitions verified via Flutter DevTools
- Offline sync bar behavior (mock offline mode)
- Night Hive bottom nav switching
- Role-based theme switching (Orange → Blue → Purple → Red)

---

## Open Questions

> [!IMPORTANT]
> **Firebase**: Should I set up a real `google-services.json` for FCM, or mock the push notification service for now?

> [!IMPORTANT]
> **Google Maps API Key**: Do you have a Maps API key to embed, or should I use a placeholder widget for map screens (B11, E2, HC2)?

> [!IMPORTANT]
> **Razorpay Key**: For the Buyer checkout screen (C3), should I use Razorpay test keys or a placeholder?

> [!NOTE]
> **Backend**: The Laravel 11 API is not yet connected — all screens will use mock/dummy data initially. Real API integration is a separate phase.
