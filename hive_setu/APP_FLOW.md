# 🐝 Hive Setu — Complete App Flow Document

> **Version:** 1.0 | **Date:** April 29, 2026  
> **Framework:** Flutter 3.x (Dart ≥3.3.0)  
> **Architecture:** Feature-First Modular Clean Architecture  
> **Design System:** "Organic Brutalism" — Material 3 + Custom Tokens (Poppins / Noto Sans / Roboto Mono)

---

## Table of Contents

1. [App Entry & Onboarding](#1-app-entry--onboarding)
2. [Role Selection & Routing Logic](#2-role-selection--routing-logic)
3. [🟢 Beekeeper / Producer Role](#3--beekeeper--producer-role)
4. [🍯 Honey Collector Role](#4--honey-collector-role)
5. [🛒 B2B Buyer / Retailer Role](#5--b2b-buyer--retailer-role)
6. [🏛️ FPO / Cooperative Admin Role](#6-️-fpo--cooperative-admin-role)
7. [🔭 Extension / Government Officer Role](#7--extension--government-officer-role)
8. [Shared / Cross-Cutting Modules](#8-shared--cross-cutting-modules)
9. [Navigation Architecture](#9-navigation-architecture)
10. [Design System Tokens](#10-design-system-tokens)
11. [Gap Analysis — Existing vs. Required](#11-gap-analysis--existing-vs-required)

---

## 1. App Entry & Onboarding

The onboarding flow is linear and identical for all user roles.

```
Splash → Language Selection → Phone Login (+ Role Select) → OTP Verification → Profile Setup → Role Dashboard
```

### 1.1 Splash Screen
- **File:** `lib/features/splash/view/splash_screen.dart`
- **Route:** `/` (initial)
- **Behavior:**
  - Animated honeycomb logo with floating bee animation
  - Gradient background (`splashGradient`: amber → deep brown)
  - 3-dot loading pulse
  - Auto-navigates to `/language` after ~2.4s
- **Status:** ✅ Implemented

### 1.2 Language Selection Screen
- **File:** `lib/features/language/view/language_screen.dart`
- **Route:** `/language`
- **Behavior:**
  - Grid of 8 Indian languages (Hindi, English, Marathi, Bengali, Telugu, Tamil, Gujarati, Punjabi)
  - Default selection: Hindi
  - Animated selection with border highlight
  - "Continue" button navigates to `/login`
- **Status:** ✅ Implemented

### 1.3 Phone Login Screen
- **File:** `lib/features/auth/view/phone_login_screen.dart`
- **Route:** `/login`
- **Behavior:**
  - **Role Selector:** Horizontal scrollable chips for 5 roles (Beekeeper, Honey Collector, Buyer, FPO Admin, Field Officer)
  - **Phone Input:** +91 prefix, 10-digit validation
  - Navigates to `/otp?phone={phone}&role={role}`
- **Status:** ✅ Implemented

### 1.4 OTP Verification Screen
- **File:** `lib/features/auth/view/otp_screen.dart`
- **Route:** `/otp`
- **Behavior:**
  - 6-digit OTP input with auto-focus advancing
  - 30-second resend timer
  - Auto-verify on 6th digit entry
  - Navigates to `/profile-setup?role={role}`
- **Status:** ✅ Implemented

### 1.5 Profile Setup Screen
- **File:** `lib/features/profile/view/profile_setup_screen.dart`
- **Route:** `/profile-setup`
- **Behavior:**
  - Avatar picker (camera icon)
  - Fields: Full Name, State (dropdown — 12 states), District, Number of Hives
  - "Skip for now" option
  - **Role-based routing on save:**
    - `beekeeper` → `/home`
    - `collector` → `/harvest-log`
    - `buyer` → `/marketplace`
    - `fpo` → `/fpo-dashboard`
    - `field_officer` → `/alert-feed`
- **Status:** ✅ Implemented

---

## 2. Role Selection & Routing Logic

```
┌─────────────────────────────────────────────────┐
│                  Profile Setup                  │
│          (role passed via query param)          │
└──────────┬──────┬──────┬──────┬──────┬──────────┘
           │      │      │      │      │
           ▼      ▼      ▼      ▼      ▼
       Beekeeper Collector Buyer  FPO  Field
       /home    /harvest  /market /fpo  /alert
                -log      place  -dash  -feed
```

All 5 role IDs: `beekeeper`, `collector`, `buyer`, `fpo`, `field_officer`

---

## 3. 🟢 Beekeeper / Producer Role

The primary role. Most feature-rich dashboard with full bottom navigation.

### 3.1 Home Dashboard
- **File:** `lib/features/home/view/home_screen.dart`
- **Route:** `/home`
- **Bottom Nav:** Home | Apiary | Calendar | Market | Profile (5 tabs via `NightHiveNav`)
- **Sections:**
  - Greeting bar with notification bell + avatar
  - Alert banner (e.g., Varroa mite alert)
  - Stat cards grid (Total Hives, Active Colonies, Honey kg, Alerts)
  - Quick Actions grid (6 items: My Apiary, Log Harvest, Best Practices, Health Check, Flora Map, Chat Support)
  - Today's Activity (task list with checkmarks)
  - Market Prices (live ticker for Mustard/Acacia/Jamun honey)
- **Status:** ✅ Implemented

### 3.2 Apiary Management
- **File:** `lib/features/apiary/view/apiary_screen.dart`
- **Route:** `/apiary`
- **Flow:**
  ```
  Apiary List → Hive Detail → Colony Status / Inspection Log
  ```
- **Planned Sub-screens (from flow diagram):**
  - Colony/Hive Management
  - Add/Edit Hive
  - Hive Inspection Form
  - Colony Strength Tracker
- **Status:** ✅ Main screen exists | ⚠️ Sub-screens (detail/add/edit) needed

### 3.3 Hive Products (Harvest Logging)
- **File:** `lib/features/hive_products/view/hive_products_screen.dart`
- **Route:** `/hive-products`
- **Flow:**
  ```
  Product List → Add Harvest Entry → Quality Grade → Yield Summary
  ```
- **Status:** ✅ Main screen exists | ⚠️ Add/edit forms needed

### 3.4 Bee Health Monitoring
- **File:** `lib/features/bee_health/view/bee_health_screen.dart`
- **Route:** `/bee-health`
- **Flow:**
  ```
  Health Dashboard → Disease Detection → Symptom Checker → Treatment Log
  ```
- **Status:** ✅ Main screen exists | ⚠️ Detailed sub-flows needed

### 3.5 Best Practices
- **File:** `lib/features/best_practices/view/best_practices_screen.dart`
- **Route:** `/best-practices`
- **Content:** Educational cards, seasonal guides, video tutorials
- **Status:** ✅ Implemented

### 3.6 Calendar & Scheduling
- **File:** `lib/features/calendar/view/calendar_screen.dart`
- **Route:** `/calendar`
- **Flow:**
  ```
  Monthly View → Day Tasks → Add/Edit Task → Inspection Reminders
  ```
- **Status:** ✅ Implemented

### 3.7 Migration Tracking
- **File:** `lib/features/migration/view/migration_screen.dart`
- **Route:** `/migration`
- **Flow:**
  ```
  Migration Map → Active Routes → Log Migration → Historical Data
  ```
- **Status:** ✅ Main screen exists

### 3.8 Products Sale
- **File:** `lib/features/products_sale/view/products_sale_screen.dart`
- **Route:** `/products-sale`
- **Flow:**
  ```
  My Listings → Add Product → Set Price/Quantity → Publish to Marketplace
  ```
- **Status:** ✅ Main screen exists

### 3.9 Alerts & Notifications
- **File:** `lib/features/alert/view/alert_screen.dart`
- **Route:** `/alert`
- **Status:** ✅ Implemented

### 3.10 Flora Mapping
- **File:** `lib/features/flora/view/flora_screen.dart`
- **Route:** `/flora`
- **Flow:**
  ```
  Flora Map → Bloom Calendar → Nectar Sources → Optimal Locations
  ```
- **Status:** ✅ Implemented

### 3.11 Camera (AI Inspection)
- **File:** `lib/features/camera/view/camera_screen.dart`
- **Route:** `/camera`
- **Status:** ✅ Implemented

### 3.12 Location Services
- **File:** `lib/features/location/view/location_screen.dart`
- **Route:** `/location`
- **Status:** ✅ Implemented

### 3.13 Chat Support
- **File:** `lib/features/chat_support/view/chat_support_screen.dart`
- **Route:** `/chat-support`
- **Status:** ✅ Implemented

### 3.14 Beekeeper Profile
- **File:** `lib/features/beekeeper_profile/view/beekeeper_profile_screen.dart`
- **Route:** `/beekeeper-profile`
- **Status:** ✅ Implemented

### 3.15 More / Settings
- **Files:** `lib/features/more/view/more_screen.dart`, `lib/features/settings/view/settings_screen.dart`
- **Routes:** `/more`, `/settings`
- **Status:** ✅ Implemented

---

## 4. 🍯 Honey Collector Role

Dedicated flow for wild honey collectors with geotagging and FPO submission.

### 4.1 Harvest Log (Home)
- **File:** `lib/features/wild_harvest/view/harvest_log_screen.dart`
- **Route:** `/harvest-log`
- **Flow:**
  ```
  Harvest Log List → [Add New Harvest] → Geotag Camera → Harvest Detail → FPO Submit
  ```
- **Status:** ✅ Implemented

### 4.2 Geotag Camera
- **File:** `lib/features/wild_harvest/view/geotag_camera_screen.dart`
- **Route:** `/geotag-camera`
- **Behavior:** GPS-tagged photo capture for harvest location verification
- **Status:** ✅ Implemented

### 4.3 Harvest Detail
- **File:** `lib/features/wild_harvest/view/harvest_detail_screen.dart`
- **Route:** `/harvest-detail`
- **Fields:** Type, Weight, Location, Photos, Quality Notes
- **Status:** ✅ Implemented

### 4.4 FPO Submit
- **File:** `lib/features/wild_harvest/view/fpo_submit_screen.dart`
- **Route:** `/fpo-submit`
- **Behavior:** Submit harvest data to associated FPO for verification
- **Status:** ✅ Implemented

### 4.5 Digital ID
- **File:** `lib/features/wild_harvest/view/digital_id_screen.dart`
- **Route:** `/digital-id`
- **Behavior:** QR-based digital identity card for the collector
- **Status:** ✅ Implemented

### 4.6 Collector Flow Diagram
```
┌──────────────────────────────────────────────────────────┐
│                  Honey Collector Home                     │
│                   (Harvest Log)                          │
├──────────┬───────────┬──────────────┬───────────────────┤
│ New      │ Geotag    │ Harvest      │ Digital           │
│ Harvest  │ Camera    │ Detail       │ ID Card           │
│          │ (GPS+     │ (Type/Wt/    │ (QR Code)         │
│          │  Photo)   │  Quality)    │                   │
├──────────┴───────────┴──────┬───────┴───────────────────┤
│                             ▼                            │
│                    FPO Submit Screen                      │
│               (Send to cooperative)                      │
└──────────────────────────────────────────────────────────┘
```

---

## 5. 🛒 B2B Buyer / Retailer Role

*(From flow diagram — new screens needed)*

### 5.1 Buyer Dashboard
- **Route:** `/marketplace` (currently used as entry point)
- **Sections:**
  - Brands & Featured FPOs
  - Recommended Products
  - Recent Orders
  - Quick Buttons: Browse / Bulk Enquiry / My Orders
  - Product Categories
- **Status:** ⚠️ Marketplace screen exists but needs Dashboard redesign for buyer role

### 5.2 Product Discovery
- **Flow:**
  ```
  Product Categories → Filtered Product List → Product Detail
  → Price Preview / Traceability / Quality
  → Add to Cart / Contact FPO
  ```
- **Existing screens:**
  - `marketplace_screen.dart` ✅
  - `product_detail_screen.dart` ✅
- **Missing screens:**
  - Product Categories browser ❌
  - Filtered Product List ❌
  - Price Preview / Traceability view ❌

### 5.3 Procurement Flow
- **Flow:**
  ```
  Cart → Shipping & Buyer Details → Payment Screen → Order Confirmation
  ```
- **Existing screens:**
  - `checkout_screen.dart` ✅
- **Missing screens:**
  - Cart screen ❌
  - Shipping / Buyer details ❌
  - Payment screen ❌
  - Order confirmation ❌

### 5.4 Bulk & Supplier Management
- **Flow:**
  ```
  Orders List → Order Detail (Track / Download Invoice)
  Bulk Enquiry Form
  Saved Suppliers → Supplier Profile & Chat
  ```
- **Status:** ❌ Not yet implemented

---

## 6. 🏛️ FPO / Cooperative Admin Role

*(From flow diagram — partially exists, needs expansion)*

### 6.1 FPO Dashboard
- **File:** `lib/features/fpo_admin/view/fpo_dashboard_screen.dart`
- **Route:** `/fpo-dashboard`
- **Existing Sections:**
  - Stat cards: Active Members (482), Pending Approvals (14), Monthly Yield, Revenue
  - Recent Activity feed
- **Required by flow diagram:**
  - Total Members / Colonies / Harvest (Kg) ✅
  - Pending Approvals ✅
  - Alerts & Notifications ⚠️ (partial)
- **Status:** ✅ Core dashboard exists

### 6.2 Member Management
- **Existing:**
  - `fpo_members_screen.dart` ✅ (Member list)
  - `fpo_approval_screen.dart` ✅ (Approval queue)
- **Required by flow diagram:**
  ```
  Member List → Member Detail → Tabs: Profile / Apiaries / Harvests / Payments
  → View Apiary Detail Metrics
  ```
- **Missing:** Member Detail screen with tabbed view ❌

### 6.3 Stock & Listings
- **Required by flow diagram:**
  ```
  Aggregated Harvest & Stock
  Listing Approval Queue → Listing Detail (Approve/Reject/Edit)
  Bulk Approval Screen
  ```
- **Status:** ❌ Not yet implemented

### 6.4 Reports & Communication
- **Existing:**
  - `fpo_broadcast_screen.dart` ✅ (Broadcast/Advisory Composer)
- **Required by flow diagram:**
  ```
  Reports Center (Harvest / Income / Incidents) → Export PDF / Excel
  Broadcast / Advisory Composer ✅
  ```
- **Missing:** Reports Center with export functionality ❌

### 6.5 FPO Admin Flow Diagram
```
┌─────────────────────────────────────────────────────────────────────┐
│                      FPO / Cooperative Admin                        │
├───────────┬────────────────┬──────────────┬────────────────────────┤
│ Dashboard │ Member Mgmt    │ Stock &      │ Reports &              │
│           │                │ Listings     │ Communication          │
├───────────┤                │              │                        │
│ • Members │ Member List    │ Aggregated   │ Reports Center         │
│ • Colonies│   → Detail     │ Harvest &    │ (Harvest/Income/       │
│ • Harvest │   → Tabs:      │ Stock        │  Incidents)            │
│ • Pending │     Profile    │              │   → Export PDF/Excel   │
│   Approvals│    Apiaries   │ Listing      │                        │
│ • Alerts  │     Harvests   │ Approval     │ Broadcast / Advisory   │
│           │     Payments   │ Queue        │ Composer               │
│           │   → Apiary     │  → Detail    │                        │
│           │     Metrics    │  → Bulk      │                        │
│           │                │    Approve   │                        │
└───────────┴────────────────┴──────────────┴────────────────────────┘
```

---

## 7. 🔭 Extension / Government Officer Role

*(From flow diagram — minimal screens exist, needs major expansion)*

### 7.1 Officer Dashboard
- **Entry:** `/alert-feed` (currently FieldOfficerAlertsScreen)
- **Required by flow diagram:**
  - Registered Beekeepers count
  - Active Programs count
  - Open Incidents count
  - Block / Taluka Schedule
- **Status:** ⚠️ Alert feed exists, full dashboard needed

### 7.2 Scheme Monitoring
- **Flow:**
  ```
  Scheme Beneficiary List → Beneficiary Details → Filter FPO / Colony / Documentation
  ```
- **Status:** ❌ Not yet implemented

### 7.3 Feedback & Field Visits
- **Flow:**
  ```
  Incident Map (Live by region/disease/priority) → Incident Detail
  → Change Status / Add Notes / Escalate

  Field Visit Planner → Field Visit Details / Log Form
  → Generate GPS / Show GPS
  ```
- **Existing:**
  - `field_officer_map_screen.dart` ✅ (basic map view)
  - `field_officer_alerts_screen.dart` ✅ (basic alert list)
- **Missing:** Incident detail, field visit planner, log form ❌

### 7.4 Reports & Analytics
- **Flow:**
  ```
  Disease Trends / Scheme Coverage / Growth Metrics
  → Export & Share Statistics
  Heatmaps / Infographics
  ```
- **Status:** ❌ Not yet implemented

### 7.5 Government Officer Flow Diagram
```
┌──────────────────────────────────────────────────────────────────────┐
│               Extension / Government Officer Role                    │
├──────────────┬─────────────────┬───────────────────┬────────────────┤
│ Dashboard    │ Scheme          │ Feedback &        │ Reports &      │
│              │ Monitoring      │ Field Visits      │ Analytics      │
├──────────────┤                 │                   │                │
│ • Beekeepers │ Beneficiary     │ Incident Map      │ Disease Trends │
│ • Programs   │ List            │ (Live by region/  │ Scheme Coverage│
│ • Incidents  │  → Details      │  disease/priority)│ Growth Metrics │
│ • Schedule   │  → Filter FPO/ │  → Incident Detail│  → Export &    │
│              │    Colony/Docs  │  → Change Status  │    Share Stats │
│              │                 │                   │                │
│              │                 │ Field Visit       │ Heatmaps /     │
│              │                 │ Planner           │ Infographics   │
│              │                 │  → Visit Log Form │                │
│              │                 │  → GPS Tracking   │                │
└──────────────┴─────────────────┴───────────────────┴────────────────┘
```

---

## 8. Shared / Cross-Cutting Modules

These modules are shared across roles or used as utility features:

| Module | File | Route | Used By |
|--------|------|-------|---------|
| Chat Support | `chat_support_screen.dart` | `/chat-support` | All roles |
| Settings | `settings_screen.dart` | `/settings` | All roles |
| More | `more_screen.dart` | `/more` | Beekeeper |
| Camera | `camera_screen.dart` | `/camera` | Beekeeper, Collector |
| Location | `location_screen.dart` | `/location` | Beekeeper, Collector, Officer |
| Alerts | `alert_screen.dart` | `/alert` | Beekeeper, Officer |

---

## 9. Navigation Architecture

### 9.1 Router Config
- **File:** `lib/core/router/app_router.dart`
- **Engine:** `go_router` (flat route structure, no nested shells)
- **Total routes defined:** 32

### 9.2 Bottom Navigation (Beekeeper)
- **Widget:** `NightHiveNav` (custom bottom bar — pure black with amber accents)
- **Tabs:** Home (🏠) | Apiary (🐝) | Calendar (📅) | Market (🏪) | Profile (👤)

### 9.3 Route Table

| Route | Screen | Role(s) |
|-------|--------|---------|
| `/` | SplashScreen | All |
| `/language` | LanguageScreen | All |
| `/login` | PhoneLoginScreen | All |
| `/otp` | OtpScreen | All |
| `/profile-setup` | ProfileSetupScreen | All |
| `/home` | HomeScreen | Beekeeper |
| `/apiary` | ApiaryScreen | Beekeeper |
| `/hive-products` | HiveProductsScreen | Beekeeper |
| `/best-practices` | BestPracticesScreen | Beekeeper |
| `/calendar` | CalendarScreen | Beekeeper |
| `/migration` | MigrationScreen | Beekeeper |
| `/products-sale` | ProductsSaleScreen | Beekeeper |
| `/alert` | AlertScreen | Beekeeper |
| `/flora` | FloraScreen | Beekeeper |
| `/camera` | CameraScreen | Beekeeper |
| `/location` | LocationScreen | Beekeeper |
| `/bee-health` | BeeHealthScreen | Beekeeper |
| `/chat-support` | ChatSupportScreen | All |
| `/beekeeper-profile` | BeekeeperProfileScreen | Beekeeper |
| `/more` | MoreScreen | Beekeeper |
| `/settings` | SettingsScreen | All |
| `/harvest-log` | HarvestLogScreen | Collector |
| `/geotag-camera` | GeotagCameraScreen | Collector |
| `/harvest-detail` | HarvestDetailScreen | Collector |
| `/fpo-submit` | FpoSubmitScreen | Collector |
| `/digital-id` | DigitalIdScreen | Collector |
| `/marketplace` | MarketplaceScreen | Buyer |
| `/product-detail` | ProductDetailScreen | Buyer |
| `/checkout` | CheckoutScreen | Buyer |
| `/fpo-dashboard` | FpoDashboardScreen | FPO Admin |
| `/fpo-members` | FpoMembersScreen | FPO Admin |
| `/fpo-approval` | FpoApprovalScreen | FPO Admin |
| `/fpo-broadcast` | FpoBroadcastScreen | FPO Admin |
| `/alert-feed` | FieldOfficerAlertsScreen | Field Officer |
| `/district-map` | FieldOfficerMapScreen | Field Officer |

---

## 10. Design System Tokens

### 10.1 Color Palette

| Token | Hex | Usage |
|-------|-----|-------|
| `primary` | `#8C4F00` | Honey Amber — primary actions |
| `primaryContainer` | `#F7941D` | Bright amber — active states |
| `secondary` | `#1D6C2E` | Forest Green — growth/health |
| `tertiary` | `#F59B00` | Beeswax Gold — highlights |
| `error` | `#D64045` | Destructive actions & alerts |
| `background` | `#F5F2ED` | Page background (warm paper) |
| `surface` | `#FFFFFF` | Card/component surface |
| `surfaceVariant` | `#F3EDE3` | Muted surface |
| `govtTeal` | `#0E7490` | Government/extension role |
| `buyerBlue` | `#1967D2` | Buyer role accent |
| `fpoPurple` | `#6B21A8` | FPO Admin role accent |
| `fieldOfficerRed` | `#D64045` | Field Officer role accent |

### 10.2 Typography

| Token | Font | Size | Weight |
|-------|------|------|--------|
| Display | Poppins | 36-57px | Regular |
| Headline | Poppins | 24-32px | SemiBold/Bold |
| Title | Poppins/Noto Sans | 14-22px | Medium/SemiBold |
| Body | Noto Sans | 12-16px | Regular |
| Label | Roboto Mono | 11-14px | Medium/SemiBold |
| Stat Value | Roboto Mono | 28px | Bold |

### 10.3 Spacing Scale

Base unit: **4px**
```
xs=4  sm=8  md=12  lg=16  xl=20  xxl=24  xxxl=32  huge=40  giant=48  massive=64
```

### 10.4 Core Widgets

| Widget | File | Purpose |
|--------|------|---------|
| `AppButton` | `app_button.dart` | Primary CTA with loading state |
| `AppHeader` | `app_header.dart` | Custom AppBar with subtitle |
| `AppInput` | `app_input.dart` | Styled text input with label |
| `NightHiveNav` | `night_hive_nav.dart` | Pure black bottom navigation |
| `OfflineSyncBar` | `offline_sync_bar.dart` | Connectivity status indicator |
| `SectionTitle` | `section_title.dart` | Section header with trailing action |

---

## 11. Gap Analysis — Existing vs. Required

### Summary

| Role | Required Screens | Existing | Missing | Completion |
|------|-----------------|----------|---------|------------|
| Onboarding | 5 | 5 | 0 | **100%** |
| Beekeeper | 15 | 15 | 0 | **100%** |
| Honey Collector | 5 | 5 | 0 | **100%** |
| B2B Buyer | 10 | 3 | 7 | **30%** |
| FPO Admin | 10 | 4 | 6 | **40%** |
| Gov Officer | 10 | 2 | 8 | **20%** |
| **TOTAL** | **55** | **34** | **21** | **62%** |

### Detailed Missing Screens

#### B2B Buyer Role (7 screens needed)
1. `buyer_dashboard_screen.dart` — Dashboard with FPOs, recommended products, recent orders
2. `product_categories_screen.dart` — Category browser with filters
3. `filtered_products_screen.dart` — Filtered product listing
4. `cart_screen.dart` — Shopping cart
5. `shipping_details_screen.dart` — Shipping & buyer information form
6. `payment_screen.dart` — Payment processing
7. `order_confirmation_screen.dart` — Order confirmation with tracking
8. `orders_list_screen.dart` — Order history with status tracking
9. `bulk_enquiry_screen.dart` — Bulk purchase enquiry form
10. `supplier_profile_screen.dart` — Supplier details & chat

#### FPO Admin Role (6 screens needed)
1. `member_detail_screen.dart` — Tabbed member view (Profile/Apiaries/Harvests/Payments)
2. `apiary_metrics_screen.dart` — Per-member apiary statistics
3. `stock_listings_screen.dart` — Aggregated harvest & stock view
4. `listing_detail_screen.dart` — Approve/Reject/Edit marketplace listing
5. `bulk_approval_screen.dart` — Batch approve/reject listings
6. `reports_center_screen.dart` — Reports with PDF/Excel export

#### Government Officer Role (8 screens needed)
1. `officer_dashboard_screen.dart` — Full dashboard with KPIs
2. `scheme_beneficiary_list_screen.dart` — Beneficiary listing with filters
3. `beneficiary_detail_screen.dart` — Individual beneficiary details
4. `incident_map_screen.dart` — Live incident map (by region/disease/priority)
5. `incident_detail_screen.dart` — Incident status, notes, escalation
6. `field_visit_planner_screen.dart` — Visit scheduling
7. `field_visit_log_screen.dart` — Visit log form with GPS
8. `officer_reports_screen.dart` — Disease trends, heatmaps, export

---

> **Next Steps:**
> 1. Implement missing Buyer screens (7 screens)
> 2. Implement missing FPO Admin screens (6 screens)
> 3. Implement missing Government Officer screens (8 screens)
> 4. Add BLoC/Cubit state management layers for new features
> 5. Wire API integration via Retrofit
> 6. Add comprehensive unit & widget tests

---

*Document generated on April 29, 2026*
